/// 学习报告页面 - 展示学习进度数据
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class LearningReportPage extends StatelessWidget {
  const LearningReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('学习报告'),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 总体统计
            _buildSectionTitle('📊 总体学习统计'),
            const SizedBox(height: 10),
            _buildStatsGrid(state),
            const SizedBox(height: 16),
            // 学习详情
            _buildSectionTitle('📈 学习详情'),
            const SizedBox(height: 10),
            _buildDetailCard(state),
            const SizedBox(height: 16),
            // 学习建议
            _buildSectionTitle('💡 猫咪老师的建议'),
            const SizedBox(height: 10),
            _buildAdviceCard(state),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF333333)));
  }

  Widget _buildStatsGrid(AppState state) {
    return Row(
      children: [
        Expanded(child: _buildStatBox('🙋', '${state.totalQuestions}', '提问次数', const Color(0xFF42A5F5))),
        const SizedBox(width: 10),
        Expanded(child: _buildStatBox('📚', '${state.totalLectures}', '听课次数', const Color(0xFF66BB6A))),
        const SizedBox(width: 10),
        Expanded(child: _buildStatBox('📅', '${state.totalSignDays}', '学习天数', const Color(0xFFFFA726))),
      ],
    );
  }

  Widget _buildStatBox(String emoji, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(6), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
        ],
      ),
    );
  }

  Widget _buildDetailCard(AppState state) {
    final total = state.totalQuestions + state.totalLectures;
    final questionRatio = total > 0 ? (state.totalQuestions / total * 100).round() : 0;
    final lectureRatio = total > 0 ? (state.totalLectures / total * 100).round() : 0;

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
          const Text('学习分布', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 14),
          if (total > 0) ...[
            _buildRatioBar('提问', questionRatio, const Color(0xFF42A5F5)),
            const SizedBox(height: 10),
            _buildRatioBar('听课', lectureRatio, const Color(0xFF66BB6A)),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '累计互动 ${total} 次',
                style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
              ),
            ),
          ] else
            const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('还没有学习记录，快去和猫咪老师互动吧~', style: TextStyle(fontSize: 13, color: Color(0xFF999999))),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRatioBar(String label, int ratio, Color color) {
    return Row(
      children: [
        SizedBox(width: 36, child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF666666)))),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: ratio / 100,
              backgroundColor: color.withAlpha(30),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(width: 36, child: Text('$ratio%', style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600), textAlign: TextAlign.right)),
      ],
    );
  }

  Widget _buildAdviceCard(AppState state) {
    String title;
    String desc;

    if (state.totalQuestions + state.totalLectures == 0) {
      title = '刚开始学习！';
      desc = '建议先从"问我"模式开始，遇到不懂的随时问猫咪老师。选择一个学科，从基础问题入手，猫咪老师会用最易懂的方式回答你喵~';
    } else if (state.totalLectures > state.totalQuestions) {
      title = '你是听课型学习者！';
      desc = '你更喜欢系统听课，这很棒！不过别忘了在听课后主动提问，提问能帮助加深理解。试试听完课后追问几个"为什么"，效果会更好喵~';
    } else if (state.totalQuestions > state.totalLectures * 2) {
      title = '你是提问型学习者！';
      desc = '你很喜欢主动提问，这是好习惯！建议搭配"讲课"模式，找对应教材的课程系统学习，把零散的知识点串起来，学习效率会更高喵~';
    } else {
      title = '你的学习很均衡！';
      desc = '提问和听课并重，是效率最高的学习方式！继续保持，尝试更多学科，猫咪老师会一直陪着你进步喵~';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF0E0), Color(0xFFFFE8D0)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD0B0), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text('🐱', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF996633))),
          ]),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 13, color: Color(0xFF996633), height: 1.5)),
        ],
      ),
    );
  }
}
