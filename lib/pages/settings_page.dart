/// 设置页面
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
import '../providers/app_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _autoPlayTts = false; // 是否自动播放AI语音

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _autoPlayTts = prefs.getBool('autoPlayTts') ?? false;
    });
  }

  Future<void> _setAutoPlayTts(bool v) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoPlayTts', v);
    setState(() => _autoPlayTts = v);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 年级学段
            _buildCard(
              '🎒 学段选择',
              child: Column(
                children: Grade.values.map((g) {
                  final isActive = state.grade == g;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Text(g.emoji, style: const TextStyle(fontSize: 24)),
                    title: Text(g.label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    trailing: isActive
                        ? const Icon(Icons.check_circle, color: Color(0xFFFF8C42), size: 22)
                        : const Icon(Icons.circle_outlined, color: Color(0xFFCCCCCC), size: 22),
                    onTap: () => state.setGrade(g),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 14),
            // 语音设置
            _buildCard(
              '🔊 语音设置',
              child: Column(
                children: [
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('自动播放AI语音', style: TextStyle(fontSize: 14)),
                    subtitle: const Text('AI回答后自动播放语音讲解', style: TextStyle(fontSize: 12, color: Color(0xFF999999))),
                    value: _autoPlayTts,
                    activeTrackColor: const Color(0xFFFF8C42),
                    onChanged: _setAutoPlayTts,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),
            // 数据管理
            _buildCard(
              '💾 数据管理',
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.delete_outline, color: Color(0xFF999999)),
                    title: const Text('清除对话历史', style: TextStyle(fontSize: 14)),
                    subtitle: const Text('删除所有聊天记录', style: TextStyle(fontSize: 12, color: Color(0xFF999999))),
                    onTap: () => _confirmClear(context, '对话历史', () async {
                      final prefs = await SharedPreferences.getInstance();
                      final keys = prefs.getKeys().where((k) => k.startsWith('chat_history_')).toList();
                      for (final key in keys) {
                        await prefs.remove(key);
                      }
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('对话历史已清除'), backgroundColor: Color(0xFFFF8C42)),
                        );
                      }
                    }),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.restore, color: Color(0xFF999999)),
                    title: const Text('重置学习数据', style: TextStyle(fontSize: 14)),
                    subtitle: const Text('积分和统计数据清零（保留VIP状态）', style: TextStyle(fontSize: 12, color: Color(0xFF999999))),
                    onTap: () => _confirmClear(context, '学习数据', () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setInt('points', 30);
                      await prefs.setInt('totalQuestions', 0);
                      await prefs.setInt('totalLectures', 0);
                      await prefs.setInt('signStreak', 0);
                      await prefs.setInt('totalSignDays', 0);
                      await prefs.setString('lastSignDate', '');
                      state.updateUserInfo(points: 30, totalQuestions: 0, totalLectures: 0);
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('学习数据已重置'), backgroundColor: Color(0xFFFF8C42)),
                        );
                      }
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, {required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          child,
        ],
      ),
    );
  }

  void _confirmClear(BuildContext context, String label, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('确认清除$label？'),
        content: Text('此操作不可恢复，确定要清除$label吗？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onConfirm();
            },
            child: const Text('确认清除', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
