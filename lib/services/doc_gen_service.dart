/// 文档生成服务 — DashScope LLM 生成 Word/PPT/Excel 内容
///
/// 参考万能掌柜的实现：
/// - PPT: qwen-plus 生成大纲+内容，结构化输出
/// - Word: qwen3.7-plus 生成文档全文
/// - Excel: qwen3.7-plus 生成CSV格式数据
///
/// 由于 Flutter 端无法直接创建 .pptx/.docx/.xlsx 文件（需要如 python-pptx 等服务端库），
/// 这里采用折中方案：返回结构化的 Markdown/CSV 内容，前端展示和复制。
/// 后续可接入后端服务（如万能掌柜的 pptGen 云函数）做真实文件生成。

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class DocGenResult {
  final String content;     // 生成的内容文本
  final String? title;      // 标题
  final bool success;
  final String? error;

  const DocGenResult({
    required this.content,
    this.title,
    required this.success,
    this.error,
  });
}

class DocGenService {
  static final DocGenService _instance = DocGenService._();
  factory DocGenService() => _instance;
  DocGenService._();

  static const String _endpoint =
      'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions';

  // ==================== PPT 生成 ====================

  Future<DocGenResult> generatePpt(String userPrompt) async {
    final systemPrompt = '''你是一个专业的PPT内容策划师。
用户想要制作一个PPT，请根据用户的需求生成PPT内容。

输出格式严格遵守以下Markdown格式（这是最终输出，不能包含任何额外说明）：

# PPT标题

## 第1页：封面
- 主标题：...
- 副标题：...

## 第2页：目录
- 章节1：...
- 章节2：...
...

## 第N页：内容页
### 页面标题
- 要点1
- 要点2
...

## 最后一页：总结/感谢

规则：
1. 每页用 ## 开头
2. 使用中文，内容具体可操作
3. 根据用户需求生成6-12页
4. 内容要有逻辑性和层次感
5. 不要输出任何非PPT内容以外的文字''';

    return _callLLM(
      systemPrompt: systemPrompt,
      userMessage: userPrompt,
      model: 'qwen-plus',
      maxTokens: 3000,
    );
  }

  // ==================== Word/文章生成 ====================

  Future<DocGenResult> generateWord(String userPrompt) async {
    final systemPrompt = '''你是一个专业的内容写手。
用户想要一份文档/文章，请根据用户需求直接输出文档全文。

输出格式：
# 文档标题
[正文内容，分段落组织，用清晰的章节结构]
## 小标题1
正文...
## 小标题2
正文...

规则：
1. 直接输出文档全文，不要加额外说明
2. 语言专业流畅，适合正式用途
3. 根据用户需求调整篇幅（一般800-2000字）
4. 如果是报告/论文，要有引用和结论部分
5. 如果是合同/公文，要格式规范''';

    return _callLLM(
      systemPrompt: systemPrompt,
      userMessage: userPrompt,
      model: ApiConfig.llmModel,
      maxTokens: 4000,
    );
  }

  // ==================== Excel/表格生成 ====================

  Future<DocGenResult> generateExcel(String userPrompt) async {
    final systemPrompt = '''你是一个数据处理助手。
用户想要一个表格，请根据用户需求生成CSV格式的表格数据。

输出格式（严格遵守）：
表格标题：[标题]
┄┄┄┄┄┄┄┄┄┄┄┄┄┄
列1,列2,列3,列4
数据1,数据2,数据3,数据4
数据1,数据2,数据3,数据4
...
┄┄┄┄┄┄┄┄┄┄┄┄┄┄

[使用说明：将上方CSV数据复制到Excel即可自动生成表格]

规则：
1. 第一行是列名（用逗号分隔）
2. 后续行是数据（用逗号分隔）
3. 如果有数字，不要加千分位逗号（用空格或直接写）
4. 如果字段内含逗号，用双引号包裹
5. 表格标题和分隔线用上面的格式
6. 至少生成5-15行示例数据
7. 不要输出任何额外说明文字''';

    return _callLLM(
      systemPrompt: systemPrompt,
      userMessage: userPrompt,
      model: ApiConfig.llmModel,
      maxTokens: 3000,
    );
  }

  // ==================== 核心LLM调用 ====================

  Future<DocGenResult> _callLLM({
    required String systemPrompt,
    required String userMessage,
    required String model,
    int maxTokens = 3000,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${ApiConfig.dashScopeKey}',
            },
            body: jsonEncode({
              'model': model,
              'messages': [
                {'role': 'system', 'content': systemPrompt},
                {'role': 'user', 'content': userMessage},
              ],
              'max_tokens': maxTokens,
              'enable_thinking': false,
            }),
          )
          .timeout(const Duration(seconds: 90));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final content = data['choices']?[0]?['message']?['content'] as String?;
        if (content != null && content.isNotEmpty) {
          // 提取标题
          final titleMatch = RegExp(r'^#\s*(.+)', multiLine: true).firstMatch(content);
          return DocGenResult(
            content: content,
            title: titleMatch?.group(1)?.trim(),
            success: true,
          );
        }
        return const DocGenResult(content: '', success: false, error: '生成成功但内容为空');
      }

      String errMsg = '生成失败(HTTP ${response.statusCode})';
      try {
        final err = jsonDecode(response.body);
        errMsg = err['error']?['message'] ?? err['message'] ?? errMsg;
      } catch (_) {}
      return DocGenResult(content: '', success: false, error: errMsg);
    } catch (e) {
      return DocGenResult(content: '', success: false, error: '网络错误: $e');
    }
  }
}
