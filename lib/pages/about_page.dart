/// 关于页面
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('关于猫咪老师'),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 应用图标和版本
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text('🐱', style: TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '猫咪老师',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF333333)),
            ),
            const SizedBox(height: 4),
            const Text(
              'AI 全学科学习助手 v1.0.0',
              style: TextStyle(fontSize: 14, color: Color(0xFF999999)),
            ),
            const SizedBox(height: 24),

            // 功能介绍卡片
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('✨ 核心功能', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  SizedBox(height: 14),
                  _FeatureItem('🙋', 'AI问答', '支持小学/初中/高中全学科智能问答'),
                  _FeatureItem('📚', 'AI讲课', '同步教材，系统授课，互动式教学'),
                  _FeatureItem('📷', '拍照解题', '拍照识别题目，AI给出详细解答'),
                  _FeatureItem('🎤', '语音输入', '支持语音输入问题，解放双手'),
                  _FeatureItem('🔊', '语音讲解', 'AI回答带语音播报，生动讲解'),
                  _FeatureItem('📊', '学习报告', '记录学习数据，智能分析学习习惯'),
                ],
              ),
            ),

            const SizedBox(height: 16),
            // 技术信息
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('🔧 技术信息', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  SizedBox(height: 10),
                  _InfoRow('AI引擎', '阿里云 DashScope'),
                  _InfoRow('语言模型', 'qwen3.7-plus'),
                  _InfoRow('语音合成', 'CosyVoice'),
                  _InfoRow('语音识别', 'Paraformer-v2'),
                  _InfoRow('开发框架', 'Flutter 3.x'),
                  _InfoRow('版本号', '1.0.0 (build 1)'),
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              '🐱 猫咪老师陪伴你学习成长喵~',
              style: TextStyle(fontSize: 13, color: Color(0xFF999999)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String emoji;
  final String title;
  final String desc;
  const _FeatureItem(this.emoji, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF333333))),
          const Spacer(),
          Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF666666))),
          Text(value, style: const TextStyle(fontSize: 13, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}
