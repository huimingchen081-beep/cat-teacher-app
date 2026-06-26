/// 个人中心页面
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import 'points_center_page.dart';
import 'chat_history_page.dart';
import 'learning_report_page.dart';
import 'settings_page.dart';
import 'about_page.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),
              // 用户卡片
              _buildUserCard(appState),
              const SizedBox(height: 12),
              // 学习统计
              _buildStatsCard(appState),
              const SizedBox(height: 12),
              // 菜单区域
              _buildMenuSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(AppState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // 头像 - 当前猫咪
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withAlpha(128), width: 2),
                  image: DecorationImage(
                    image: AssetImage(state.grade.catImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.grade.label}猫咪老师',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  if (state.isVip)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD700),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text('VIP', style: TextStyle(fontSize: 10, color: Colors.black87, fontWeight: FontWeight.w700)),
                    ),
                ],
              ),
            ],
          ),
          // 积分
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('${state.points}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white)),
                Text('积分', style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(200))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(AppState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          _buildStatItem('${state.totalQuestions}', '提问次数'),
          _StatDivider(),
          _buildStatItem('${state.totalLectures}', '听课次数'),
          _StatDivider(),
          _buildStatItem('${state.totalSignDays}', '学习天数'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFFFF8C42))),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(15), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          _buildMenuItem('🎯', '积分中心', '查看积分，购买VIP', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const PointsCenterPage()));
          }),
          _buildMenuItem('📜', '对话历史', '查看历史学习记录', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ChatHistoryPage()));
          }),
          _buildMenuItem('📊', '学习报告', '查看学习进度', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const LearningReportPage()));
          }),
          _buildMenuItem('⚙️', '设置', '应用设置与偏好', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsPage()));
          }),
          _buildMenuItem('💡', '关于猫咪老师', '版本 1.0.0', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String icon, String label, String desc, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF333333))),
                  Text(desc, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Color(0xFFCCCCCC)),
          ],
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: const Color(0xFFEEEEEE),
    );
  }
}
