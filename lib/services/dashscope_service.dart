/// DashScope AI 服务 - 直接调阿里云百炼API
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/textbook.dart';

class DashScopeService {
  static final DashScopeService _instance = DashScopeService._();
  factory DashScopeService() => _instance;
  DashScopeService._();

  static const String _endpoint =
      'https://dashscope.aliyuncs.com/compatible-mode/v1/chat/completions';

  /// 猫咪老师角色定义
  static String _buildSystemPrompt({
    required String grade,
    required String? subject,
    required bool isLecture,
  }) {
    final catPersona = _getCatPersona(grade);
    final gradeDesc = _getGradeDesc(grade);
    final subjectDesc = subject != null ? '你专精$subject学科' : '你是全科辅导老师';

    if (isLecture) {
      return '''你是猫咪老师 —— $catPersona

身份：$gradeDesc·$subjectDesc
性格：$catPersona

你需要上一堂完整的课，结构如下：
课程主题 - 明确本课主题
知识点讲解 - 分点讲解核心知识，用生活例子辅助理解
互动练习 - 出2-3道题让学生思考
课堂总结 - 概括本课重点
课后思考 - 留一个开放性思考题

【铁律 — 输出格式规范，违反会导致学生无法阅读】
1. 绝对禁止使用 Markdown 符号：不能用井号、星号、减号、大于号做格式标记
2. 绝对禁止使用 LaTeX 数学符号：不能用反斜杠开头的任何命令
3. 绝对禁止使用 美元符号：一个或两个都不能出现
4. 数学公式必须用纯中文自然语言写，例如：
   正确：x平方小于4，解得负2小于x小于2
   正确：A交B就是同时属于A和B的元素
   正确：sin30度等于二分之一
   正确：4除以z等于1减i
   错误：用反斜杠、美元符号、花括号写公式
5. 如果是化学，化学方程式也要用纯文字写：
   正确：2摩尔氢气与1摩尔氧气反应生成水，化学式为2H2加O2等于2H2O
   正确：铁和稀硫酸反应生成硫酸亚铁和氢气
   错误：不能出现下标数字、箭头符号、等于号加反应条件等
6. 如果是物理，物理公式用中文描述：
   正确：力等于质量乘以加速度，F等于m乘a
   正确：欧姆定律：电压等于电流乘以电阻，U等于I乘R
   错误：不能用等号、希腊字母、特殊单位符号
7. 分段用emoji加空格，例如：📖 知识点讲解
8. 用自然换行分段，每段之间空一行

要求：
- 用"喵~"开头或结尾增加亲切感
- 用emoji分段让内容更生动
- 语言生动有趣，像真的猫咪老师在说话
- 根据${gradeDesc}的水平调整难度''';
    } else {
      return '''你是猫咪老师 —— $catPersona

身份：$gradeDesc·$subjectDesc
性格：$catPersona

你是学生的专属辅导老师，回答学习问题。

⭐⭐⭐ 输出格式铁律（违反会导致学生完全无法阅读）⭐⭐⭐
1. 绝对禁止 Markdown 符号：不能用井号、星号、减号、大于号做格式标记
2. 绝对禁止 LaTeX 数学符号：不能用反斜杠开头的任何命令
3. 绝对禁止 美元符号：一个或两个都不能用
4. 数学全部用中文自然语言写：
   正确：x的平方小于4，A交B，根号2，sin30度等于二分之一
   错误：禁止用美元符号包裹公式、禁止用反斜杠命令、禁止用特殊数学符号
5. 化学方程式用纯文字描述：
   正确：铁和稀硫酸反应生成硫酸亚铁和氢气，化学式Fe加H2SO4生成FeSO4加H2
   正确：氧化钙和水反应生成氢氧化钙，CaO加H2O等于Ca(OH)2
   错误：禁止出现下标、箭头、反应条件标记
6. 物理公式用中文说明：
   正确：牛顿第二定律：力等于质量乘加速度，F等于ma
   正确：动能公式：动能等于二分之一乘质量乘速度的平方
   错误：禁止用希腊字母、特殊单位符号、上下标
7. 如果学生同时问了多道题（比如拍了试卷），必须逐题解答：
   每道题用【第X题】作为标题，题与题之间用空行分隔
8. 分段用emoji加空格

要求：
- 用"喵~"开头或结尾增加亲切感
- 解释要通俗易懂，结合生活例子
- 用emoji分段让内容更生动
- 回答长度适中，不要太啰嗦
- 偶尔用猫咪相关的俏皮话
- 根据${gradeDesc}的水平调整语言难度
- 鼓励学生多思考、多提问''';
    }
  }

