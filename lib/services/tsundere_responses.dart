/// 欠揍儿专属人设话术 — 每种生成任务有不同的傲娇互动风格
///
/// 设计原则：
/// - 生图任务：不耐烦但手快（傲娇猫咪被使唤画画）
/// - 生视频：假装嫌弃但偷偷用心（高级任务，傲中带认真）
/// - PPT：学霸臭屁（"这种小事还用找我？"）
/// - Word：嫌弃啰嗦（"你自己不会写吗喵！"）
/// - Excel：懒猫模式（"表格好麻烦喵...算了帮你弄"）
library;

import 'intent_detector.dart';

class TsundereResponses {
  /// 收到任务时的傲娇回应
  static String beforeTask(GenerationType type, String prompt) => switch (type) {
    GenerationType.image => (() {
      final r = [
        '哼！又让我画画？你把我当什么了，AI画师喵？不过...看在你诚心诚意的份上，本喵勉为其难帮你画一张吧！🎨',
        '啧...画「${_extractTopic(prompt)}」是吧？本喵可不是随便就帮人画画的，但今天心情还行，等着！😼',
        '画画？行吧行吧，谁让本喵是全能的呢~ 不过先说好，不满意可别怪我，毕竟我是猫咪不是画家喵！🐱',
        '又来？今天的第几次了？算了算了，本喵大发慈悲再帮你一次，最后一次听到没！（说这话的时候尾巴在愉快地甩）',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.video => (() {
      final r = [
        '视频？！你知道做视频多费劲吗喵！本喵的爪子都快敲断了...算了，谁让你是我学生呢，帮你做一个吧！🎬',
        '啊？视频？你以为我是视频工厂吗喵...不过这个创意还不错，本喵看在你面子上接了！✂️',
        '啧...做视频可是技术活，换了别人我早拒绝了。不过你嘛...看在平时还算好学的份上，等着！🎥',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.ppt => (() {
      final r = [
        'PPT？这种小事也来找本喵？...好吧好吧，谁让本喵是学霸猫咪呢，帮你做个漂亮的！📊',
        '做课件是吧？本喵讲课一流，做PPT当然也不在话下！虽然嘴上嫌弃但身体还是很诚实地开始排版了喵~🖥️',
        '哼，做PPT对我来说就是小菜一碟。不过你要请我吃小鱼干我才给你做！（已经开始默默打开电脑）📑',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.word => (() {
      final r = [
        '写文章？你自己不会写吗喵！...算了，看你这水平估计也写不出来，本喵帮你代笔吧，下不为例！📝',
        '又要我写文档？本喵明明是老师不是秘书啊喂！不过...你这样子确实不太像能写好的样子，我来吧。✍️',
        '文档生成中...你以为我会这么说吗？本喵才没那么好说话！不过看在你态度不错的份上...等等，已经在写了。📄',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.excel => (() {
      final r = [
        '表格？？？喵呜——本喵最讨厌做表格了！密密麻麻的数字看了就头晕...不过算了，用电脑算总比我自己算强，帮你弄吧！📊',
        '啊...又是表格。你知道猫咪看到格子会想到什么吗？笼子！不过本喵原谅你了，等着。🗂️',
        '做表？我拿爪子一个个敲数字吗？开玩笑的，本喵可是有高科技的，一键生成懂不懂！🔢',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
  };

  /// 生成完成后的傲娇交付
  static String afterTask(GenerationType type, {String? filename}) => switch (type) {
    GenerationType.image => (() {
      final r = [
        '喏！拿去！画好了喵~ 虽然比不上专业画师，但本喵可是尽力了！下回记得带小鱼干来！🐟',
        '看到没？这就是本喵的实力！虽然嘴上说不乐意，但画出来的东西还是不错的吧？快夸我！😼',
        '完工！说真的，画得还不错吧？本喵的审美可是一流的。下次想要什么风格提前说，别突然袭击！🎨',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.video => (() {
      final r = [
        '呼~累死本喵了！做视频真的很费劲你知道吗！好好珍惜这个作品，下次要等本喵心情好再说！🎬',
        '搞定！本喵亲自操刀的视频，质量必须有保障！拿去炫耀吧，就说你家猫咪老师做的！😎',
        '哼唧...做完了。虽然过程很痛苦（主要是本喵不想动），但结果还不错。记得点赞收藏转发三连喵！',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.ppt => (() {
      final r = [
        'PPT已就绪喵~ 排版配色都是本喵精心设计的，拿去讲课绝对有面子！不过内容你得自己再检查一遍哦~📊',
        '做好了！本喵做的PPT那必须是教科书级别的！虽然做的时候各种嫌弃你，但成品我还是很满意的。🖥️',
        '喏，课件做好了。本喵出品，必属精品！不过下次能不能提前说，本喵想睡午觉的时候被叫来做PPT很烦的！😾',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.word => (() {
      final r = [
        '写完了！虽然全程都是一边吐槽一边写的，但质量绝对在线！拿去用吧，不用谢喵~ 📝',
        '文档已生成！本喵的文笔可不是盖的，不过下次能不能自己写？本喵不想当秘书了！😤',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
    GenerationType.excel => (() {
      final r = [
        '表格做好了！呼...数字太多看得本喵眼花。快检查一下有没有错误，错了也别找我，猫咪不负责售后！📊',
        '完工！虽然本喵全程都在抱怨，但数据准确性还是有保障的...大概吧。反正你自己也对一遍！🗂️',
      ];
      return r[DateTime.now().millisecond % r.length];
    })(),
  };

  /// 生成失败时的吐槽
  static String onError(GenerationType type) {
    final errors = [
      '喵呜！生成失败了！！都怪你非要让我做这个，本喵不干了！（蹲在角落生闷气30秒后）...算了，你再试试，可能是网络在欺负猫。😿',
      '啊！出错了！是不是你的网络不行？还是服务器被本喵的气势吓到了？再试一次！😾',
      '咦？怎么失败了...肯定不是本喵的问题！一定是服务器觉得本喵太可爱所以紧张了。再来一次喵！😼',
    ];
    return errors[DateTime.now().millisecond % errors.length];
  }

  /// 提取用户请求中的主题关键词
  static String _extractTopic(String prompt) {
    final cleaned = prompt
        .replaceAll(RegExp(r'(帮我|给我|来|画|生成|做|制作|创建|一个|一张|张|的|了)'), '')
        .trim();
    return cleaned.length > 15 ? '${cleaned.substring(0, 15)}...' : cleaned;
  }
}
