/// 聊天页面 - AI对话 + 讲课模式 + 拍照扫描 + 语音输入 + 生图/生视频/文档生成
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../config/points_config.dart';
import '../models/textbook.dart';
import '../providers/app_state.dart';
import '../services/dashscope_service.dart';
import '../services/tts_service.dart';
import '../services/intent_detector.dart';
import '../services/tsundere_responses.dart';
import '../services/image_gen_service.dart';
import '../services/doc_gen_service.dart';
import '../utils/text_cleaner.dart';
import '../widgets/generation_result_card.dart';
import 'lecture_page.dart';
import 'package:audioplayers/audioplayers.dart';

class ChatPage extends StatefulWidget {
  final String? subject;
  final ChatMode? initialMode;
  final LectureContext? lectureContext;

  const ChatPage({super.key, this.subject, this.initialMode, this.lectureContext});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  final _messages = <ChatMessage>[];
  final _picker = ImagePicker();
  final _audioRecorder = AudioRecorder();
  final _audioPlayer = AudioPlayer();
  bool _isLoading = false;
  bool _isRecording = false;
  String? _pickedImagePath;
  LectureContext? _lectureContext;
  String? _playingTtsFor; // 正在播放TTS的消息ID（用文本hash标识）
  StreamSubscription<void>? _ttsCompletionSub; // 当前分段播放完成监听
  bool _autoPlayTts = true; // 自动播报语音（默认开启，豆包式体验）

