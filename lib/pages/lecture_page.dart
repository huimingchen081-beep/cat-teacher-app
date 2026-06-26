/// 课程选择页 - 按教材章节讲课（四层选择：版本→学期→单元→课文）
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/api_config.dart';
import '../models/textbook.dart';
import '../providers/app_state.dart';
import 'chat_page.dart';

class LecturePage extends StatefulWidget {
  const LecturePage({super.key});

  @override
  State<LecturePage> createState() => _LecturePageState();
}

class _LecturePageState extends State<LecturePage> {
  // 选择状态：逐步推进
  TextbookVersion? _selectedVersion;
  TextbookSemester? _selectedSemester;
  TextbookUnit? _selectedUnit;
  TextbookLesson? _selectedLesson;

  // 面包屑层级
  int _step = 0; // 0=选版本, 1=选学期, 2=选单元, 3=选课文

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final grade = appState.grade;
    final subjectKey = appState.selectedSubject ?? 'chinese';
    final subjectName = appState.subjects
        .where((s) => s.key == subjectKey)
        .firstOrNull
        ?.name ?? '语文';

    final versions = getTextbooks(grade, subjectKey);

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: Text('$subjectName · ${grade.label}教材', style: const TextStyle(fontSize: 15)),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // 面包屑导航
          _buildBreadcrumb(),
          // 内容区
          Expanded(child: _buildContent(versions)),
        ],
      ),
    );
  }

  // ---------- 面包屑 ----------
  Widget _buildBreadcrumb() {
    final parts = <String>['📚 教材'];

    if (_selectedVersion != null) parts.add(_selectedVersion!.name);
    if (_selectedSemester != null) parts.add(_selectedSemester!.label);
    if (_selectedUnit != null) parts.add(_selectedUnit!.label);
    if (_selectedLesson != null) parts.add(_selectedLesson!.title);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFFFFF0E0), Color(0xFFFFE8D0)]),
        border: Border(bottom: BorderSide(color: Color(0xFFFFD0B0), width: 0.5)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(parts.length, (i) {
            final isLast = i == parts.length - 1;
            final isClickable = i < _step; // 已完成的步骤可点击回退
            return GestureDetector(
              onTap: isClickable ? () => _goBackTo(i) : null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    parts[i],
                    style: TextStyle(
                      fontSize: 12,
                      color: isLast ? const Color(0xFFD07030) : const Color(0xFFB08060),
                      fontWeight: isLast ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  if (!isLast)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Text('›', style: TextStyle(fontSize: 12, color: Color(0xFFCC9966))),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void _goBackTo(int step) {
    setState(() {
      _step = step;
      if (step < 1) _selectedVersion = null;
      if (step < 2) _selectedSemester = null;
      if (step < 3) _selectedUnit = null;
      if (step < 4) _selectedLesson = null;
    });
  }

  // ---------- 内容区（按步骤显示不同选择） ----------
  Widget _buildContent(List<TextbookVersion> versions) {
    if (versions.isEmpty) {
      return const Center(child: Text('暂无教材数据', style: TextStyle(color: Color(0xFF999999))));
    }

    switch (_step) {
      case 0:
        return _buildVersionList(versions);
      case 1:
        return _buildSemesterList(_selectedVersion!.semesters);
      case 2:
        return _buildUnitList(_selectedSemester!.units);
      case 3:
        return _buildLessonList(_selectedUnit!.lessons);
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------- 第1步：选教材版本 ----------
  Widget _buildVersionList(List<TextbookVersion> versions) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text('选择教材版本', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
        ),
        ...versions.map((v) => _SelectionCard(
              title: v.name,
              subtitle: '${v.semesters.length}个学期',
              onTap: () => setState(() {
                _selectedVersion = v;
                _step = 1;
              }),
            )),
      ],
    );
  }

  // ---------- 第2步：选学期 ----------
  Widget _buildSemesterList(List<TextbookSemester> semesters) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text('选择学期', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
        ),
        ...semesters.map((s) => _SelectionCard(
              title: s.name,
              subtitle: '${s.units.length}个单元',
              onTap: () => setState(() {
                _selectedSemester = s;
                _step = 2;
              }),
            )),
      ],
    );
  }

  // ---------- 第3步：选单元 ----------
  Widget _buildUnitList(List<TextbookUnit> units) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text('选择单元', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
        ),
        ...units.map((u) => _SelectionCard(
              title: '${u.title} · ${u.label}',
              subtitle: '${u.lessons.length}篇课文',
              onTap: () => setState(() {
                _selectedUnit = u;
                _step = 3;
              }),
            )),
      ],
    );
  }

  // ---------- 第4步：选课文 ----------
  Widget _buildLessonList(List<TextbookLesson> lessons) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: Text('选择课文', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF333333))),
        ),
        ...lessons.asMap().entries.map((entry) {
          final idx = entry.key;
          final l = entry.value;
          return _SelectionCard(
            title: l.title,
            subtitle: '第${idx + 1}课',
            onTap: () {
              // 构建讲课上下文，跳转聊天页
              final ctx = LectureContext(
                version: _selectedVersion!.name,
                semester: _selectedSemester!.name,
                unitTitle: _selectedUnit!.title,
                unitLabel: _selectedUnit!.label,
                lessonTitle: l.title,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatPage(
                    subject: context.read<AppState>().selectedSubject,
                    initialMode: ChatMode.lecture,
                    lectureContext: ctx,
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

/// 通用选择卡片
class _SelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SelectionCard({required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF0E0D0)),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(8), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFF8C42), Color(0xFFFFB885)]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.menu_book, size: 18, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
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
