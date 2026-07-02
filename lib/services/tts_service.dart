/// DashScope CosyVoice v3 语音合成服务
/// API 文档: https://help.aliyun.com/zh/model-studio/non-realtime-cosyvoice-api
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../utils/text_cleaner.dart';

class TtsService {
  static final TtsService _instance = TtsService._();
  factory TtsService() => _instance;
  TtsService._();

  /// 将文本转为语音，返回本地MP3文件路径
  /// [text] 要合成的文本
  /// [dir] 保存目录，默认系统临时目录
  Future<String?> textToSpeech(
    String text, {
    String? dir,
  }) async {
    final cleanText = prepareText(text);
    if (cleanText.isEmpty) return null;
    return await synthesizeChunk(cleanText, dir: dir);
  }

  /// 准备文本：清洗 Markdown/LaTeX/特殊符号 → 适合 TTS 朗读的纯文本
  String prepareText(String text) {
    return TextCleaner.cleanForTts(text);
  }

  /// 将长文本按句号/问号/感叹号等自然断点切分成段，每段不超过 maxLen 字
  List<String> chunkText(String text, {int maxLen = 200}) {
    if (text.length <= maxLen) return [text];

    final chunks = <String>[];
    var remaining = text;

    while (remaining.isNotEmpty) {
      if (remaining.length <= maxLen) {
        chunks.add(remaining.trim());
        break;
      }

      // 在 maxLen 范围内找最佳断点（优先级：。！？；，）
      var cut = -1;
      for (final sep in ['。', '！', '？', '；', '，']) {
        final idx = remaining.lastIndexOf(sep, maxLen);
        if (idx > cut && idx > maxLen * 0.4) cut = idx;
      }
      // 如果找不到合适断点，硬切
      if (cut <= maxLen * 0.3) cut = maxLen;

      chunks.add(remaining.substring(0, cut + 1).trim());
      remaining = remaining.substring(cut + 1).trim();
    }

    return chunks.where((c) => c.isNotEmpty).toList();
  }

  /// 将长文本分段合成语音，返回所有音频文件路径（用于完整播报）
  Future<List<String>> textToSpeechSegments(String text, {String? dir}) async {
    final cleanText = prepareText(text);
    if (cleanText.isEmpty) return [];

    final chunks = chunkText(cleanText);
    final results = <String>[];

    for (var i = 0; i < chunks.length; i++) {
      final filePath = await synthesizeChunk(chunks[i], dir: dir);
      if (filePath != null) {
        results.add(filePath);
      } else {
        print('[TTS] 分段${i + 1}/${chunks.length}合成失败，跳过');
      }
    }

    return results;
  }

  /// 将单个文本片段调API合成语音（不重复清洗，假定传入已清洗文本）
  Future<String?> synthesizeChunk(String cleanText, {String? dir}) async {
    if (cleanText.isEmpty) return null;

    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.ttsEndpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${ApiConfig.dashScopeKey}',
            },
            body: jsonEncode({
              'model': ApiConfig.ttsModel,
              'input': {
                'text': cleanText,
                'voice': ApiConfig.ttsVoice,
                'format': 'mp3',
                'sample_rate': 24000,
                'volume': 50,
                'rate': 1.0,
                'pitch': 1.0,
              },
            }),
          )
          .timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // CosyVoice v3 非流式 API: 音频在 output.audio.url
        final audioUrl = data['output']?['audio']?['url'] as String?;
        if (audioUrl != null && audioUrl.isNotEmpty) {
          return await _downloadAudio(audioUrl, dir);
        }

        // 回退: 流式返回时有 output.audio.data (base64)
        final audioData = data['output']?['audio']?['data'] as String?;
        if (audioData != null && audioData.isNotEmpty) {
          return await _saveBase64Audio(audioData, dir);
        }

        print('[TTS] 无法解析音频响应: ${response.body.substring(0, 300)}');
        return null;
      }

      print('[TTS] API 错误 HTTP ${response.statusCode}: ${response.body.substring(0, 300)}');
      return null;
    } catch (e) {
      print('[TTS] 网络错误: $e');
      return null;
    }
  }

  /// 下载远程音频文件（带超时重试 + 完整性校验）
  Future<String?> _downloadAudio(String url, String? dir) async {
    for (var attempt = 1; attempt <= 2; attempt++) {
      try {
        final response = await http
            .get(Uri.parse(url))
            .timeout(const Duration(seconds: 45)); // 增加到45s

        if (response.statusCode == 200 && response.bodyBytes.length > 200) {
          // 校验：音频文件至少200字节才算有效
          return await _saveAudioBytes(response.bodyBytes, dir);
        }
        if (response.statusCode == 200 && response.bodyBytes.length <= 200) {
          print('[TTS] 音频文件过小 (${response.bodyBytes.length} bytes)，可能截断');
        }
        if (response.statusCode != 200) {
          print('[TTS] 下载音频失败: HTTP ${response.statusCode}');
        }
      } catch (e) {
        print('[TTS] 下载异常(尝试$attempt/2): $e');
        if (attempt < 2) await Future.delayed(const Duration(seconds: 1));
      }
    }
    return null;
  }

  /// 保存 base64 编码的音频数据
  Future<String?> _saveBase64Audio(String base64Data, String? dir) async {
    try {
      final bytes = base64Decode(base64Data);
      return await _saveAudioBytes(bytes, dir);
    } catch (e) {
      print('[TTS] Base64解析失败: $e');
      return null;
    }
  }

  /// 保存音频字节到文件
  Future<String> _saveAudioBytes(List<int> bytes, String? dir) async {
    final saveDir = dir ?? Directory.systemTemp.path;
    final dirObj = Directory(saveDir);
    if (!await dirObj.exists()) {
      await dirObj.create(recursive: true);
    }
    final fileName = 'cat_tts_${DateTime.now().millisecondsSinceEpoch}.mp3';
    final file = File('${dirObj.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  /// 清理超过24小时的TTS临时文件，防止存储堆积
  static Future<void> cleanupOldFiles({Duration maxAge = const Duration(hours: 24)}) async {
    try {
      final dir = Directory(Directory.systemTemp.path);
      if (!await dir.exists()) return;

      final now = DateTime.now();
      await for (final entity in dir.list()) {
        if (entity is File && entity.path.contains('cat_tts_')) {
          final stat = await entity.stat();
          if (now.difference(stat.modified).compareTo(maxAge) > 0) {
            await entity.delete();
          }
        }
      }
    } catch (_) {
      // 静默失败，清理不是关键功能
    }
  }
}
