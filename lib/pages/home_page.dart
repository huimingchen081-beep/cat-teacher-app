/// 首页 - 年级/学科选择 + 猫咪展示
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/api_config.dart';
import '../providers/app_state.dart';
import 'chat_page.dart';
import 'lecture_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final subjects = appState.subjects;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: Column(
          children: [
            // 顶部积分栏
            _buildTopBar(context, appState),
            // 年级切换
            _buildGradeTabs(context, appState),
            // 猫咪展示区
            _buildCatDisplay(appState),
            // 学科选择
            _buildSubjectGrid(context, appState, subjects),
            // 快捷入口
            _buildQuickActions(context, appState, subjects),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, AppState appState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 积分徽章
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('⭐', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 4),
                Text(
                  '${appState.points}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFE65100)),
                ),
              ],
            ),
          ),
          // 签到按钮
          GestureDetector(
            onTap: () => _onSignIn(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('签到', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeTabs(BuildContext context, AppState appState) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: const Color(0xFFFF8C42).withAlpha(20), blurRadius: 12, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: Grade.values.map((g) {
          final isActive = appState.grade == g;
          return Expanded(
            child: GestureDetector(
              onTap: () => appState.setGrade(g),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: isActive
                      ? const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)])
                      : null,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(g.emoji, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 2),
                    Text(
                      g.label,
                      style: TextStyle(
                        fontSize: 13,
                        color: isActive ? Colors.white : const Color(0xFF666666),
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCatDisplay(AppState appState) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          // 猫咪图片
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFFFFF0E0), Color(0xFFFFF8F0)]),
              boxShadow: [BoxShadow(color: const Color(0xFFFF8C42).withAlpha(40), blurRadius: 20, offset: const Offset(0, 4))],
              image: DecorationImage(
                image: AssetImage(appState.grade.catImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // 气泡
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Text(
              _getCatMessage(appState),
              style: const TextStyle(fontSize: 13, color: Color(0xFF333333)),
            ),
          ),
        ],
      ),
    );
  }

  String _getCatMessage(AppState state) {
    if (state.selectedSubject == null) {
      return '喵~ 选一个学科，我来教你！';
    }
    final subject = state.subjects.firstWhere((s) => s.key == state.selectedSubject);
    return '喵~ 今天学${subject.name}吧！';
  }

  Widget _buildSubjectGrid(BuildContext context, AppState appState, List<Subject> subjects) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text('选择学科', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
          ),
          SizedBox(
            height: 80,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: subjects.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final sub = subjects[index];
                final isSelected = appState.selectedSubject == sub.key;
                return GestureDetector(
                  onTap: () {
                    appState.selectSubject(isSelected ? null : sub.key);
                    if (!isSelected) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatPage(subject: null)));
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 64,
                    height: 76,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFFF0E0) : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isSelected ? const Color(0xFFFF8C42) : const Color(0xFFEEEEEE),
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: const Color(0xFFFF8C42).withAlpha(40), blurRadius: 8, offset: const Offset(0, 2))]
                          : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(sub.emoji, style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 4),
                        Text(sub.name, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: isSelected ? const Color(0xFFFF8C42) : const Color(0xFF333333))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context, AppState appState, List<Subject> subjects) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('快捷入口', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ActionCard(
                  icon: '💬',
                  label: '提问猫咪',
                  desc: '问任何学习问题',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(subject: appState.selectedSubject))),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _ActionCard(
                  icon: '🎓',
                  label: '猫咪讲课',
                  desc: '按教材章节上课',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LecturePage()),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignIn(BuildContext context) {
    final appState = context.read<AppState>();
    if (appState.signedToday) {
      _showSignedDialog(context, appState);
      return;
    }
    _doSignIn(context, appState);
  }

  Future<void> _doSignIn(BuildContext context, AppState appState) async {
    final earned = await appState.signIn();

    if (!context.mounted) return;

    String message;
    if (appState.signStreak == 7) {
      message = '🎉 连续签到7天！额外+20积分！';
    } else if (appState.signStreak == 30) {
      message = '🏆 连续签到30天！额外+100积分！';
    } else {
      message = '已连续签到${appState.signStreak}天';
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🐱', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            const Text('签到成功！', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text('+$earned ⭐', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFFFF8C42))),
            const SizedBox(height: 8),
            Text(message, style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
            if (appState.signStreak == 7 || appState.signStreak == 30) ...[
              const SizedBox(height: 4),
              const Text('🔥 继续保持喵~', style: TextStyle(fontSize: 13, color: Color(0xFFFF8C42))),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('知道了喵~', style: TextStyle(color: Color(0xFFFF8C42))),
          ),
        ],
      ),
    );
  }

  void _showSignedDialog(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('😺', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 8),
            const Text('今天已经签过啦~', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Text('已连续签到 ${appState.signStreak} 天', style: const TextStyle(fontSize: 14, color: Color(0xFF666666))),
            Text('累计积分: ${appState.points} ⭐', style: const TextStyle(fontSize: 14, color: Color(0xFF999999))),
            const SizedBox(height: 4),
            Text(_getNextReward(appState.signStreak), style: const TextStyle(fontSize: 12, color: Color(0xFFFF8C42))),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('好的喵~', style: TextStyle(color: Color(0xFFFF8C42))),
          ),
        ],
      ),
    );
  }

  String _getNextReward(int streak) {
    if (streak < 7) return '距连续7天奖励还差 ${7 - streak} 天';
    if (streak < 30) return '距连续30天奖励还差 ${30 - streak} 天';
    return '🏆 已达到最高连续奖励！';
  }
}

class _ActionCard extends StatelessWidget {
  final String icon;
  final String label;
  final String desc;
  final VoidCallback onTap;

  const _ActionCard({required this.icon, required this.label, required this.desc, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
            Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
          ],
        ),
      ),
    );
  }
}
