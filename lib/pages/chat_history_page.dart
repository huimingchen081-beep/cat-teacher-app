/// 对话历史页面
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHistoryPage extends StatefulWidget {
  const ChatHistoryPage({super.key});

  @override
  State<ChatHistoryPage> createState() => _ChatHistoryPageState();
}

class _ChatHistoryPageState extends State<ChatHistoryPage> {
  List<Map<String, dynamic>> _histories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistories();
  }

  Future<void> _loadHistories() async {
    final prefs = await SharedPreferences.getInstance();
    final historyKeys = prefs.getKeys().where((k) => k.startsWith('chat_history_')).toList()
      ..sort((a, b) => b.compareTo(a)); // 最新的在前

    final histories = <Map<String, dynamic>>[];
    for (final key in historyKeys.take(50)) {
      final data = prefs.getStringList(key);
      if (data != null && data.isNotEmpty) {
        // 提取第一条摘要
        final firstMsg = data.first;
        final title = firstMsg.length > 60 ? '${firstMsg.substring(0, 60)}...' : firstMsg;
        final timestamp = int.tryParse(key.replaceAll('chat_history_', '')) ?? 0;
        final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
        histories.add({
          'key': key,
          'title': title,
          'count': data.length,
          'date': '${date.month}/${date.day} ${date.hour}:${date.minute.toString().padLeft(2, '0')}',
          'data': data,
        });
      }
    }

    setState(() {
      _histories = histories;
      _loading = false;
    });
  }

  Future<void> _deleteHistory(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    _loadHistories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        title: const Text('对话历史'),
        backgroundColor: const Color(0xFFFF8C42),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF8C42)))
          : _histories.isEmpty
              ? _buildEmpty()
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: _histories.length,
                  itemBuilder: (context, index) {
                    final h = _histories[index];
                    return _buildHistoryItem(h);
                  },
                ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🐱', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text('还没有对话记录', style: TextStyle(fontSize: 16, color: Color(0xFF999999))),
          const SizedBox(height: 8),
          const Text('去和猫咪老师聊聊天吧~', style: TextStyle(fontSize: 13, color: Color(0xFFCCCCCC))),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> h) {
    return Dismissible(
      key: Key(h['key'] as String),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.red.withAlpha(30),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.red),
      ),
      onDismissed: (_) => _deleteHistory(h['key'] as String),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 4, offset: const Offset(0, 1))],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.chat_bubble_outline, color: Color(0xFFFF8C42), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    h['title'] as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF333333)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${h['count']}条消息 · ${h['date']}',
                    style: const TextStyle(fontSize: 11, color: Color(0xFF999999)),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFFCCCCCC), size: 20),
          ],
        ),
      ),
    );
  }
}
