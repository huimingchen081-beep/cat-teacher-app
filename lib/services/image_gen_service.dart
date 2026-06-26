/// 图片生成服务 — 火山引擎 ARK API (doubao-seedream)
/// 直接用 HTTP 调用，无云函数中转
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class ImageGenResult {
  final String? url;      // 图片URL（直接可用）
  final String? base64;   // base64数据（备用）
  final bool success;
  final String? error;

  const ImageGenResult({this.url, this.base64, required this.success, this.error});
}

class ImageGenService {
  static final ImageGenService _instance = ImageGenService._();
  factory ImageGenService() => _instance;
  ImageGenService._();

  // 火山引擎 ARK 图像生成端点
  static const String _endpoint =
      'https://ark.cn-beijing.volces.com/api/v3/images/generations';

  // 模型：doubao-seedream
  static const String _model = 'doubao-seedream-5-0-260128';

  /// 文生图 — 给定提示词，返回生成的图片
  Future<ImageGenResult> generate(String prompt) async {
    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${ApiConfig.arkKey}',
            },
            body: jsonEncode({
              'model': _model,
              'prompt': prompt,
              'n': 1,
              'size': '1024x1024',
              'response_format': 'b64_json',
            }),
          )
          .timeout(const Duration(seconds: 45));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final images = data['data'] as List?;
        if (images != null && images.isNotEmpty) {
          final b64 = images[0]['b64_json'] as String?;
          if (b64 != null && b64.isNotEmpty) {
            return ImageGenResult(base64: b64, success: true);
          }
          final url = images[0]['url'] as String?;
          if (url != null) {
            return ImageGenResult(url: url, success: true);
          }
        }
        return const ImageGenResult(success: false, error: '生成成功但未返回图片');
      }

      // 错误处理
      String errMsg = '生成失败(HTTP ${response.statusCode})';
      try {
        final err = jsonDecode(response.body);
        errMsg = err['error']?['message'] ?? err['message'] ?? errMsg;
      } catch (_) {}
      return ImageGenResult(success: false, error: errMsg);
    } catch (e) {
      return ImageGenResult(success: false, error: '网络错误: $e');
    }
  }

  /// 将base64图片保存到本地文件
  Future<String?> saveBase64ToFile(String base64Data) async {
    try {
      final bytes = base64Decode(_cleanBase64(base64Data));
      final dir = Directory.systemTemp;
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/cat_gen_image_$timestamp.png');
      await file.writeAsBytes(bytes);
      return file.path;
    } catch (e) {
      return null;
    }
  }

  String _cleanBase64(String data) {
    if (data.contains(',')) {
      return data.split(',').last;
    }
    return data;
  }
}
