/// 全局应用状态管理 - 使用 Provider
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class AppState extends ChangeNotifier {
  // 年级
  Grade _grade = Grade.primary;
  Grade get grade => _grade;

  // 选中的学科
  String? _selectedSubject;
  String? get selectedSubject => _selectedSubject;

  // 聊��模式
  ChatMode _chatMode = ChatMode.ask;
  ChatMode get chatMode => _chatMode;

  // 积分
  int _points = 30; // 新用户30分
  int get points => _points;

  // VIP状态
  bool _isVip = false;
  bool get isVip => _isVip;

  // 学习统计
  int _totalQuestions = 0;
  int get totalQuestions => _totalQuestions;
  int _totalLectures = 0;
  int get totalLectures => _totalLectures;

  // 签到
  int _signStreak = 0;           // 连续签到天数
  int get signStreak => _signStreak;
  int _totalSignDays = 0;         // 累计签到天数
  int get totalSignDays => _totalSignDays;
  bool _signedToday = false;     // 今天是否已签到
  bool get signedToday => _signedToday;
  String _lastSignDate = '';     // 上次签到日期 yyyy-MM-dd
  String get lastSignDate => _lastSignDate;

  /// 初始化（加载本地数据）
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _points = prefs.getInt('points') ?? 30;
    _isVip = prefs.getBool('isVip') ?? false;
    _totalQuestions = prefs.getInt('totalQuestions') ?? 0;
    _totalLectures = prefs.getInt('totalLectures') ?? 0;
    _signStreak = prefs.getInt('signStreak') ?? 0;
    _totalSignDays = prefs.getInt('totalSignDays') ?? 0;
    _lastSignDate = prefs.getString('lastSignDate') ?? '';

    // 检查今天是否已签到
    final today = _todayString();
    _signedToday = _lastSignDate == today;
    notifyListeners();
  }

  String _todayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// 每日签到 - 返回获得的积分数
  ///  每日签到 5 分
  ///  连续7天额外 +20
  ///  连续30天额外 +100
  Future<int> signIn() async {
    final today = _todayString();
    if (_signedToday) return 0;

    // 判断是否连续
    if (_lastSignDate.isNotEmpty) {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayStr = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
      if (_lastSignDate == yesterdayStr) {
        _signStreak++;
      } else {
        _signStreak = 1; // 中断，重置
      }
    } else {
      _signStreak = 1;
    }

    // 计算奖励
    int earned = 5; // 基础签到
    if (_signStreak == 7) earned += 20;
    if (_signStreak == 30) earned += 100;

    _points += earned;
    _totalSignDays++;
    _signedToday = true;
    _lastSignDate = today;

    // 持久化
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _points);
    await prefs.setInt('signStreak', _signStreak);
    await prefs.setInt('totalSignDays', _totalSignDays);
    await prefs.setString('lastSignDate', _lastSignDate);

    notifyListeners();
    return earned;
  }

  /// 增加提问次数
  void incrementQuestions() {
    _totalQuestions++;
    SharedPreferences.getInstance().then((p) => p.setInt('totalQuestions', _totalQuestions));
    notifyListeners();
  }

  /// 增加讲课次数
  void incrementLectures() {
    _totalLectures++;
    SharedPreferences.getInstance().then((p) => p.setInt('totalLectures', _totalLectures));
    notifyListeners();
  }

  /// 切换年级
  void setGrade(Grade g) {
    if (_grade != g) {
      _grade = g;
      // 清除选中的学科（可能不在新年级里）
      final subjects = getSubjectsForGrade(g);
      if (_selectedSubject != null && !subjects.any((s) => s.key == _selectedSubject)) {
        _selectedSubject = null;
      }
      notifyListeners();
    }
  }

  /// 选择学科
  void selectSubject(String? key) {
    _selectedSubject = key;
    notifyListeners();
  }

  /// 切换聊天模式
  void setChatMode(ChatMode mode) {
    _chatMode = mode;
    notifyListeners();
  }

  /// 获取当前年级学科列表
  List<Subject> get subjects => getSubjectsForGrade(_grade);

  /// 加积分（持久化）
  Future<void> addPoints(int n) async {
    _points += n;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _points);
    notifyListeners();
  }

  /// 扣积分（持久化），返回是否成功
  Future<bool> spendPoints(int n) async {
    if (_points < n) return false;
    _points -= n;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _points);
    notifyListeners();
    return true;
  }

  /// 更新用户信息
  void updateUserInfo({int? points, bool? isVip, int? totalQuestions, int? totalLectures}) {
    if (points != null) _points = points;
    if (isVip != null) _isVip = isVip;
    if (totalQuestions != null) _totalQuestions = totalQuestions;
    if (totalLectures != null) _totalLectures = totalLectures;
    notifyListeners();
  }

  /// 订阅套餐（模拟支付，上架前替换为真实支付）
  Future<void> purchasePackage({required int points, required bool setVip}) async {
    _points += points;
    if (setVip) _isVip = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points', _points);
    if (setVip) await prefs.setBool('isVip', true);
    notifyListeners();
  }
}
