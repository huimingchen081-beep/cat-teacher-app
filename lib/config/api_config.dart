/// API 配置 - 猫咪老师后端
class ApiConfig {
  // 腾讯轻量云服务器上的猫咪老师后端API
  static const String baseUrl = 'http://124.222.134.160/api/cat';

  // 隐私政策URL（应用商店必需）
  static const String privacyUrl = 'http://124.222.134.160/privacy';

  // DashScope - 复用万能掌柜配置
  static const String dashScopeKey = 'sk-1fb7b39e1e8b49ba8059aa13b070530e';
  static const String llmModel = 'qwen3.7-plus';
  static const String visionModel = 'qwen-vl-max';       // 多模态视觉识别
  static const String asrModel = 'paraformer-v2';         // 语音识别
  static const String ttsModel = 'cosyvoice-v3-flash';    // 语音合成(HTTP) — v1只支持WebSocket！
  static const String ttsVoice = 'longxiaochun_v3';        // 龙小淳v3 — 语音助手风格，适合猫咪老师

  // 火山引擎ARK - 生图/生视频复用万能掌柜配置
  static const String arkKey = 'ark-29ebc752-c9be-42bf-abc0-08eb244d5e5f-ef76f';

  // API 端点
  static String get llmEndpoint => 'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions';
  static String get asrEndpoint => 'https://dashscope.aliyuncs.com/api/v1/services/audio/asr/transcription';
  static String get ttsEndpoint => 'https://dashscope.aliyuncs.com/api/v1/services/audio/tts/SpeechSynthesizer';
}

/// 年级枚举
enum Grade {
  primary,
  junior,
  senior;

  String get label {
    switch (this) {
      case Grade.primary:
        return '小学';
      case Grade.junior:
        return '初中';
      case Grade.senior:
        return '高中';
    }
  }

  String get emoji {
    switch (this) {
      case Grade.primary:
        return '🌟';
      case Grade.junior:
        return '📚';
      case Grade.senior:
        return '🎓';
    }
  }

  String get catImage {
    switch (this) {
      case Grade.primary:
        return 'assets/cats/primary_cat.png';
      case Grade.junior:
        return 'assets/cats/junior_cat.png';
      case Grade.senior:
        return 'assets/cats/senior_cat.png';
    }
  }
}

/// 学科定义
class Subject {
  final String key;
  final String name;
  final String emoji;
  final List<Grade> applicableGrades;

  const Subject({
    required this.key,
    required this.name,
    required this.emoji,
    required this.applicableGrades,
  });
}

/// 所有学科配置
const List<Subject> allSubjects = [
  Subject(key: 'chinese', name: '语文', emoji: '📖', applicableGrades: [Grade.primary, Grade.junior, Grade.senior]),
  Subject(key: 'math', name: '数学', emoji: '🔢', applicableGrades: [Grade.primary, Grade.junior, Grade.senior]),
  Subject(key: 'english', name: '英语', emoji: '🌍', applicableGrades: [Grade.primary, Grade.junior, Grade.senior]),
  Subject(key: 'morality', name: '道法', emoji: '⚖️', applicableGrades: [Grade.primary, Grade.junior]),
  Subject(key: 'science', name: '科学', emoji: '🔬', applicableGrades: [Grade.primary]),
  Subject(key: 'physics', name: '物理', emoji: '⚡', applicableGrades: [Grade.junior, Grade.senior]),
  Subject(key: 'chemistry', name: '化学', emoji: '🧪', applicableGrades: [Grade.junior, Grade.senior]),
  Subject(key: 'biology', name: '生物', emoji: '🧬', applicableGrades: [Grade.junior, Grade.senior]),
  Subject(key: 'geography', name: '地理', emoji: '🌏', applicableGrades: [Grade.junior, Grade.senior]),
  Subject(key: 'history', name: '历史', emoji: '📜', applicableGrades: [Grade.junior, Grade.senior]),
  Subject(key: 'politics', name: '政治', emoji: '🏛️', applicableGrades: [Grade.senior]),
];

/// 根据年级筛选学科
List<Subject> getSubjectsForGrade(Grade grade) {
  return allSubjects.where((s) => s.applicableGrades.contains(grade)).toList();
}

/// 聊天模式
enum ChatMode {
  ask,
  lecture;

  String get label {
    switch (this) {
      case ChatMode.ask:
        return '问我';
      case ChatMode.lecture:
        return '讲课';
    }
  }
}
