/// 积分规则配置 — 猫咪老师K12教育App
///
/// 与万能掌柜/欠揍儿保持一致的积分体系
/// 所有积分操作通过 AppState 执行

/// 任务类型枚举
enum TeacherTaskType {
  aiAsk,       // AI问答
  aiLecture,   // AI讲课
  photoSolve,  // 拍照解题
  imageGen,    // AI生图
  docGen,      // 文档生成(PPT/Word/Excel)
  tts,         // 语音播报(TTS)
}

/// 积分规则配置
class TeacherPointsConfig {
  // ==================== 新用户 ====================
  static const int newUserPoints = 30;

  // ==================== 每日签到 ====================
  static const int dailyCheckinPoints = 5;
  static const int streak7Bonus = 20;
  static const int streak30Bonus = 100;

  // ==================== 邀请奖励 ====================
  static const int inviteBonus = 50;

  // ==================== 订阅套餐 ====================
  static const List<TeacherSubscriptionPackage> packages = [
    TeacherSubscriptionPackage(
      id: 'trial',
      name: '体验包',
      priceYuan: 5,
      points: 100,
      description: '100积分，畅快体验',
    ),
    TeacherSubscriptionPackage(
      id: 'monthly',
      name: '月卡',
      priceYuan: 39.9,
      points: 3000,
      description: '3000积分，日常够用',
      badge: '热门',
    ),
    TeacherSubscriptionPackage(
      id: 'quarterly',
      name: '季卡',
      priceYuan: 99.9,
      points: 9000,
      description: '9000积分，超值之选',
      badge: '超值',
    ),
    TeacherSubscriptionPackage(
      id: 'yearly',
      name: '年卡',
      priceYuan: 259.9,
      points: 30000,
      description: '30000积分，全年畅享',
      badge: '最划算',
    ),
  ];

  // ==================== 任务消耗 ====================
  // 基于2026-06-23最新API价格核算，确保所有功能利润≥30%
  static const Map<TeacherTaskType, int> taskCosts = {
    TeacherTaskType.aiAsk:      5,   // AI问答：5分/次（qwen3.7-plus+长系统提示词+对话历史累积token）
    TeacherTaskType.aiLecture:  8,   // AI讲课：8分/次（qwen3.7-plus+3000max_tokens+超长提示词）
    TeacherTaskType.photoSolve: 10,  // 拍照解题：10分/次（qwen-vl-max视觉模型，¥0.04/次成本）
    TeacherTaskType.imageGen:   60,  // AI生图：60分/张（seedream价格波动¥0.25~0.50）
    TeacherTaskType.docGen:     20,  // 文档生成：20分/次（qwen-plus，成本仅¥0.009/次，暴利削减）
    TeacherTaskType.tts:        3,   // 语音播报：3分/次（cosyvoice-v3-flash ¥1/万字符，~1000字=¥0.10，利润40%）
  };

  /// 获取任务消耗积分
  static int getCost(TeacherTaskType type) => taskCosts[type] ?? 0;

  /// 获取任务中文名称
  static String getTaskName(TeacherTaskType type) {
    switch (type) {
      case TeacherTaskType.aiAsk:       return 'AI问答';
      case TeacherTaskType.aiLecture:   return 'AI讲课';
      case TeacherTaskType.photoSolve:  return '拍照解题';
      case TeacherTaskType.imageGen:    return 'AI生图';
      case TeacherTaskType.docGen:      return '文档生成';
      case TeacherTaskType.tts:          return '语音播报';
    }
  }
}

/// 订阅套餐数据
class TeacherSubscriptionPackage {
  final String id;
  final String name;
  final double priceYuan;
  final int points;
  final String description;
  final String? badge;

  const TeacherSubscriptionPackage({
    required this.id,
    required this.name,
    required this.priceYuan,
    required this.points,
    required this.description,
    this.badge,
  });

  /// 性价比：积分/元
  double get valueRatio => points / priceYuan;
}
