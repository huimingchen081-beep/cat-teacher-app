/// 积分中心 - 积分详情 + VIP订阅
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../config/points_config.dart';

class PointsCenterPage extends StatelessWidget {
  const PointsCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('积分中心'),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 积分卡片
            _buildPointsCard(state),
            const SizedBox(height: 16),
            // 每日签到
            _buildSignInCard(context, state),
            const SizedBox(height: 16),
            // VIP 会员方案
            const Text('✨ 积分套餐', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
            const SizedBox(height: 12),
            ...TeacherPointsConfig.packages.map((pkg) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildPackageCard(context, state, pkg),
            )),
            const SizedBox(height: 24),
            // 积分规则说明
            _buildRulesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildPointsCard(AppState state) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C42), Color(0xFFFFB885)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${state.points}',
                style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const SizedBox(width: 8),
              const Text('分', style: TextStyle(fontSize: 20, color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            state.isVip ? '🌟 VIP会员 · 尊享特权' : '当前积分余额',
            style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          ),
          if (!state.isVip) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text('开通VIP，AI问答免积分！', style: TextStyle(fontSize: 13, color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSignInCard(BuildContext context, AppState state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text('📅', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('每日签到', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    Text(
                      state.signedToday
                          ? '今日已签到 · 连续${state.signStreak}天'
                          : '签到 +5分，连续7天额外+20，连续30天+100',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF999999)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: state.signedToday
                    ? null
                    : () async {
                        final earned = await state.signIn();
                        if (context.mounted && earned > 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('签到成功！🎉 获得 $earned 积分'),
                              backgroundColor: const Color(0xFFFF8C42),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: state.signedToday ? const Color(0xFFE0E0E0) : const Color(0xFFFF8C42),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    state.signedToday ? '已签到' : '签到',
                    style: TextStyle(
                      fontSize: 14,
                      color: state.signedToday ? const Color(0xFF999999) : Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (state.signStreak > 0) ...[
            const SizedBox(height: 12),
            _buildSignWeekBar(state),
          ],
        ],
      ),
    );
  }

  Widget _buildSignWeekBar(AppState state) {
    final today = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (i) {
        final day = today.subtract(Duration(days: 6 - i));
        final isToday = i == 6;
        final isSigned = state.signStreak >= (7 - i) && state.signedToday;

        return Column(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSigned ? const Color(0xFFFF8C42) : const Color(0xFFF0F0F0),
                border: isToday ? Border.all(color: const Color(0xFFFF8C42), width: 2) : null,
              ),
              child: Center(
                child: Text(
                  isSigned ? '✓' : '${day.day}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isSigned ? Colors.white : const Color(0xFF999999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              ['一','二','三','四','五','六','日'][day.weekday - 1],
              style: TextStyle(fontSize: 10, color: isToday ? const Color(0xFFFF8C42) : const Color(0xFF999999)),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPackageCard(BuildContext context, AppState state, TeacherSubscriptionPackage pkg) {
    final color = pkg.id == 'yearly'
        ? const Color(0xFF9C27B0)
        : pkg.id == 'quarterly'
            ? const Color(0xFF2196F3)
            : pkg.id == 'monthly'
                ? Colors.orange
                : const Color(0xFF666666);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withAlpha(60), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withAlpha(20), borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(
                pkg.id == 'yearly' ? '👑' : pkg.id == 'quarterly' ? '🐈' : pkg.id == 'monthly' ? '🐱' : '🎁',
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(pkg.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    if (pkg.badge != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: color.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(pkg.badge!, style: TextStyle(fontSize: 10, color: color)),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text('${pkg.points}积分 · ${pkg.description}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF999999))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('¥', style: TextStyle(fontSize: 14, color: Color(0xFF333333))),
                  Text('${pkg.priceYuan}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color)),
                ],
              ),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () {
                  _onSubscribe(context, state, pkg);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text('购买', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSubscribe(BuildContext context, AppState state, TeacherSubscriptionPackage pkg) {
    final vipTags = pkg.id == 'monthly' || pkg.id == 'quarterly' || pkg.id == 'yearly';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('确认购买「${pkg.name}」'),
        content: Text('¥${pkg.priceYuan} → +${pkg.points} 积分\n${vipTags ? "开通VIP，AI问答/讲课/拍照解题免积分" : ""}'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('取消', style: TextStyle(color: Color(0xFF666666)))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C42),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(ctx);
              // 模拟支付处理流程
              final mounted1 = context.mounted;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const AlertDialog(
                  content: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFFF8C42))),
                      SizedBox(width: 16),
                      Text('正在支付...', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              );
              // 模拟网络延迟
              await Future.delayed(const Duration(seconds: 2));
              // 关闭支付中弹窗
              if (mounted1) Navigator.pop(context);
              await state.purchasePackage(points: pkg.points, setVip: vipTags);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('🎉 购买成功！获得 ${pkg.points} 积分${vipTags ? "，已是VIP会员" : ""}'),
                    backgroundColor: const Color(0xFF4CAF50),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('确认支付'),
          ),
        ],
      ),
    );
  }

  Widget _buildRulesCard() {
    final askCost = TeacherPointsConfig.taskCosts[TeacherTaskType.aiAsk] ?? 0;
    final lectureCost = TeacherPointsConfig.taskCosts[TeacherTaskType.aiLecture] ?? 0;
    final photoCost = TeacherPointsConfig.taskCosts[TeacherTaskType.photoSolve] ?? 0;
    final imageCost = TeacherPointsConfig.taskCosts[TeacherTaskType.imageGen] ?? 0;
    final docCost = TeacherPointsConfig.taskCosts[TeacherTaskType.docGen] ?? 0;
    final ttsCost = TeacherPointsConfig.taskCosts[TeacherTaskType.tts] ?? 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📋 积分规则', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          const _RuleItem('每日签到', '+5积分'),
          const _RuleItem('连续签到7天', '额外 +20积分'),
          const _RuleItem('连续签到30天', '额外 +100积分'),
          const _RuleItem('邀请好友', '+50积分/人'),
          _RuleItem('AI问答', 'VIP免积分 · 非VIP${askCost}分/次'),
          _RuleItem('AI讲课', 'VIP免积分 · 非VIP${lectureCost}分/次'),
          _RuleItem('拍照解题', 'VIP免积分 · 非VIP${photoCost}分/次'),
          _RuleItem('AI生图', '${imageCost}分/张'),
          _RuleItem('文档生成', '${docCost}分/次'),
          _RuleItem('语音播报', '${ttsCost}分/次（可关闭）'),
        ],
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String label;
  final String value;
  const _RuleItem(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF666666))),
          Text(value, style: const TextStyle(fontSize: 13, color: Color(0xFFFF8C42), fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