  @override
  void initState() {
    super.initState();
    final appState = context.read<AppState>();
    _lectureContext = widget.lectureContext;

    // 加载自动播报设置
    SharedPreferences.getInstance().then((prefs) {
      if (mounted) {
        setState(() => _autoPlayTts = prefs.getBool('autoPlayTts') ?? true);
      }
    });

    if (widget.initialMode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.setChatMode(widget.initialMode!);
      });
    }
    if (widget.subject != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        appState.selectSubject(widget.subject);
      });
    }

    if (_lectureContext != null) {
      _messages.add(ChatMessage(
        text: _buildLectureSystemMessage(appState),
        isUser: false,
        isSystem: true,
      ));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startAutoLecture(appState);
      });
    } else {
      _messages.add(ChatMessage(
        text: _getWelcomeMessage(appState),
        isUser: false,
      ));
    }
  }

  String _getWelcomeMessage(AppState state) {
    if (state.chatMode == ChatMode.lecture) {
      return '喵~ 我是猫咪老师！\n请告诉我你要讲什么内容，我马上准备一堂精彩的${state.grade.label}课程！';
    }
    if (state.selectedSubject != null) {
      final sub = state.subjects.firstWhere((s) => s.key == state.selectedSubject);
      return '喵~ 我是猫咪老师！\n我是你专属的${state.grade.label}${sub.name}辅导老师，有什么问题尽管问我吧！';
    }
    return '喵~ 我是猫咪老师！\n我是你专属的${state.grade.label}全能学习助手，选一科开始学习吧！';
  }

  String _buildLectureSystemMessage(AppState state) {
    final ctx = _lectureContext!;
    final subName = state.selectedSubject != null
        ? state.subjects.firstWhere((s) => s.key == state.selectedSubject).name
        : '';
    return '🎓 讲课模式已就绪\n'
        '📚 ${ctx.version} · ${ctx.semester}\n'
        '📖 ${ctx.unitTitle} ${ctx.unitLabel}\n'
        '📝 课文：${ctx.lessonTitle}\n'
        '━━━━━━━━━━━━\n'
        '猫咪老师正在准备${subName}课程...';
  }

  Future<void> _startAutoLecture(AppState state) async {
    final ctx = _lectureContext!;
    final subName = state.selectedSubject != null
        ? state.subjects.firstWhere((s) => s.key == state.selectedSubject).name
        : null;

    setState(() => _isLoading = true);

    String reply;
    try {
      reply = await DashScopeService().lectureWithContext(
        grade: state.grade.label,
        subject: subName,
        context: ctx,
      );
      state.incrementLectures();
    } catch (e) {
      reply = '喵~ 猫咪老师备课遇到了一点问题，请再试一次吧！';
    }

    if (!mounted) return;

    setState(() {
      _messages.add(ChatMessage(text: reply, isUser: false));
      _isLoading = false;
    });
    _scrollToBottom();
    _saveChatHistory();

    // 自动播报（豆包式体验）
    if (_autoPlayTts) {
      _playTts(reply);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// 保存对话到历史记录
  Future<void> _saveChatHistory() async {
    final conversational = _messages.where((m) => !m.isSystem).toList();
    if (conversational.isEmpty) return;

    final prefs = await SharedPreferences.getInstance();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    // 取最后10轮对话
    final recent = conversational.length > 20
        ? conversational.sublist(conversational.length - 20)
        : conversational;
    final texts = recent.map((m) => '${m.isUser ? "Q" : "A"}: ${m.text}').toList();
    await prefs.setStringList('chat_history_$timestamp', texts);

    // 保留最近50条历史
    final allKeys = prefs.getKeys().where((k) => k.startsWith('chat_history_')).toList()
      ..sort((a, b) => b.compareTo(a));
    if (allKeys.length > 50) {
      for (final key in allKeys.sublist(50)) {
        await prefs.remove(key);
      }
    }
  }

  // ==================== 消息发送 ====================

  Future<void> _sendMessage({String? forceText}) async {
    final text = forceText ?? _inputController.text.trim();
    final hasImage = _pickedImagePath != null;

    if (text.isEmpty && !hasImage) return;
    if (_isLoading) return;

    // ============ ⭐ 步骤0: 检测生成意图 ⭐ ============
    if (!hasImage) {
      final genIntent = IntentDetector.detect(text);
      if (genIntent != null) {
        _handleGeneration(text, genIntent);
        return;
      }
    }

    // 以下是普通对话/讲课题的原有逻辑
    final appState = context.read<AppState>();
    final grade = appState.grade.label;
    final subject = appState.selectedSubject != null
        ? appState.subjects.firstWhere((s) => s.key == appState.selectedSubject).name
        : null;

    // 构建用户消息
    final userMsgText = hasImage
        ? (text.isNotEmpty ? '$text\n[📷 图片已附加]' : '[📷 查看图片]')
        : text;

    setState(() {
      _messages.add(ChatMessage(
        text: userMsgText,
        isUser: true,
        imagePath: _pickedImagePath,
      ));
      _isLoading = true;
    });
    _inputController.clear();
    final pickedImage = _pickedImagePath;
    _pickedImagePath = null;
    _scrollToBottom();

    final history = _buildHistory();

    String reply;
    try {
      if (pickedImage != null) {
        // 拍照扫描模式：多模态识别
        reply = await DashScopeService().scanWithImage(
          grade: grade,
          subject: subject,
          imageFile: File(pickedImage),
          userMessage: text.isNotEmpty ? text : null,
        );
        appState.incrementQuestions();
      } else if (appState.chatMode == ChatMode.lecture) {
        reply = await DashScopeService().lectureWithContext(
          grade: grade,
          subject: subject,
          context: _lectureContext,
          message: text,
          history: history,
        );
        appState.incrementLectures();
      } else {
        reply = await DashScopeService().ask(
          grade: grade,
          subject: subject,
          message: text,
          history: history,
        );
        appState.incrementQuestions();
      }
    } catch (e) {
      reply = '喵~ 猫咪老师脑子有点乱，请再试一次吧！';
    }

    if (!mounted) return;

    setState(() {
      _messages.add(ChatMessage(text: reply, isUser: false));
      _isLoading = false;
    });
    _scrollToBottom();
    _saveChatHistory();

    // 自动播报（豆包式体验）
    if (_autoPlayTts) {
      _playTts(reply);
    }
  }

  /// ⭐ 处理生成类任务 — 生图/生视频/文档生成
  Future<void> _handleGeneration(String userText, GenerationIntent intent) async {
    // 1. 添加用户消息
    setState(() {
      _messages.add(ChatMessage(text: userText, isUser: true));
      _isLoading = true;
    });
    _inputController.clear();
    _scrollToBottom();

    // 2. 发送傲娇回应（模拟缓动效果）
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    final tsundereMsg = TsundereResponses.beforeTask(intent.type, userText);
    setState(() {
      _messages.add(ChatMessage(text: tsundereMsg, isUser: false));
      _isLoading = true; // 保持loading状态
    });
    _scrollToBottom();

    // 3. 等待一小会儿，模拟"思考中"
    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;

    // 4. 添加loading卡片
    final loadingMsgIndex = _messages.length;
    setState(() {
      _messages.add(ChatMessage(
        text: '',
        isUser: false,
        genResult: GenResult(type: GenResultType.image, isLoading: true),
      ));
    });
    _scrollToBottom();

    // 5. 执行实际生成
    switch (intent.type) {
      case GenerationType.image:
        await _doImageGen(userText, loadingMsgIndex);
        break;
      case GenerationType.video:
        // 视频生成暂未实现（需长异步流程），先展示占位
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        setState(() {
          _messages[loadingMsgIndex] = ChatMessage(
            text: '',
            isUser: false,
            genResult: GenResult(type: GenResultType.video),
          );
          _isLoading = false;
        });
        break;
      case GenerationType.ppt:
      case GenerationType.word:
      case GenerationType.excel:
        await _doDocGen(userText, intent, loadingMsgIndex);
        break;
    }

    if (!mounted) return;

    // 6. 发送完成话术
    final deliveryMsg = TsundereResponses.afterTask(intent.type);
    setState(() {
      _messages.add(ChatMessage(text: deliveryMsg, isUser: false));
      _isLoading = false;
    });
    _scrollToBottom();
    _saveChatHistory();
  }

  /// 执行图片生成
  Future<void> _doImageGen(String userText, int loadingMsgIndex) async {
    final result = await ImageGenService().generate(userText);

    if (!mounted) return;

    if (result.success && result.base64 != null) {
      final localPath = await ImageGenService().saveBase64ToFile(result.base64!);
      setState(() {
        _messages[loadingMsgIndex] = ChatMessage(
          text: '',
          isUser: false,
          genResult: GenResult(
            type: GenResultType.image,
            imagePath: localPath,
            imageBase64: result.base64,
          ),
        );
      });
    } else {
      // 生成失败
      setState(() {
        _messages[loadingMsgIndex] = ChatMessage(
          text: TsundereResponses.onError(GenerationType.image),
          isUser: false,
        );
      });
    }
  }

  /// 执行文档生成
  Future<void> _doDocGen(String userText, GenerationIntent intent, int loadingMsgIndex) async {
    DocGenResult result;
    switch (intent.type) {
      case GenerationType.ppt:
        result = await DocGenService().generatePpt(userText);
        break;
      case GenerationType.word:
        result = await DocGenService().generateWord(userText);
        break;
      case GenerationType.excel:
        result = await DocGenService().generateExcel(userText);
        break;
      default:
        return;
    }

    if (!mounted) return;

    if (result.success) {
      final genType = switch (intent.type) {
        GenerationType.ppt => GenResultType.document,
        GenerationType.word => GenResultType.document,
        GenerationType.excel => GenResultType.document,
        _ => GenResultType.document,
      };
      setState(() {
        _messages[loadingMsgIndex] = ChatMessage(
          text: '',
          isUser: false,
          genResult: GenResult(
            type: genType,
            title: result.title,
            content: result.content,
          ),
        );
      });
    } else {
      setState(() {
        _messages[loadingMsgIndex] = ChatMessage(
          text: TsundereResponses.onError(intent.type),
          isUser: false,
        );
      });
    }
  }

  /// 构建对话历史（普通聊题用）
  List<Map<String, String>> _buildHistory() {
    final conversational = _messages
        .where((m) => !m.isSystem)
        .toList();
    final recentMessages = conversational.length > 1
        ? conversational.sublist(1)
        : <ChatMessage>[];
    final limited = recentMessages.length > 20
        ? recentMessages.sublist(recentMessages.length - 20)
        : recentMessages;

    return limited.map((m) => {
      'role': m.isUser ? 'user' : 'assistant',
      'content': m.text,
    }).toList();
  }

  // ==================== 拍照扫描 ====================

  Future<void> _onTakePhoto() async {
    // 请求相机权限
    final cameraStatus = await Permission.camera.request();
    if (!cameraStatus.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要相机权限才能拍照喵~'), duration: Duration(seconds: 2)),
        );
      }
      return;
    }

    Navigator.pop(context); // 关闭底部菜单

    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (photo != null) {
        setState(() => _pickedImagePath = photo.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('拍照失败，请重试~'), duration: Duration(seconds: 2)),
        );
      }
    }
  }

  Future<void> _onPickFromGallery() async {
    final photosStatus = await Permission.photos.request();
    if (!photosStatus.isGranted) {
      // Android 13+ 用新的权限
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要相册权限才能选图喵~'), duration: Duration(seconds: 2)),
        );
      }
      return;
    }

    Navigator.pop(context);

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1920,
      );
      if (image != null) {
        setState(() => _pickedImagePath = image.path);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('选图失败，请重试~'), duration: Duration(seconds: 2)),
        );
      }
    }
  }

  void _removePickedImage() {
    setState(() => _pickedImagePath = null);
  }

  // ==================== 语音输入 ====================

  Future<void> _onStartVoice() async {
    // 检查麦克风权限
    final micStatus = await Permission.microphone.request();
    if (!micStatus.isGranted) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('需要麦克风权限才能录音喵~'), duration: Duration(seconds: 2)),
        );
      }
      return;
    }

    // 检查是否已在录音
    final isRec = await _audioRecorder.isRecording();
    if (isRec) return;

    setState(() => _isRecording = true);

    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/cat_voice_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 16000,
          numChannels: 1,
        ),
        path: filePath,
      );
    } catch (e) {
      setState(() => _isRecording = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('录音启动失败，请重试~'), duration: Duration(seconds: 2)),
        );
      }
    }
  }

  Future<void> _onStopVoice() async {
    if (!_isRecording) return;

    setState(() => _isRecording = false);

    String? filePath;
    try {
      filePath = await _audioRecorder.stop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('录音保存失败~'), duration: Duration(seconds: 2)),
        );
      }
      return;
    }

    if (filePath == null || filePath.isEmpty) return;

    // 显示语音识别中
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(children: [
            SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
            SizedBox(width: 12),
            Text('猫咪老师正在听...'),
          ]),
          duration: Duration(seconds: 60),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    final text = await DashScopeService().speechToText(File(filePath));

    // 清除SnackBar
    if (mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }

    if (text != null && text.isNotEmpty && mounted) {
      _inputController.text = text;
      _inputController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
      // 自动发送
      _sendMessage(forceText: text);
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('语音识别失败，请用文字输入喵~'), duration: Duration(seconds: 2)),
      );
    }
  }

  // ==================== TTS 语音播放（首段即刻播 + 边播边合成） ====================

  /// 边合成边播放：第一段合成完立即开播，播放同时后台合成后续段
  Future<void> _playTts(String messageText) async {
    final msgId = messageText.hashCode.toString();
    // 如果正在播放同一段，则停止
    if (_playingTtsFor == msgId) {
      await _stopTts();
      return;
    }

    // 停止当前播放
    await _stopTts();

    // ⭐ TTS单独扣费
    final appState = context.read<AppState>();
    final ttsCost = TeacherPointsConfig.getCost(TeacherTaskType.tts);
    final canAfford = await appState.spendPoints(ttsCost);
    if (!canAfford) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('喵~ 积分不足（语音播报需${ttsCost}分），去积分中心充值吧！'),
            backgroundColor: const Color(0xFFFF6B6B),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🔊 语音播报 -${ttsCost}分'),
          backgroundColor: const Color(0xFFFF8C42),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    // ⭐ 扣费结束

    // 清洗文本并分段
    final tts = TtsService();
    final chunks = _getTtsChunks(messageText, tts);
    if (chunks.isEmpty) return;

    setState(() => _playingTtsFor = msgId);

    // ⭐ 关键优化：先合成第一段 → 立即播放 → 后台异步合成后续段
    final firstPath = await tts.synthesizeChunk(chunks.first);
    if (firstPath == null || !mounted || _playingTtsFor != msgId) {
      if (mounted) setState(() => _playingTtsFor = null);
      if (firstPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('喵~ 语音生成失败，请稍后再试'), duration: Duration(seconds: 2)),
        );
      }
      return;
    }

    // 启动后台合成任务（不阻塞播放）
    final remainingFiles = <String>[];
    if (chunks.length > 1) {
      _synthesizeRemainingInBackground(tts, chunks.sublist(1), remainingFiles, msgId);
    }

    // 播放第一段
    await _playTtsFile(firstPath, msgId);
    if (!mounted || _playingTtsFor != msgId) return;

    // 逐段播放后续（此时大部分已在后台合成完毕）
    for (var i = 1; i < chunks.length; i++) {
      // 等待该段的合成完成（如果还没完成的话）
      String? path;
      var waitMs = 0;
      while (waitMs < 30000) {
        // 最多等30秒
        final idx = i - 1;
        if (idx < remainingFiles.length) {
          path = remainingFiles[idx];
          break;
        }
        await Future.delayed(const Duration(milliseconds: 500));
        waitMs += 500;
        if (!mounted || _playingTtsFor != msgId) return;
      }

      if (path != null) {
        await _playTtsFile(path, msgId);
      }
      if (!mounted || _playingTtsFor != msgId) return;
    }

    // 全部播放完毕
    if (mounted) setState(() => _playingTtsFor = null);
  }

  /// 后台异步合成剩余分段（不阻塞播放）
  void _synthesizeRemainingInBackground(
    TtsService tts,
    List<String> chunks,
    List<String> outFiles,
    String msgId,
  ) {
    Future(() async {
      for (final chunk in chunks) {
        if (_playingTtsFor != msgId) return;
        final path = await tts.synthesizeChunk(chunk);
        if (path != null) {
          outFiles.add(path);
        }
      }
    });
  }

  /// 在后台异步合成全部剩余分段（并行请求，但不阻塞）
  void _synthesizeRemainingParallel(
    TtsService tts,
    List<String> chunks,
    List<String?> outFiles,
    String msgId,
  ) {
    final futures = chunks.asMap().entries.map((entry) async {
      if (_playingTtsFor != msgId) return;
      final path = await tts.synthesizeChunk(entry.value);
      outFiles[entry.key] = path;
    });
    Future.wait(futures); // 并行请求所有分段
  }

  /// 获取TTS分段（优先使用消息内容）
  List<String> _getTtsChunks(String text, TtsService tts) {
    final cleanText = tts.prepareText(text);
    if (cleanText.isEmpty) return [];
    return tts.chunkText(cleanText);
  }

  /// 播放单个TTS音频文件，等待播放完毕
  Future<void> _playTtsFile(String filePath, String msgId) async {
    if (!mounted || _playingTtsFor != msgId) return;
    final completer = Completer<void>();
    _ttsCompletionSub?.cancel();
    _ttsCompletionSub = _audioPlayer.onPlayerComplete.listen((_) {
      if (!completer.isCompleted) completer.complete();
    });
    await _audioPlayer.play(DeviceFileSource(filePath));
    await completer.future;
  }

  Future<void> _stopTts() async {
    _ttsCompletionSub?.cancel();
    _ttsCompletionSub = null;
    await _audioPlayer.stop();
    if (mounted) setState(() => _playingTtsFor = null);
  }

  // ==================== 附件菜单 ====================

  void _showAttachMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('添加附件', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _AttachOption(
                    icon: Icons.camera_alt,
                    label: '拍照解题',
                    color: const Color(0xFFFF8C42),
                    onTap: _onTakePhoto,
                  ),
                  _AttachOption(
                    icon: Icons.photo_library,
                    label: '相册选图',
                    color: const Color(0xFF4CAF50),
                    onTap: _onPickFromGallery,
                  ),
                  _AttachOption(
                    icon: Icons.mic,
                    label: '语音输入',
                    color: const Color(0xFF2196F3),
                    onTap: () {
                      Navigator.pop(ctx);
                      _onStartVoice();
                    },
                  ),
                  _AttachOption(
                    icon: Icons.school,
                    label: '选课讲课',
                    color: const Color(0xFF9C27B0),
                    onTap: () {
                      Navigator.pop(ctx);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LecturePage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== UI ====================

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    _audioRecorder.dispose();
    _ttsCompletionSub?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('猫咪老师', style: TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // 声音开关（豆包式快捷操作）
          GestureDetector(
            onTap: () {
              setState(() => _autoPlayTts = !_autoPlayTts);
              SharedPreferences.getInstance().then(
                (p) => p.setBool('autoPlayTts', _autoPlayTts),
              );
              if (!_autoPlayTts) _stopTts();
              final ttsCost = TeacherPointsConfig.getCost(TeacherTaskType.tts);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_autoPlayTts ? '🔊 语音播报已开启（${ttsCost}分/次）' : '🔇 语音播报已关闭'),
                  duration: const Duration(seconds: 1),
                  backgroundColor: const Color(0xFFFF8C42),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(_autoPlayTts ? 40 : 70),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _autoPlayTts ? Icons.volume_up : Icons.volume_off,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: _buildModeBar(appState),
        ),
      ),
      body: Column(
        children: [
          // 图片预览条
          if (_pickedImagePath != null) _buildImagePreview(appState),
          // 消息列表
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _messages.length + (_isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length) {
                  return const _TypingIndicator();
                }
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          // 语音录制指示器
          if (_isRecording) _buildRecordingIndicator(),
          // 输入栏
          _buildInputBar(),
        ],
      ),
    );
  }

  Widget _buildImagePreview(AppState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: const Color(0xFFFFF8F0),
      child: Row(
        children: [
          const Text('📷 ', style: TextStyle(fontSize: 16)),
          const Text('点击发送识别图片', style: TextStyle(fontSize: 13, color: Color(0xFF666666))),
          const Spacer(),
          GestureDetector(
            onTap: _removePickedImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFEEEEEE)),
              child: const Icon(Icons.close, size: 16, color: Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFFFE0E0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12, height: 12,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
          ),
          const SizedBox(width: 8),
          const Text('🎤 正在录音... 松开发送', style: TextStyle(fontSize: 14, color: Color(0xFFCC0000), fontWeight: FontWeight.w500)),
          const Spacer(),
          GestureDetector(
            onTap: _onStopVoice,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('完成', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeBar(AppState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: const Color(0xFFFF8C42),
      child: Row(
        children: [
          ...ChatMode.values.map((mode) {
            final isActive = state.chatMode == mode;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => state.setChatMode(mode),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withAlpha(50),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    mode.label,
                    style: TextStyle(
                      fontSize: 13,
                      color: isActive ? const Color(0xFFFF8C42) : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          if (state.selectedSubject != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                state.subjects.firstWhere((s) => s.key == state.selectedSubject).emoji,
                style: const TextStyle(fontSize: 16),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage msg) {
    // 系统消息
    if (msg.isSystem) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFFF0E0), Color(0xFFFFE8D0)]),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFD0B0), width: 0.5),
            ),
            child: Text(
              msg.text,
              style: const TextStyle(fontSize: 13, color: Color(0xFF996633), height: 1.6),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: msg.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!msg.isUser) ...[
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFFFF0E0),
                image: DecorationImage(
                  image: AssetImage(context.read<AppState>().grade.catImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: msg.isUser ? const Color(0xFFFF8C42) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: msg.isUser ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: msg.isUser ? const Radius.circular(4) : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 4, offset: const Offset(0, 1)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ⭐ 生成结果卡片
                  if (msg.genResult != null)
                    GenerationResultCard(result: msg.genResult!),
                  // 图片预览
                  if (msg.imagePath != null && msg.genResult == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(msg.imagePath!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                    ),
                  // 文字（AI消息自动清洗 Markdown/LaTeX 符号）
                  if (msg.text.isNotEmpty)
                    Text(
                      msg.isUser ? msg.text : TextCleaner.cleanForDisplay(msg.text),
                      style: TextStyle(
                        fontSize: 14,
                        color: msg.isUser ? Colors.white : const Color(0xFF333333),
                        height: 1.5,
                      ),
                    ),
                  // 语音播放按钮（仅AI消息）
                  if (!msg.isUser && !msg.isSystem && msg.text.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _buildTtsButton(msg),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTtsButton(ChatMessage msg) {
    final msgId = msg.text.hashCode.toString();
    final isPlaying = _playingTtsFor == msgId;
    final ttsCost = TeacherPointsConfig.getCost(TeacherTaskType.tts);

    return GestureDetector(
      onTap: () => _playTts(msg.text),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isPlaying ? const Color(0xFFFF8C42).withAlpha(30) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPlaying ? Icons.volume_up : Icons.volume_up_outlined,
              size: 14,
              color: isPlaying ? const Color(0xFFFF8C42) : const Color(0xFF999999),
            ),
            const SizedBox(width: 4),
            Text(
              isPlaying ? '播放中...' : '听讲解 · ${ttsCost}分',
              style: TextStyle(
                fontSize: 11,
                color: isPlaying ? const Color(0xFFFF8C42) : const Color(0xFF999999),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      padding: EdgeInsets.only(
        left: 8, right: 8, top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Row(
        children: [
          // 附件按钮
          GestureDetector(
            onTap: _showAttachMenu,
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(Icons.add, size: 20, color: Color(0xFF666666)),
            ),
          ),
          const SizedBox(width: 6),
          // 输入框
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(19),
              ),
              child: TextField(
                controller: _inputController,
                textInputAction: TextInputAction.send,
                maxLines: null,
                minLines: 1,
                onSubmitted: (_) => _sendMessage(),
                decoration: const InputDecoration(
                  hintText: '输入问题或拍照解题...',
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFF999999)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 6),
          // 语音按钮
          GestureDetector(
            onTap: _isRecording ? _onStopVoice : _onStartVoice,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: _isRecording ? Colors.red : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                size: 20,
                color: _isRecording ? Colors.white : const Color(0xFF666666),
              ),
            ),
          ),
          const SizedBox(width: 6),
          // 发送按钮
          GestureDetector(
            onTap: _isLoading ? null : () => _sendMessage(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: _isLoading
                    ? const LinearGradient(colors: [Color(0xFF999999), Color(0xFFBBBBBB)])
                    : const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)]),
                borderRadius: BorderRadius.circular(19),
              ),
              child: const Text(
                '发送',
                style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== 数据模型 ====================

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isSystem;
  final String? imagePath;
  final GenResult? genResult;  // 生成任务结果

  ChatMessage({
    required this.text,
    required this.isUser,
    this.isSystem = false,
    this.imagePath,
    this.genResult,
  });
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFF0E0),
            ),
            child: const Icon(Icons.pets, size: 18, color: Color(0xFFFF8C42)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
              ),
            ),
            child: const Text(
              '猫咪老师正在思考...',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: color.withAlpha(25),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 28, color: color),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF666666))),
        ],
      ),
    );
  }
}