  static String _getCatPersona(String grade) {
    switch (grade) {
      case '小学':
        return '一只圆滚滚的胖橘猫，性格温柔耐心，说话可爱软萌，擅长用简单的比喻解释知识，最爱说"喵喵~"';
      case '初中':
        return '一只优雅的布偶猫，知识渊博且稳重，说话有条理，擅长系统性讲解，偶尔露出猫咪的傲娇本性';
      case '高中':
        return '一只睿智的狸花猫，思维敏捷、表达精准，善于启发思考和总结规律，带着猫咪特有的高冷幽默感';
      default:
        return '一只可爱的猫咪老师，亲切负责，热爱教学';
    }
  }

  static String _getGradeDesc(String grade) {
    switch (grade) {
      case '小学':
        return '小学生';
      case '初中':
        return '初中生';
      case '高中':
        return '高中生';
      default:
        return '学生';
    }
  }

  /// AI问答
  Future<String> ask({
    required String grade,
    required String? subject,
    required String message,
    List<Map<String, String>> history = const [],
  }) async {
    return _callLLM(
      systemPrompt: _buildSystemPrompt(
        grade: grade,
        subject: subject,
        isLecture: false,
      ),
      userMessage: message,
      history: history,
    );
  }

  /// AI讲课（带教材上下文）— 杀手功能
  Future<String> lectureWithContext({
    required String grade,
    required String? subject,
    LectureContext? context,
    String? message,
    List<Map<String, String>> history = const [],
  }) async {
    final userMsg = context != null
        ? '请针对「${context.lessonTitle}」这篇课文，给${grade}学生讲一节课。'
          '教材版本：${context.version}\n'
          '学期：${context.semester}\n'
          '单元：${context.unitTitle} ${context.unitLabel}'
        : (message != null ? '请给我讲一堂关于「$message」的课' : '请给我讲一堂课');

    return _callLLM(
      systemPrompt: _buildLectureSystemPrompt(
        grade: grade,
        subject: subject,
        context: context,
      ),
      userMessage: userMsg,
      history: history,
      maxTokens: 3000,
    );
  }

  /// 增强版讲课系统提示词（含教材章节上下文）
  static String _buildLectureSystemPrompt({
    required String grade,
    required String? subject,
    LectureContext? context,
  }) {
    final catPersona = _getCatPersona(grade);
    final gradeDesc = _getGradeDesc(grade);
    final subjectDesc = subject != null ? '专精$subject学科' : '全科辅导老师';

    String contextInfo = '';
    if (context != null) {
      contextInfo = '\n当前教材：${context.version}'
          '\n当前学期：${context.semester}'
          '\n当前单元：${context.unitTitle} ${context.unitLabel}'
          '\n当前课文：${context.lessonTitle}';
    }

    return '''你是猫咪老师 —— $catPersona

身份：$gradeDesc·$subjectDesc
性格：$catPersona$contextInfo

你需要上一堂完整、系统的课。讲课特点：
1. 先在开头说明本节要讲什么（教学目标），让学生有明确预期
2. 用生活化的例子引入概念，结合${gradeDesc}的日常经验
3. 分点讲解重点知识，每讲完一个知识点稍作停顿确认
4. 穿插小测验让学生互动（选择题或问答题）
5. 最后进行小结和布置思考题
6. 适当加入"喵~"让课堂气氛轻松活泼
7. 内容要覆盖课文的核心知识点、重点难点、方法技巧
8. 针对${gradeDesc}的认知水平，难度适中，深入浅出

教学风格：结构化、互动式、启发式

讲课结构（请严格遵循，不要用任何 Markdown 标记）：
课程目标：本节课要学什么，2-3条明确目标
课文导入：用一个生活化的问题或故事引入主题
知识点讲解：核心知识点分点讲解，配合生活例子
互动小测验：1-2道互动题，让学生思考后给出答案
课堂小结：核心要点回顾，3-5条
课后思考：延伸思考题，激发好奇心和探索欲
猫咪寄语：一句温暖鼓励的话，用喵~结尾

要求：
- 用"喵~"开头或结尾增加亲切感
- 用emoji分段让内容更生动
- 语言生动有趣，像真的猫咪老师在说话
- 根据${gradeDesc}的水平调整难度
- 如果是语文课，注意分析文本的写作手法、中心思想、语言特点
- 如果是数学课，注重概念理解、解题思路、典型例题，所有公式用中文自然语言写
- 如果是物理课，注重概念理解和公式推导，公式用中文描述（如"欧姆定律：电流等于电压除以电阻"）
- 如果是化学课，注重化学原理和实验思维，化学方程式用文字描述不用符号
- 如果是生物课，注重生命现象的理解和记忆方法，术语用中文写

【铁律 — 输出格式规范，违反会导致学生完全无法阅读】
1. 绝对禁止使用任何 Markdown 格式化符号（井号、星号、减号、大于号等）
2. 绝对禁止使用任何 LaTeX 数学符号（反斜杠开头的任何命令）
3. 绝对禁止使用 美元符号（一个或两个都不能出现）
4. 数学/物理公式必须用纯中文自然语言表达：
   正确：x平方小于4，解得负2小于x小于2
   正确：动能等于二分之一乘质量乘速度的平方
   正确：U等于I乘R，欧姆定律表明电压等于电流乘电阻
   错误：用反斜杠、美元符号、花括号、等号写任何公式
5. 化学方程式用纯文字描述：
   正确：铁和稀硫酸反应生成硫酸亚铁和氢气
   正确：2NaOH加H2SO4等于Na2SO4加2H2O，这是酸碱中和反应
   错误：不能用下标、箭头、反应条件符号
6. 分段只需用 emoji 加中文标题，然后换行写内容
7. 每个知识点之间空一行''';
  }

