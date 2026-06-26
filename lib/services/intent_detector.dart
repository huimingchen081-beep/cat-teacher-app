/// 意图识别服务 — 拦截生图/生视频/生成文档请求，不走普通对话
///
/// 欠揍儿收到这些请求时会先傲娇一番，再实际执行生成任务。
/// 每种任务有对应的互动反馈，保持欠揍人设。

enum GenerationType {
  image,   // 画图/生图
  video,   // 做视频/生成视频
  ppt,     // 做PPT
  word,    // 写文章/做Word
  excel,   // 做表格/Excel
}

class GenerationIntent {
  final GenerationType type;
  final String prompt; // 用户原始需求文本

  const GenerationIntent({required this.type, required this.prompt});
}

class IntentDetector {
  /// 检测用户输入是否包含生成类意图
  /// 返回 null 表示普通聊天，否则返回意图信息
  static GenerationIntent? detect(String text) {
    final t = text.trim();
    if (t.isEmpty) return null;

    // ============ 生图意图 ============
    final imagePatterns = [
      RegExp(r'(画|生成|做|来|给).*(一张|一张图|张图|图片|照片|图像|插画)'),
      RegExp(r'(画|生成).*(猫|狗|花|风景|人物|动漫|二次元|头像|壁纸)'),
      RegExp(r'(帮我|给我|来).*(画|画个|画一张)'),
      RegExp(r'^画\s*\S'),
      RegExp(r'(生成|创建|制作).*(图像|图片|插画|绘画)'),
      RegExp(r'来个.*(图|画|图片|照片)'),
      RegExp(r'AI.*(绘画|作画|画画|画图)'),
    ];
    for (final p in imagePatterns) {
      if (p.hasMatch(t)) return GenerationIntent(type: GenerationType.image, prompt: t);
    }

    // ============ 生视频意图 ============
    final videoPatterns = [
      RegExp(r'(生成|做|制作|创建).*(视频|短视频|动画|影片)'),
      RegExp(r'来个.*(视频|短片|动画)'),
      RegExp(r'(帮我|给我).*(生成|做).*(视频|动画)'),
      RegExp(r'^做.*(视频|动画|短片)'),
    ];
    for (final p in videoPatterns) {
      if (p.hasMatch(t)) return GenerationIntent(type: GenerationType.video, prompt: t);
    }

    // ============ PPT意图 ============
    final pptPatterns = [
      RegExp(r'(生成|做|制作|创建|帮我).*(PPT|ppt|幻灯片|演示文稿|课件)'),
      RegExp(r'来个.*(PPT|ppt|幻灯片|课件)'),
      RegExp(r'(做|准备).*(课件|演示|讲课PPT)'),
    ];
    for (final p in pptPatterns) {
      if (p.hasMatch(t)) return GenerationIntent(type: GenerationType.ppt, prompt: t);
    }

    // ============ Word/文章意图 ============
    final wordPatterns = [
      RegExp(r'(生成|写|做|创建).*(文档|Word|文章|作文|报告|论文|合同)'),
      RegExp(r'帮我.*(写|整).*(文章|作文|报告|总结|文档)'),
      RegExp(r'^写.*(文章|作文|报告|文档)'),
    ];
    for (final p in wordPatterns) {
      if (p.hasMatch(t)) return GenerationIntent(type: GenerationType.word, prompt: t);
    }

    // ============ Excel意图 ============
    final excelPatterns = [
      RegExp(r'(生成|做|创建).*(表格|Excel|excel|数据表|统计表|报表)'),
      RegExp(r'做个.*(表|表格|Excel)'),
      RegExp(r'来个.*(表|表格|Excel|报表)'),
      RegExp(r'帮我.*(统计|汇总|整理).*(数据|信息)'),
    ];
    for (final p in excelPatterns) {
      if (p.hasMatch(t)) return GenerationIntent(type: GenerationType.excel, prompt: t);
    }

    return null; // 普通聊天
  }
}