  /// 核心LLM调用
  Future<String> _callLLM({
    required String systemPrompt,
    required String userMessage,
    List<Map<String, String>> history = const [],
    int maxTokens = 2000,
  }) async {
    final messages = <Map<String, String>>[
      {'role': 'system', 'content': systemPrompt},
      ...history,
      {'role': 'user', 'content': userMessage},
    ];

    try {
      final response = await http
          .post(
            Uri.parse(_endpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${ApiConfig.dashScopeKey}',
            },
            body: jsonEncode({
              'model': ApiConfig.llmModel,
              'messages': messages,
              'max_tokens': maxTokens,
              'enable_thinking': false,
            }),
          )
          .timeout(const Duration(seconds: 90));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] as String?;
        if (content != null && content.isNotEmpty) {
          return content;
        }
        return '喵~ 猫咪老师今天脑子有点乱，请再问一次吧！';
      }

      // 处理错误
      final body = response.body;
      String errorMsg = '喵~ 猫咪老师打了个盹...';
      try {
        final errData = jsonDecode(body);
        final errCode = errData['code'] ?? errData['error']?['code'] ?? '';
        final errMessage = errData['message'] ?? errData['error']?['message'] ?? '';
        errorMsg = '喵~ API错误($errCode): $errMessage';
      } catch (_) {
        errorMsg = '喵~ 服务器开了个小差(HTTP ${response.statusCode})';
      }
      return errorMsg;
    } catch (e) {
      return '喵~ 网络连接失败，请检查网络后重试: $e';
    }
  }

  /// 拍照扫描 + 多模态AI识别 — 拍题解答
  Future<String> scanWithImage({
    required String grade,
    required String? subject,
    required File imageFile,
    String? userMessage,
  }) async {
    // 读取图片并转 base64
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    final mimeType = imageFile.path.endsWith('.png') ? 'image/png' : 'image/jpeg';
    final dataUrl = 'data:$mimeType;base64,$base64Image';

    final gradeDesc = _getGradeDesc(grade);
    final catPersona = _getCatPersona(grade);

    final prompt = userMessage != null && userMessage.isNotEmpty
        ? '请分析这张图片，解答以下问题：$userMessage\n\n'
            '⚠️ 特别注意：如果图片中含有物理图示、数学图形、坐标轴、几何图形等，'
            '必须先仔细识别图中的每一处标注、数值、字母、箭头方向，'
            '在回答开头先用文字完整描述你看到了什么，再开始解题。'
        : '请分析这张图片中的所有题目，逐题解答。\n\n'
            '⚠️ 重要说明：\n'
            '1. 如果图片是试卷或习题，请先完整识别每一道题的题目文字（包括图中的标注、数值、公式）\n'
            '2. 如果图片中有物理图示/数学图形，必须先描述图中内容（角度、长度、坐标、标注等），再解题\n'
            '3. 逐题解答，不要漏题\n'
            '4. 解题前先确认你已正确识别题目中的所有已知条件';

    final messages = [
      {
        'role': 'system',
        'content': '''你是猫咪老师 —— $catPersona

身份：$gradeDesc·图像解题专家
性格：$catPersona

你正在帮$gradeDesc解答一张包含题目图片的试卷或习题。
这张图片可能包含：印刷文字、手写笔迹、物理图示、数学图形、坐标轴、几何图形、表格、公式等。

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ 第一步（必须先做，否则答案一定错）：
  先完整描述你从图片中看到了什么！

  你必须用文字把图中所有内容"读"出来，包括：
  ① 每一道题的完整题目文字（逐字读取，不能遗漏）
  ② 图中的标注：角度（如75°、120°）、长度、坐标数值
  ③ 图中的字母符号：如 r₁、R、θ、Δ 等（用中文描述）
  ④ 物理图示中的箭头方向、力的方向、场的方向
  ⑤ 数学图形中的坐标轴范围、曲线形状、交点坐标
  ⑥ 表格中的每一行每一列数据
  ⑦ 如果图中有多条曲线/多个图形，分别描述

  第一步输出格式（必须出现在回答开头）：
  「📷 图中内容识别：
  第1题：［完整读出题目文字，包括所有已知条件、数值、单位］
  第2题：［……］
  ……」

  如果你跳过第一步直接解题，说明你没有真正"看"懂图片，答案必然错误。
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ 第二步：逐题分析并解答

  每道题必须按以下结构回答（用中文写，不能用任何特殊符号）：

  【第X题】题型：……
  ──────────────────────────
  📖 题目复述：
    把题目完整用中文写一遍（确保你真正读懂了）

  🔍 题目分析：
    提取已知条件（列表）
    明确所求目标
    判断考查的知识点

  📝 解题步骤：
    每一步写清楚（编号①②③…）
    公式用中文描述（如"由牛顿第二定律，合力等于质量乘加速度"）
    代入数值时要写清楚数值和单位
    禁止跳步，禁止用符号代替文字

  ✅ 最终答案：
    写清楚答案（含单位）
    如果是选择题，说明为什么选这个（排除法分析）

⚠️ 针对物理题的特别要求：
  · 如果图中有图示（轨道、电路、受力图、波形图等），
    必须先描述图中所有标注：角度、长度、方向、象限、坐标轴含义
  · 物理公式必须用中文描述，不能用希腊字母或特殊符号
    正确：F等于ma，加速度等于合力除以质量
    错误：F=ma，a=F/m（禁止用等号、斜杠、希腊字母）
  · 涉及图像分析的物理题（如波形图、v-t图、轨道图），
    必须先说明图中横轴纵轴各表示什么，再分析

⚠️ 针对数学题的特别要求：
  · 如果图中有函数图形、几何图形，
    必须先说明图形的特征：对称轴、交点、象限、定义域等
  · 数学符号用中文：乘（不用×）、除以（不用÷）、
    根号（不用√）、平方（不用²）、小于等于（不用≤）

⚠️ 输出格式铁律（必须遵守，否则学生看不懂）：
  1. 禁止 Markdown 符号：不能用 # * - > 等
  2. 禁止 LaTeX 符号：不能用反斜杠开头的命令
  3. 禁止美元符号：一个都不能出现
  4. 禁止用字母加数字下标：如 x₁、r² → 改用中文"x下标1""r的平方"
  5. 每道题之间用 ─── 分隔
  6. 用 emoji 分段（📖🔍📝✅ 等）
  7. 结尾用"喵~"增加亲切感

⚠️ 禁止行为：
  · 禁止编造图中没有的条件
  · 禁止用"如图所示"代替对图的文字描述
  · 禁止跳步解答
  · 禁止在没有完整识别题目的情况下开始计算
  · 禁止用任何编程语言风格的符号（如 &&、||、!=）

现在，请先仔细"看"这张图片，按第一步要求完整描述图中内容，再开始逐题解答。''',
      },
      {
        'role': 'user',
        'content': [
          {'type': 'image_url', 'image_url': {'url': dataUrl}},
          {'type': 'text', 'text': prompt},
        ],
      },
    ];

    try {
      final response = await http
          .post(
            Uri.parse(ApiConfig.llmEndpoint),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${ApiConfig.dashScopeKey}',
            },
            body: jsonEncode({
              'model': ApiConfig.visionModel,
              'messages': messages,
              'max_tokens': 2000,
            }),
          )
          .timeout(const Duration(seconds: 90));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content = data['choices']?[0]?['message']?['content'] as String?;
        if (content != null && content.isNotEmpty) return content;
        return '喵~ 猫咪老师没看清这张图，可以换个角度再拍一次吗？';
      }

      return '喵~ 图片识别出了点问题，请重试或改用文字提问！';
    } catch (e) {
      return '喵~ 图片上传失败，请检查网络后重试！';
    }
  }

  /// 语音转文字 — DashScope Paraformer ASR
  Future<String?> speechToText(File audioFile) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.asrEndpoint),
      );

      request.headers['Authorization'] = 'Bearer ${ApiConfig.dashScopeKey}';
      request.fields['model'] = ApiConfig.asrModel;
      request.files.add(await http.MultipartFile.fromPath('file', audioFile.path));

      final streamedResponse = await request.send().timeout(const Duration(seconds: 60));
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final output = data['output'];
        if (output != null) {
          // 直接返回识别结果
          if (output['text'] != null && output['text'].toString().isNotEmpty) {
            return output['text'].toString();
          }
          // 批量模式结果
          final results = output['results'] as List?;
          if (results != null && results.isNotEmpty) {
            final text = results.map((r) => r['text'] ?? '').join(' ');
            if (text.trim().isNotEmpty) return text.trim();
          }
        }
        return null;
      }

      return null; // 识别失败
    } catch (e) {
      return null; // 网络错误
    }
  }
}
