/// 教材章节数据模型 - 猫咪老师按教材讲课
library textbook;

import '../config/api_config.dart';
import 'textbook_real_data.dart';

// ============================================================
// 数据模型
// ============================================================

/// 教材版本
class TextbookVersion {
  final String id;        // e.g. "部编版"
  final String name;      // e.g. "部编版"
  final List<TextbookSemester> semesters;

  const TextbookVersion({required this.id, required this.name, required this.semesters});
}

/// 学期（上/下册）
class TextbookSemester {
  final String id;        // e.g. "上册"
  final String name;      // e.g. "一年级上册"
  final String label;     // e.g. "上册"
  final List<TextbookUnit> units;

  const TextbookSemester({required this.id, required this.name, required this.label, required this.units});
}

/// 单元
class TextbookUnit {
  final String id;
  final String title;     // e.g. "第一单元"
  final String label;     // e.g. "识字"
  final List<TextbookLesson> lessons;

  const TextbookUnit({required this.id, required this.title, required this.label, required this.lessons});
}

/// 课文
class TextbookLesson {
  final String id;
  final String title;     // e.g. "天地人"

  const TextbookLesson({required this.id, required this.title});
}

/// 完整的讲课上下文
class LectureContext {
  final String version;
  final String semester;
  final String unitTitle;
  final String unitLabel;
  final String lessonTitle;

  const LectureContext({
    required this.version,
    required this.semester,
    required this.unitTitle,
    required this.unitLabel,
    required this.lessonTitle,
  });
}

// ============================================================
// 教材数据 - 部编版/人教版/PEP版真实目录
// ============================================================

/// 获取指定年级学科的教材版本列表
List<TextbookVersion> getTextbooks(Grade grade, String subjectKey) {
  // 语数英使用专用函数（已包含真实目录）
  switch (subjectKey) {
    case 'chinese': return _getChineseTextbooks(grade);
    case 'math':    return _getMathTextbooks(grade);
    case 'english': return _getEnglishTextbooks(grade);
    // 其余学科使用真实教材数据库
    default:        return getRealTextbooks(grade, subjectKey);
  }
}

// ---------- 语文教材（部编版） ----------
List<TextbookVersion> _getChineseTextbooks(Grade grade) {
  switch (grade) {
    case Grade.primary:
      return [
        TextbookVersion(id: '部编版', name: '部编版', semesters: [
          // 一年级上册
          TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '识字', lessons: [
              TextbookLesson(id: 'l1', title: '天地人'),
              TextbookLesson(id: 'l2', title: '金木水火土'),
              TextbookLesson(id: 'l3', title: '口耳目'),
              TextbookLesson(id: 'l4', title: '日月山川'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '拼音', lessons: [
              TextbookLesson(id: 'l5', title: 'a o e'),
              TextbookLesson(id: 'l6', title: 'i u ü'),
              TextbookLesson(id: 'l7', title: 'b p m f'),
              TextbookLesson(id: 'l8', title: 'd t n l'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '拼音', lessons: [
              TextbookLesson(id: 'l9', title: 'g k h'),
              TextbookLesson(id: 'l10', title: 'j q x'),
              TextbookLesson(id: 'l11', title: 'z c s'),
              TextbookLesson(id: 'l12', title: 'zh ch sh r'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '拼音', lessons: [
              TextbookLesson(id: 'l13', title: 'ai ei ui'),
              TextbookLesson(id: 'l14', title: 'ao ou iu'),
              TextbookLesson(id: 'l15', title: 'ie üe er'),
              TextbookLesson(id: 'l16', title: 'an en in un ün'),
              TextbookLesson(id: 'l17', title: 'ang eng ing ong'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l18', title: '秋天'),
              TextbookLesson(id: 'l19', title: '小小的船'),
              TextbookLesson(id: 'l20', title: '江南'),
              TextbookLesson(id: 'l21', title: '四季'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l22', title: '画'),
              TextbookLesson(id: 'l23', title: '大小多少'),
              TextbookLesson(id: 'l24', title: '小书包'),
              TextbookLesson(id: 'l25', title: '日月明'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l26', title: '影子'),
              TextbookLesson(id: 'l27', title: '比尾巴'),
              TextbookLesson(id: 'l28', title: '青蛙写诗'),
              TextbookLesson(id: 'l29', title: '雨点儿'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l30', title: '明天要远足'),
              TextbookLesson(id: 'l31', title: '大还是小'),
              TextbookLesson(id: 'l32', title: '项链'),
              TextbookLesson(id: 'l33', title: '雪地里的小画家'),
            ]),
          ]),
          // 一年级下册
          TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '识字', lessons: [
              TextbookLesson(id: 'l1', title: '春夏秋冬'),
              TextbookLesson(id: 'l2', title: '姓氏歌'),
              TextbookLesson(id: 'l3', title: '小青蛙'),
              TextbookLesson(id: 'l4', title: '猜字谜'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '识字', lessons: [
              TextbookLesson(id: 'l5', title: '动物儿歌'),
              TextbookLesson(id: 'l6', title: '古对今'),
              TextbookLesson(id: 'l7', title: '操场上'),
              TextbookLesson(id: 'l8', title: '人之初'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l9', title: '吃水不忘挖井人'),
              TextbookLesson(id: 'l10', title: '我多想去看看'),
              TextbookLesson(id: 'l11', title: '一个接一个'),
              TextbookLesson(id: 'l12', title: '四个太阳'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l13', title: '小公鸡和小鸭子'),
              TextbookLesson(id: 'l14', title: '树和喜鹊'),
              TextbookLesson(id: 'l15', title: '怎么都快乐'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '静夜思'),
              TextbookLesson(id: 'l17', title: '夜色'),
              TextbookLesson(id: 'l18', title: '端午粽'),
              TextbookLesson(id: 'l19', title: '彩虹'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l20', title: '古诗二首'),
              TextbookLesson(id: 'l21', title: '荷叶圆圆'),
              TextbookLesson(id: 'l22', title: '要下雨了'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l23', title: '文具的家'),
              TextbookLesson(id: 'l24', title: '一分钟'),
              TextbookLesson(id: 'l25', title: '动物王国开大会'),
              TextbookLesson(id: 'l26', title: '小猴子下山'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l27', title: '棉花姑娘'),
              TextbookLesson(id: 'l28', title: '咕咚'),
              TextbookLesson(id: 'l29', title: '小壁虎借尾巴'),
            ]),
          ]),
          // 二年级上册
          TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '识字', lessons: [
              TextbookLesson(id: 'l1', title: '场景歌'),
              TextbookLesson(id: 'l2', title: '树之歌'),
              TextbookLesson(id: 'l3', title: '拍手歌'),
              TextbookLesson(id: 'l4', title: '田家四季歌'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '小蝌蚪找妈妈'),
              TextbookLesson(id: 'l6', title: '我是什么'),
              TextbookLesson(id: 'l7', title: '植物妈妈有办法'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l8', title: '曹冲称象'),
              TextbookLesson(id: 'l9', title: '玲玲的画'),
              TextbookLesson(id: 'l10', title: '一封信'),
              TextbookLesson(id: 'l11', title: '妈妈睡了'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l12', title: '古诗二首'),
              TextbookLesson(id: 'l13', title: '黄山奇石'),
              TextbookLesson(id: 'l14', title: '日月潭'),
              TextbookLesson(id: 'l15', title: '葡萄沟'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '坐井观天'),
              TextbookLesson(id: 'l17', title: '寒号鸟'),
              TextbookLesson(id: 'l18', title: '我要的是葫芦'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l19', title: '大禹治水'),
              TextbookLesson(id: 'l20', title: '朱德的扁担'),
              TextbookLesson(id: 'l21', title: '难忘的泼水节'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l22', title: '古诗二首'),
              TextbookLesson(id: 'l23', title: '雾在哪里'),
              TextbookLesson(id: 'l24', title: '雪孩子'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l25', title: '狐假虎威'),
              TextbookLesson(id: 'l26', title: '狐狸分奶酪'),
              TextbookLesson(id: 'l27', title: '纸船和风筝'),
              TextbookLesson(id: 'l28', title: '风娃娃'),
            ]),
          ]),
          // 二年级下册
          TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '古诗二首'),
              TextbookLesson(id: 'l2', title: '找春天'),
              TextbookLesson(id: 'l3', title: '开满鲜花的小路'),
              TextbookLesson(id: 'l4', title: '邓小平爷爷植树'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '雷锋叔叔你在哪里'),
              TextbookLesson(id: 'l6', title: '千人糕'),
              TextbookLesson(id: 'l7', title: '一匹出色的马'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '识字', lessons: [
              TextbookLesson(id: 'l8', title: '神州谣'),
              TextbookLesson(id: 'l9', title: '传统节日'),
              TextbookLesson(id: 'l10', title: '"贝"的故事'),
              TextbookLesson(id: 'l11', title: '中国美食'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l12', title: '彩色的梦'),
              TextbookLesson(id: 'l13', title: '枫树上的喜鹊'),
              TextbookLesson(id: 'l14', title: '沙滩上的童话'),
              TextbookLesson(id: 'l15', title: '我是一只小虫子'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '寓言二则'),
              TextbookLesson(id: 'l17', title: '画杨桃'),
              TextbookLesson(id: 'l18', title: '小马过河'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l19', title: '古诗二首'),
              TextbookLesson(id: 'l20', title: '雷雨'),
              TextbookLesson(id: 'l21', title: '要是你在野外迷了路'),
              TextbookLesson(id: 'l22', title: '太空生活趣事多'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l23', title: '大象的耳朵'),
              TextbookLesson(id: 'l24', title: '蜘蛛开店'),
              TextbookLesson(id: 'l25', title: '青蛙卖泥塘'),
              TextbookLesson(id: 'l26', title: '小毛虫'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l27', title: '羿射九日'),
            ]),
          ]),
          // 三年级上册
          TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '大青树下的小学'),
              TextbookLesson(id: 'l2', title: '花的学校'),
              TextbookLesson(id: 'l3', title: '不懂就要问'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l4', title: '古诗三首'),
              TextbookLesson(id: 'l5', title: '铺满金色巴掌的水泥道'),
              TextbookLesson(id: 'l6', title: '秋天的雨'),
              TextbookLesson(id: 'l7', title: '听听秋的声音'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '童话', lessons: [
              TextbookLesson(id: 'l8', title: '去年的树'),
              TextbookLesson(id: 'l9', title: '那一定会很好'),
              TextbookLesson(id: 'l10', title: '在牛肚子里旅行'),
              TextbookLesson(id: 'l11', title: '一块奶酪'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l12', title: '总也倒不了的老屋'),
              TextbookLesson(id: 'l13', title: '胡萝卜先生的长胡子'),
              TextbookLesson(id: 'l14', title: '不会叫的狗'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l15', title: '搭船的鸟'),
              TextbookLesson(id: 'l16', title: '金色的草地'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l17', title: '古诗三首'),
              TextbookLesson(id: 'l18', title: '富饶的西沙群岛'),
              TextbookLesson(id: 'l19', title: '海滨小城'),
              TextbookLesson(id: 'l20', title: '美丽的小兴安岭'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l21', title: '大自然的声音'),
              TextbookLesson(id: 'l22', title: '父亲、树林和鸟'),
              TextbookLesson(id: 'l23', title: '带刺的朋友'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l24', title: '司马光'),
              TextbookLesson(id: 'l25', title: '掌声'),
              TextbookLesson(id: 'l26', title: '灰雀'),
              TextbookLesson(id: 'l27', title: '手术台就是阵地'),
            ]),
          ]),
          // 三年级下册
          TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '古诗三首'),
              TextbookLesson(id: 'l2', title: '燕子'),
              TextbookLesson(id: 'l3', title: '荷花'),
              TextbookLesson(id: 'l4', title: '昆虫备忘录'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '寓言', lessons: [
              TextbookLesson(id: 'l5', title: '守株待兔'),
              TextbookLesson(id: 'l6', title: '陶罐和铁罐'),
              TextbookLesson(id: 'l7', title: '鹿角和鹿腿'),
              TextbookLesson(id: 'l8', title: '池子与河流'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l9', title: '古诗三首'),
              TextbookLesson(id: 'l10', title: '纸的发明'),
              TextbookLesson(id: 'l11', title: '赵州桥'),
              TextbookLesson(id: 'l12', title: '一幅名扬中外的画'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l13', title: '花钟'),
              TextbookLesson(id: 'l14', title: '蜜蜂'),
              TextbookLesson(id: 'l15', title: '小虾'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '小真的长头发'),
              TextbookLesson(id: 'l17', title: '我变成了一棵树'),
              TextbookLesson(id: 'l18', title: '童年的水墨画'),
              TextbookLesson(id: 'l19', title: '剃头大师'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l20', title: '肥皂泡'),
              TextbookLesson(id: 'l21', title: '我不能失信'),
              TextbookLesson(id: 'l22', title: '我们奇妙的世界'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l23', title: '海底世界'),
              TextbookLesson(id: 'l24', title: '火烧云'),
              TextbookLesson(id: 'l25', title: '慢性子裁缝和急性子顾客'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l26', title: '方帽子店'),
              TextbookLesson(id: 'l27', title: '漏'),
              TextbookLesson(id: 'l28', title: '枣核'),
            ]),
          ]),
          // 四年级上册
          TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '观潮'),
              TextbookLesson(id: 'l2', title: '走月亮'),
              TextbookLesson(id: 'l3', title: '现代诗二首'),
              TextbookLesson(id: 'l4', title: '繁星'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '一个豆荚里的五粒豆'),
              TextbookLesson(id: 'l6', title: '蝙蝠和雷达'),
              TextbookLesson(id: 'l7', title: '呼风唤雨的世纪'),
              TextbookLesson(id: 'l8', title: '蝴蝶的家'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l9', title: '古诗三首'),
              TextbookLesson(id: 'l10', title: '爬山虎的脚'),
              TextbookLesson(id: 'l11', title: '蟋蟀的住宅'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '神话', lessons: [
              TextbookLesson(id: 'l12', title: '盘古开天地'),
              TextbookLesson(id: 'l13', title: '精卫填海'),
              TextbookLesson(id: 'l14', title: '普罗米修斯'),
              TextbookLesson(id: 'l15', title: '女娲补天'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '麻雀'),
              TextbookLesson(id: 'l17', title: '爬天都峰'),
              TextbookLesson(id: 'l18', title: '牛和鹅'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l19', title: '一只窝囊的大老虎'),
              TextbookLesson(id: 'l20', title: '陀螺'),
              TextbookLesson(id: 'l21', title: '古诗三首'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l22', title: '为中华之崛起而读书'),
              TextbookLesson(id: 'l23', title: '梅兰芳蓄须'),
              TextbookLesson(id: 'l24', title: '延安，我把你追寻'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l25', title: '王戎不取道旁李'),
              TextbookLesson(id: 'l26', title: '西门豹治邺'),
              TextbookLesson(id: 'l27', title: '故事二则'),
            ]),
          ]),
          // 四年级下册
          TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '古诗三首'),
              TextbookLesson(id: 'l2', title: '乡下人家'),
              TextbookLesson(id: 'l3', title: '天窗'),
              TextbookLesson(id: 'l4', title: '三月桃花水'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '琥珀'),
              TextbookLesson(id: 'l6', title: '飞向蓝天的恐龙'),
              TextbookLesson(id: 'l7', title: '纳米技术就在我们身边'),
              TextbookLesson(id: 'l8', title: '千年梦圆在今朝'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '诗歌', lessons: [
              TextbookLesson(id: 'l9', title: '短诗三首'),
              TextbookLesson(id: 'l10', title: '绿'),
              TextbookLesson(id: 'l11', title: '白桦'),
              TextbookLesson(id: 'l12', title: '在天晴了的时候'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l13', title: '猫'),
              TextbookLesson(id: 'l14', title: '母鸡'),
              TextbookLesson(id: 'l15', title: '白鹅'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '海上日出'),
              TextbookLesson(id: 'l17', title: '记金华的双龙洞'),
              TextbookLesson(id: 'l18', title: '颐和园'),
              TextbookLesson(id: 'l19', title: '七月的天山'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l20', title: '小英雄雨来'),
              TextbookLesson(id: 'l21', title: '我们家的男子汉'),
              TextbookLesson(id: 'l22', title: '芦花鞋'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l23', title: '古诗三首'),
              TextbookLesson(id: 'l24', title: '黄继光'),
              TextbookLesson(id: 'l25', title: '挑山工'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l26', title: '宝葫芦的秘密'),
              TextbookLesson(id: 'l27', title: '巨人的花园'),
              TextbookLesson(id: 'l28', title: '海的女儿'),
            ]),
          ]),
          // 五年级上册
          TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '白鹭'),
              TextbookLesson(id: 'l2', title: '落花生'),
              TextbookLesson(id: 'l3', title: '桂花雨'),
              TextbookLesson(id: 'l4', title: '珍珠鸟'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '搭石'),
              TextbookLesson(id: 'l6', title: '将相和'),
              TextbookLesson(id: 'l7', title: '什么比猎豹的速度更快'),
              TextbookLesson(id: 'l8', title: '冀中的地道战'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '民间故事', lessons: [
              TextbookLesson(id: 'l9', title: '猎人海力布'),
              TextbookLesson(id: 'l10', title: '牛郎织女（一）'),
              TextbookLesson(id: 'l11', title: '牛郎织女（二）'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l12', title: '古诗三首'),
              TextbookLesson(id: 'l13', title: '少年中国说'),
              TextbookLesson(id: 'l14', title: '圆明园的毁灭'),
              TextbookLesson(id: 'l15', title: '小岛'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l16', title: '太阳'),
              TextbookLesson(id: 'l17', title: '松鼠'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l18', title: '慈母情深'),
              TextbookLesson(id: 'l19', title: '父爱之舟'),
              TextbookLesson(id: 'l20', title: '"精彩极了"和"糟糕透了"'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l21', title: '古诗词三首'),
              TextbookLesson(id: 'l22', title: '四季之美'),
              TextbookLesson(id: 'l23', title: '鸟的天堂'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l24', title: '古人谈读书'),
              TextbookLesson(id: 'l25', title: '忆读书'),
              TextbookLesson(id: 'l26', title: '我的"长生果"'),
            ]),
          ]),
          // 五年级下册
          TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '古诗三首'),
              TextbookLesson(id: 'l2', title: '祖父的园子'),
              TextbookLesson(id: 'l3', title: '月是故乡明'),
              TextbookLesson(id: 'l4', title: '梅花魂'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '草船借箭'),
              TextbookLesson(id: 'l6', title: '景阳冈'),
              TextbookLesson(id: 'l7', title: '猴王出世'),
              TextbookLesson(id: 'l8', title: '红楼春趣'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '综合性学习', lessons: [
              TextbookLesson(id: 'l9', title: '汉字真有趣'),
              TextbookLesson(id: 'l10', title: '我爱你，汉字'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l11', title: '古诗三首'),
              TextbookLesson(id: 'l12', title: '青山处处埋忠骨'),
              TextbookLesson(id: 'l13', title: '军神'),
              TextbookLesson(id: 'l14', title: '清贫'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l15', title: '人物描写一组'),
              TextbookLesson(id: 'l16', title: '刷子李'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l17', title: '自相矛盾'),
              TextbookLesson(id: 'l18', title: '田忌赛马'),
              TextbookLesson(id: 'l19', title: '跳水'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l20', title: '威尼斯的小艇'),
              TextbookLesson(id: 'l21', title: '牧场之国'),
              TextbookLesson(id: 'l22', title: '金字塔'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l23', title: '杨氏之子'),
              TextbookLesson(id: 'l24', title: '手指'),
              TextbookLesson(id: 'l25', title: '童年的发现'),
            ]),
          ]),
          // 六年级上册
          TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '草原'),
              TextbookLesson(id: 'l2', title: '丁香结'),
              TextbookLesson(id: 'l3', title: '古诗词三首'),
              TextbookLesson(id: 'l4', title: '花之歌'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '七律·长征'),
              TextbookLesson(id: 'l6', title: '狼牙山五壮士'),
              TextbookLesson(id: 'l7', title: '开国大典'),
              TextbookLesson(id: 'l8', title: '灯光'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l9', title: '竹节人'),
              TextbookLesson(id: 'l10', title: '宇宙生命之谜'),
              TextbookLesson(id: 'l11', title: '故宫博物院'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '小说', lessons: [
              TextbookLesson(id: 'l12', title: '桥'),
              TextbookLesson(id: 'l13', title: '穷人'),
              TextbookLesson(id: 'l14', title: '在柏林'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l15', title: '夏天里的成长'),
              TextbookLesson(id: 'l16', title: '盼'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l17', title: '古诗三首'),
              TextbookLesson(id: 'l18', title: '只有一个地球'),
              TextbookLesson(id: 'l19', title: '青山不老'),
              TextbookLesson(id: 'l20', title: '三黑和土地'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l21', title: '文言文二则'),
              TextbookLesson(id: 'l22', title: '月光曲'),
              TextbookLesson(id: 'l23', title: '京剧趣谈'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '课文', lessons: [
              TextbookLesson(id: 'l24', title: '少年闰土'),
              TextbookLesson(id: 'l25', title: '好的故事'),
              TextbookLesson(id: 'l26', title: '我的伯父鲁迅先生'),
              TextbookLesson(id: 'l27', title: '有的人'),
            ]),
          ]),
          // 六年级下册
          TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '课文', lessons: [
              TextbookLesson(id: 'l1', title: '北京的春节'),
              TextbookLesson(id: 'l2', title: '腊八粥'),
              TextbookLesson(id: 'l3', title: '古诗三首'),
              TextbookLesson(id: 'l4', title: '藏戏'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '课文', lessons: [
              TextbookLesson(id: 'l5', title: '鲁滨逊漂流记（节选）'),
              TextbookLesson(id: 'l6', title: '骑鹅旅行记（节选）'),
              TextbookLesson(id: 'l7', title: '汤姆·索亚历险记（节选）'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '课文', lessons: [
              TextbookLesson(id: 'l8', title: '匆匆'),
              TextbookLesson(id: 'l9', title: '那个星期天'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '课文', lessons: [
              TextbookLesson(id: 'l10', title: '古诗三首'),
              TextbookLesson(id: 'l11', title: '十六年前的回忆'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '课文', lessons: [
              TextbookLesson(id: 'l12', title: '为人民服务'),
              TextbookLesson(id: 'l13', title: '董存瑞舍身炸暗堡'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '课文', lessons: [
              TextbookLesson(id: 'l14', title: '文言文二则'),
              TextbookLesson(id: 'l15', title: '真理诞生于一百个问号之后'),
              TextbookLesson(id: 'l16', title: '表里的生物'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '课文', lessons: [
              TextbookLesson(id: 'l17', title: '他们那时候多有趣啊'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '综合性学习', lessons: [
              TextbookLesson(id: 'l18', title: '回忆往事'),
              TextbookLesson(id: 'l19', title: '依依惜别'),
            ]),
          ]),
        ]),
      ];

    case Grade.junior:
      return [
        TextbookVersion(id: '部编版', name: '部编版', semesters: [
          // 七年级上册
          TextbookSemester(id: '初一上', name: '七年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '四季美景', lessons: [
              TextbookLesson(id: 'l1', title: '春'),
              TextbookLesson(id: 'l2', title: '济南的冬天'),
              TextbookLesson(id: 'l3', title: '雨的四季'),
              TextbookLesson(id: 'l4', title: '古代诗歌四首'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '至爱亲情', lessons: [
              TextbookLesson(id: 'l5', title: '秋天的怀念'),
              TextbookLesson(id: 'l6', title: '散步'),
              TextbookLesson(id: 'l7', title: '散文诗二首'),
              TextbookLesson(id: 'l8', title: '世说新语二则'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '学习生活', lessons: [
              TextbookLesson(id: 'l9', title: '从百草园到三味书屋'),
              TextbookLesson(id: 'l10', title: '再塑生命的人'),
              TextbookLesson(id: 'l11', title: '论语十二章'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '人生之舟', lessons: [
              TextbookLesson(id: 'l12', title: '纪念白求恩'),
              TextbookLesson(id: 'l13', title: '植树的牧羊人'),
              TextbookLesson(id: 'l14', title: '走一步再走一步'),
              TextbookLesson(id: 'l15', title: '诫子书'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '人与动物', lessons: [
              TextbookLesson(id: 'l16', title: '猫'),
              TextbookLesson(id: 'l17', title: '动物笑谈'),
              TextbookLesson(id: 'l18', title: '狼'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '想象之翼', lessons: [
              TextbookLesson(id: 'l19', title: '皇帝的新装'),
              TextbookLesson(id: 'l20', title: '天上的街市'),
              TextbookLesson(id: 'l21', title: '女娲造人'),
              TextbookLesson(id: 'l22', title: '寓言四则'),
            ]),
          ]),
          // 七年级下册
          TextbookSemester(id: '初一下', name: '七年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '杰出人物', lessons: [
              TextbookLesson(id: 'l1', title: '邓稼先'),
              TextbookLesson(id: 'l2', title: '说和做'),
              TextbookLesson(id: 'l3', title: '回忆鲁迅先生'),
              TextbookLesson(id: 'l4', title: '孙权劝学'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '家国情怀', lessons: [
              TextbookLesson(id: 'l5', title: '黄河颂'),
              TextbookLesson(id: 'l6', title: '老山界'),
              TextbookLesson(id: 'l7', title: '谁是最可爱的人'),
              TextbookLesson(id: 'l8', title: '木兰诗'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '凡人小事', lessons: [
              TextbookLesson(id: 'l9', title: '阿长与山海经'),
              TextbookLesson(id: 'l10', title: '老王'),
              TextbookLesson(id: 'l11', title: '台阶'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '修身正己', lessons: [
              TextbookLesson(id: 'l12', title: '叶圣陶先生二三事'),
              TextbookLesson(id: 'l13', title: '驿路梨花'),
              TextbookLesson(id: 'l14', title: '最苦与最乐'),
              TextbookLesson(id: 'l15', title: '短文两篇'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '借物抒怀', lessons: [
              TextbookLesson(id: 'l16', title: '紫藤萝瀑布'),
              TextbookLesson(id: 'l17', title: '一棵小桃树'),
              TextbookLesson(id: 'l18', title: '外国诗二首'),
              TextbookLesson(id: 'l19', title: '古代诗歌五首'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '科幻探险', lessons: [
              TextbookLesson(id: 'l20', title: '伟大的悲剧'),
              TextbookLesson(id: 'l21', title: '太空一日'),
              TextbookLesson(id: 'l22', title: '带上她的眼睛'),
              TextbookLesson(id: 'l23', title: '河中石兽'),
            ]),
          ]),
          // 八年级上册
          TextbookSemester(id: '初二上', name: '八年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '社会变化', lessons: [
              TextbookLesson(id: 'l1', title: '消息二则'),
              TextbookLesson(id: 'l2', title: '首届诺贝尔奖颁发'),
              TextbookLesson(id: 'l3', title: '飞天凌空'),
              TextbookLesson(id: 'l4', title: '一着惊海天'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '生活记忆', lessons: [
              TextbookLesson(id: 'l5', title: '藤野先生'),
              TextbookLesson(id: 'l6', title: '回忆我的母亲'),
              TextbookLesson(id: 'l7', title: '列夫托尔斯泰'),
              TextbookLesson(id: 'l8', title: '美丽的颜色'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '山水美景', lessons: [
              TextbookLesson(id: 'l9', title: '三峡'),
              TextbookLesson(id: 'l10', title: '答谢中书书'),
              TextbookLesson(id: 'l11', title: '记承天寺夜游'),
              TextbookLesson(id: 'l12', title: '与朱元思书'),
              TextbookLesson(id: 'l13', title: '唐诗五首'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '情感哲思', lessons: [
              TextbookLesson(id: 'l14', title: '背影'),
              TextbookLesson(id: 'l15', title: '白杨礼赞'),
              TextbookLesson(id: 'l16', title: '散文二篇'),
              TextbookLesson(id: 'l17', title: '昆明的雨'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '文明印记', lessons: [
              TextbookLesson(id: 'l18', title: '中国石拱桥'),
              TextbookLesson(id: 'l19', title: '苏州园林'),
              TextbookLesson(id: 'l20', title: '蝉'),
              TextbookLesson(id: 'l21', title: '梦回繁华'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '品格志趣', lessons: [
              TextbookLesson(id: 'l22', title: '孟子三章'),
              TextbookLesson(id: 'l23', title: '愚公移山'),
              TextbookLesson(id: 'l24', title: '周亚夫军细柳'),
              TextbookLesson(id: 'l25', title: '诗词五首'),
            ]),
          ]),
          // 八年级下册
          TextbookSemester(id: '初二下', name: '八年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '民俗风情', lessons: [
              TextbookLesson(id: 'l1', title: '社戏'),
              TextbookLesson(id: 'l2', title: '回延安'),
              TextbookLesson(id: 'l3', title: '安塞腰鼓'),
              TextbookLesson(id: 'l4', title: '灯笼'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '科学道理', lessons: [
              TextbookLesson(id: 'l5', title: '大自然的语言'),
              TextbookLesson(id: 'l6', title: '阿西莫夫短文两篇'),
              TextbookLesson(id: 'l7', title: '大雁归来'),
              TextbookLesson(id: 'l8', title: '时间的脚印'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '古人智慧', lessons: [
              TextbookLesson(id: 'l9', title: '桃花源记'),
              TextbookLesson(id: 'l10', title: '小石潭记'),
              TextbookLesson(id: 'l11', title: '核舟记'),
              TextbookLesson(id: 'l12', title: '诗经二首'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '演讲辩论', lessons: [
              TextbookLesson(id: 'l13', title: '最后一次讲演'),
              TextbookLesson(id: 'l14', title: '应有格物致知精神'),
              TextbookLesson(id: 'l15', title: '我一生中的重要抉择'),
              TextbookLesson(id: 'l16', title: '庆祝奥林匹克运动复兴25周年'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '山水游记', lessons: [
              TextbookLesson(id: 'l17', title: '壶口瀑布'),
              TextbookLesson(id: 'l18', title: '在长江源头各拉丹冬'),
              TextbookLesson(id: 'l19', title: '登勃朗峰'),
              TextbookLesson(id: 'l20', title: '一滴水经过丽江'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '理想追求', lessons: [
              TextbookLesson(id: 'l21', title: '北冥有鱼'),
              TextbookLesson(id: 'l22', title: '庄子与惠子游于濠梁之上'),
              TextbookLesson(id: 'l23', title: '虽有嘉肴'),
              TextbookLesson(id: 'l24', title: '大道之行也'),
              TextbookLesson(id: 'l25', title: '马说'),
              TextbookLesson(id: 'l26', title: '唐诗三首'),
            ]),
          ]),
          // 九年级上册
          TextbookSemester(id: '初三上', name: '九年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '诗歌韵味', lessons: [
              TextbookLesson(id: 'l1', title: '沁园春雪'),
              TextbookLesson(id: 'l2', title: '我爱这土地'),
              TextbookLesson(id: 'l3', title: '乡愁'),
              TextbookLesson(id: 'l4', title: '你是人间的四月天'),
              TextbookLesson(id: 'l5', title: '我看'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '思想光芒', lessons: [
              TextbookLesson(id: 'l6', title: '敬业与乐业'),
              TextbookLesson(id: 'l7', title: '就英法联军远征中国致巴特勒上尉的信'),
              TextbookLesson(id: 'l8', title: '论教养'),
              TextbookLesson(id: 'l9', title: '精神的三间小屋'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '山水寄情', lessons: [
              TextbookLesson(id: 'l10', title: '岳阳楼记'),
              TextbookLesson(id: 'l11', title: '醉翁亭记'),
              TextbookLesson(id: 'l12', title: '湖心亭看雪'),
              TextbookLesson(id: 'l13', title: '诗词三首'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '青春成长', lessons: [
              TextbookLesson(id: 'l14', title: '故乡'),
              TextbookLesson(id: 'l15', title: '我的叔叔于勒'),
              TextbookLesson(id: 'l16', title: '孤独之旅'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '理性思辨', lessons: [
              TextbookLesson(id: 'l17', title: '中国人失掉自信力了吗'),
              TextbookLesson(id: 'l18', title: '怀疑与学问'),
              TextbookLesson(id: 'l19', title: '谈创造性思维'),
              TextbookLesson(id: 'l20', title: '创造宣言'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '人物风采', lessons: [
              TextbookLesson(id: 'l21', title: '智取生辰纲'),
              TextbookLesson(id: 'l22', title: '范进中举'),
              TextbookLesson(id: 'l23', title: '三顾茅庐'),
              TextbookLesson(id: 'l24', title: '刘姥姥进大观园'),
            ]),
          ]),
          // 九年级下册
          TextbookSemester(id: '初三下', name: '九年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '爱国情怀', lessons: [
              TextbookLesson(id: 'l1', title: '祖国啊我亲爱的祖国'),
              TextbookLesson(id: 'l2', title: '梅岭三章'),
              TextbookLesson(id: 'l3', title: '短诗五首'),
              TextbookLesson(id: 'l4', title: '海燕'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '人物画廊', lessons: [
              TextbookLesson(id: 'l5', title: '孔乙己'),
              TextbookLesson(id: 'l6', title: '变色龙'),
              TextbookLesson(id: 'l7', title: '溜索'),
              TextbookLesson(id: 'l8', title: '蒲柳人家'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '传统经典', lessons: [
              TextbookLesson(id: 'l9', title: '鱼我所欲也'),
              TextbookLesson(id: 'l10', title: '唐雎不辱使命'),
              TextbookLesson(id: 'l11', title: '送东阳马生序'),
              TextbookLesson(id: 'l12', title: '词四首'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '文艺审美', lessons: [
              TextbookLesson(id: 'l13', title: '短文两篇'),
              TextbookLesson(id: 'l14', title: '山水画的意境'),
              TextbookLesson(id: 'l15', title: '无言之美'),
              TextbookLesson(id: 'l16', title: '驱散我们的想象'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '戏剧舞台', lessons: [
              TextbookLesson(id: 'l17', title: '屈原节选'),
              TextbookLesson(id: 'l18', title: '天下第一楼节选'),
              TextbookLesson(id: 'l19', title: '枣儿'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '治国理政', lessons: [
              TextbookLesson(id: 'l20', title: '曹刿论战'),
              TextbookLesson(id: 'l21', title: '邹忌讽齐王纳谏'),
              TextbookLesson(id: 'l22', title: '出师表'),
              TextbookLesson(id: 'l23', title: '诗词曲五首'),
            ]),
          ]),
        ]),
      ];

    case Grade.senior:
      return [
        TextbookVersion(id: '部编版', name: '部编版', semesters: [
          // 必修上册
          TextbookSemester(id: '必修上', name: '必修上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '青春激扬', lessons: [
              TextbookLesson(id: 'l1', title: '沁园春长沙'),
              TextbookLesson(id: 'l2', title: '立在地球边上放号'),
              TextbookLesson(id: 'l3', title: '红烛'),
              TextbookLesson(id: 'l4', title: '峨日朵雪峰之侧'),
              TextbookLesson(id: 'l5', title: '致云雀'),
              TextbookLesson(id: 'l6', title: '百合花'),
              TextbookLesson(id: 'l7', title: '哦香雪'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '劳动光荣', lessons: [
              TextbookLesson(id: 'l8', title: '喜看稻菽千重浪'),
              TextbookLesson(id: 'l9', title: '心有一团火温暖众人心'),
              TextbookLesson(id: 'l10', title: '探界者钟扬'),
              TextbookLesson(id: 'l11', title: '以工匠精神雕琢时代品质'),
              TextbookLesson(id: 'l12', title: '芣苢'),
              TextbookLesson(id: 'l13', title: '文氏外孙入村收麦'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '诗意人生', lessons: [
              TextbookLesson(id: 'l14', title: '短歌行'),
              TextbookLesson(id: 'l15', title: '归园田居其一'),
              TextbookLesson(id: 'l16', title: '梦游天姥吟留别'),
              TextbookLesson(id: 'l17', title: '登高'),
              TextbookLesson(id: 'l18', title: '琵琶行并序'),
              TextbookLesson(id: 'l19', title: '念奴娇赤壁怀古'),
              TextbookLesson(id: 'l20', title: '永遇乐京口北固亭怀古'),
              TextbookLesson(id: 'l21', title: '声声慢'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '家乡文化', lessons: [
              TextbookLesson(id: 'l22', title: '家乡文化生活'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '乡土情怀', lessons: [
              TextbookLesson(id: 'l23', title: '乡土中国'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '学习之道', lessons: [
              TextbookLesson(id: 'l24', title: '劝学'),
              TextbookLesson(id: 'l25', title: '师说'),
              TextbookLesson(id: 'l26', title: '反对党八股'),
              TextbookLesson(id: 'l27', title: '拿来主义'),
              TextbookLesson(id: 'l28', title: '读书目的和前提'),
              TextbookLesson(id: 'l29', title: '上图书馆'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '自然情怀', lessons: [
              TextbookLesson(id: 'l30', title: '故都的秋'),
              TextbookLesson(id: 'l31', title: '荷塘月色'),
              TextbookLesson(id: 'l32', title: '我与地坛节选'),
              TextbookLesson(id: 'l33', title: '赤壁赋'),
              TextbookLesson(id: 'l34', title: '登泰山记'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '语言家园', lessons: [
              TextbookLesson(id: 'l35', title: '词语积累与词语解释'),
            ]),
          ]),
          // 必修下册
          TextbookSemester(id: '必修下', name: '必修下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '文明之光', lessons: [
              TextbookLesson(id: 'l1', title: '子路曾皙冉有公西华侍坐'),
              TextbookLesson(id: 'l2', title: '齐桓晋文之事'),
              TextbookLesson(id: 'l3', title: '庖丁解牛'),
              TextbookLesson(id: 'l4', title: '烛之武退秦师'),
              TextbookLesson(id: 'l5', title: '鸿门宴'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '良知悲悯', lessons: [
              TextbookLesson(id: 'l6', title: '窦娥冤节选'),
              TextbookLesson(id: 'l7', title: '雷雨节选'),
              TextbookLesson(id: 'l8', title: '哈姆莱特节选'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '科学探索', lessons: [
              TextbookLesson(id: 'l9', title: '青蒿素人类征服疾病的一小步'),
              TextbookLesson(id: 'l10', title: '一名物理学家的教育历程'),
              TextbookLesson(id: 'l11', title: '中国建筑的特征'),
              TextbookLesson(id: 'l12', title: '说木叶'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '媒介素养', lessons: [
              TextbookLesson(id: 'l13', title: '信息时代的语文生活'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '时代使命', lessons: [
              TextbookLesson(id: 'l14', title: '在人民报创刊纪念会上的演说'),
              TextbookLesson(id: 'l15', title: '在马克思墓前的讲话'),
              TextbookLesson(id: 'l16', title: '谏逐客书'),
              TextbookLesson(id: 'l17', title: '与妻书'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '社会观察', lessons: [
              TextbookLesson(id: 'l18', title: '祝福'),
              TextbookLesson(id: 'l19', title: '林教头风雪山神庙'),
              TextbookLesson(id: 'l20', title: '装在套子里的人'),
              TextbookLesson(id: 'l21', title: '促织'),
              TextbookLesson(id: 'l22', title: '变形记节选'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '不朽名著', lessons: [
              TextbookLesson(id: 'l23', title: '红楼梦'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '责任担当', lessons: [
              TextbookLesson(id: 'l24', title: '谏太宗十思疏'),
              TextbookLesson(id: 'l25', title: '答司马谏议书'),
              TextbookLesson(id: 'l26', title: '阿房宫赋'),
              TextbookLesson(id: 'l27', title: '六国论'),
            ]),
          ]),
          // 选择性必修上册
          TextbookSemester(id: '选必上', name: '选择性必修上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '革命精神', lessons: [
              TextbookLesson(id: 'l1', title: '中国人民站起来了'),
              TextbookLesson(id: 'l2', title: '长征胜利万岁'),
              TextbookLesson(id: 'l3', title: '大战中的插曲'),
              TextbookLesson(id: 'l4', title: '别了不列颠尼亚'),
              TextbookLesson(id: 'l5', title: '县委书记的榜样焦裕禄'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '传统文化', lessons: [
              TextbookLesson(id: 'l6', title: '论语十二章'),
              TextbookLesson(id: 'l7', title: '大学之道'),
              TextbookLesson(id: 'l8', title: '人皆有不忍人之心'),
              TextbookLesson(id: 'l9', title: '老子四章'),
              TextbookLesson(id: 'l10', title: '五石之瓠'),
              TextbookLesson(id: 'l11', title: '兼爱'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '外国小说', lessons: [
              TextbookLesson(id: 'l12', title: '大卫科波菲尔节选'),
              TextbookLesson(id: 'l13', title: '复活节选'),
              TextbookLesson(id: 'l14', title: '老人与海节选'),
              TextbookLesson(id: 'l15', title: '百年孤独节选'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '逻辑力量', lessons: [
              TextbookLesson(id: 'l16', title: '逻辑的力量'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '历史回响', lessons: [
              TextbookLesson(id: 'l17', title: '屈原列传'),
              TextbookLesson(id: 'l18', title: '苏武传'),
              TextbookLesson(id: 'l19', title: '过秦论'),
              TextbookLesson(id: 'l20', title: '五代史伶官传序'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '家国情怀', lessons: [
              TextbookLesson(id: 'l21', title: '记念刘和珍君'),
              TextbookLesson(id: 'l22', title: '为了忘却的记念'),
              TextbookLesson(id: 'l23', title: '包身工'),
              TextbookLesson(id: 'l24', title: '荷花淀'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '文学经典', lessons: [
              TextbookLesson(id: 'l25', title: '小二黑结婚'),
              TextbookLesson(id: 'l26', title: '党费'),
              TextbookLesson(id: 'l27', title: '阿Q正传节选'),
              TextbookLesson(id: 'l28', title: '边城节选'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '文化传承', lessons: [
              TextbookLesson(id: 'l29', title: '诗经选'),
              TextbookLesson(id: 'l30', title: '楚辞选'),
              TextbookLesson(id: 'l31', title: '乐府诗选'),
              TextbookLesson(id: 'l32', title: '唐诗选'),
              TextbookLesson(id: 'l33', title: '宋词选'),
            ]),
          ]),
          // 选择性必修中册
          TextbookSemester(id: '选必中', name: '选择性必修中册', label: '中册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '求真求实', lessons: [
              TextbookLesson(id: 'l1', title: '改造我们的学习'),
              TextbookLesson(id: 'l2', title: '人的正确思想是从哪里来的'),
              TextbookLesson(id: 'l3', title: '实践是检验真理的唯一标准'),
              TextbookLesson(id: 'l4', title: '修辞立其诚'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '英雄赞歌', lessons: [
              TextbookLesson(id: 'l5', title: '荷花淀'),
              TextbookLesson(id: 'l6', title: '小二黑结婚'),
              TextbookLesson(id: 'l7', title: '党费'),
              TextbookLesson(id: 'l8', title: '红岩节选'),
              TextbookLesson(id: 'l9', title: '平凡的世界节选'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '历史兴衰', lessons: [
              TextbookLesson(id: 'l10', title: '过秦论上'),
              TextbookLesson(id: 'l11', title: '伶官传序'),
              TextbookLesson(id: 'l12', title: '种树郭橐驼传'),
              TextbookLesson(id: 'l13', title: '石钟山记'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '文艺鉴赏', lessons: [
              TextbookLesson(id: 'l14', title: '谈中国诗'),
              TextbookLesson(id: 'l15', title: '中国建筑的特征节选'),
              TextbookLesson(id: 'l16', title: '中国艺术表现里的虚和实'),
              TextbookLesson(id: 'l17', title: '咬文嚼字'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '文化根脉', lessons: [
              TextbookLesson(id: 'l18', title: '论语导读'),
              TextbookLesson(id: 'l19', title: '史记导读'),
              TextbookLesson(id: 'l20', title: '唐诗导读'),
              TextbookLesson(id: 'l21', title: '宋词导读'),
              TextbookLesson(id: 'l22', title: '元曲导读'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '自然生态', lessons: [
              TextbookLesson(id: 'l23', title: '自然选择的证明'),
              TextbookLesson(id: 'l24', title: '宇宙的边疆'),
              TextbookLesson(id: 'l25', title: '动物游戏之谜'),
              TextbookLesson(id: 'l26', title: '植物知道生命的答案'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '信息时代', lessons: [
              TextbookLesson(id: 'l27', title: '信息时代的语文生活'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '心灵剧场', lessons: [
              TextbookLesson(id: 'l28', title: '雷雨全剧'),
              TextbookLesson(id: 'l29', title: '哈姆莱特全剧'),
              TextbookLesson(id: 'l30', title: '茶馆节选'),
            ]),
          ]),
          // 选择性必修下册
          TextbookSemester(id: '选必下', name: '选择性必修下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '诗骚传统', lessons: [
              TextbookLesson(id: 'l1', title: '诗经选读'),
              TextbookLesson(id: 'l2', title: '离骚节选'),
              TextbookLesson(id: 'l3', title: '孔雀东南飞'),
              TextbookLesson(id: 'l4', title: '古诗十九首选读'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '魏晋风度', lessons: [
              TextbookLesson(id: 'l5', title: '兰亭集序'),
              TextbookLesson(id: 'l6', title: '归去来兮辞并序'),
              TextbookLesson(id: 'l7', title: '世说新语选读'),
              TextbookLesson(id: 'l8', title: '魏晋诗选读'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '盛唐气象', lessons: [
              TextbookLesson(id: 'l9', title: '李白诗选'),
              TextbookLesson(id: 'l10', title: '杜甫诗选'),
              TextbookLesson(id: 'l11', title: '王维诗选'),
              TextbookLesson(id: 'l12', title: '边塞诗选'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '古文运动', lessons: [
              TextbookLesson(id: 'l13', title: '师说'),
              TextbookLesson(id: 'l14', title: '进学解'),
              TextbookLesson(id: 'l15', title: '种树郭橐驼传'),
              TextbookLesson(id: 'l16', title: '永州八记选'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '宋词巅峰', lessons: [
              TextbookLesson(id: 'l17', title: '苏轼词选'),
              TextbookLesson(id: 'l18', title: '李清照词选'),
              TextbookLesson(id: 'l19', title: '辛弃疾词选'),
              TextbookLesson(id: 'l20', title: '柳永词选'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '戏曲小说', lessons: [
              TextbookLesson(id: 'l21', title: '西厢记节选'),
              TextbookLesson(id: 'l22', title: '牡丹亭节选'),
              TextbookLesson(id: 'l23', title: '水浒传选读'),
              TextbookLesson(id: 'l24', title: '三国演义选读'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '现当代散文', lessons: [
              TextbookLesson(id: 'l25', title: '鲁迅杂文选'),
              TextbookLesson(id: 'l26', title: '周作人散文选'),
              TextbookLesson(id: 'l27', title: '朱自清散文选'),
              TextbookLesson(id: 'l28', title: '沈从文散文选'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '外国文学', lessons: [
              TextbookLesson(id: 'l29', title: '堂吉诃德节选'),
              TextbookLesson(id: 'l30', title: '巴黎圣母院节选'),
              TextbookLesson(id: 'l31', title: '战争与和平节选'),
              TextbookLesson(id: 'l32', title: '追忆似水年华节选'),
            ]),
          ]),
        ]),
      ];
      break;
    }
  }

// ---------- 数学教材（人教版） ----------
List<TextbookVersion> _getMathTextbooks(Grade grade) {
  switch (grade) {
    case Grade.primary:
      return [
        TextbookVersion(id: '人教版', name: '人教版', semesters: [
          // 一年级上册
          TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '准备课', lessons: [
              TextbookLesson(id: 'l1', title: '数一数'),
              TextbookLesson(id: 'l2', title: '比多少'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '位置', lessons: [
              TextbookLesson(id: 'l3', title: '上、下、前、后'),
              TextbookLesson(id: 'l4', title: '左、右'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '1~5的认识和加减法', lessons: [
              TextbookLesson(id: 'l5', title: '1~5的认识和比大小'),
              TextbookLesson(id: 'l6', title: '第几、分与合'),
              TextbookLesson(id: 'l7', title: '1~5的加减法'),
              TextbookLesson(id: 'l8', title: '0的认识和加减法'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '认识图形（一）', lessons: [
              TextbookLesson(id: 'l9', title: '认识长方体、正方体、圆柱和球'),
              TextbookLesson(id: 'l10', title: '拼搭立体图形'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '6~10的认识和加减法', lessons: [
              TextbookLesson(id: 'l11', title: '6~10各数的认识'),
              TextbookLesson(id: 'l12', title: '6~10的加减法'),
              TextbookLesson(id: 'l13', title: '连加、连减和加减混合'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '11~20各数的认识', lessons: [
              TextbookLesson(id: 'l14', title: '11~20各数的读写和组成'),
              TextbookLesson(id: 'l15', title: '10加几和相应的减法'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '认识钟表', lessons: [
              TextbookLesson(id: 'l16', title: '认识整时'),
              TextbookLesson(id: 'l17', title: '用钟表表示时间'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '20以内的进位加法', lessons: [
              TextbookLesson(id: 'l18', title: '9加几'),
              TextbookLesson(id: 'l19', title: '8、7、6加几'),
              TextbookLesson(id: 'l20', title: '5、4、3、2加几'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l21', title: '数与计算复习'),
              TextbookLesson(id: 'l22', title: '图形与钟表复习'),
            ]),
          ]),
          // 一年级下册
          TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '认识图形（二）', lessons: [
              TextbookLesson(id: 'l1', title: '认识长方形、正方形、三角形和圆'),
              TextbookLesson(id: 'l2', title: '用七巧板拼图形'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '20以内的退位减法', lessons: [
              TextbookLesson(id: 'l3', title: '十几减9'),
              TextbookLesson(id: 'l4', title: '十几减8、7、6'),
              TextbookLesson(id: 'l5', title: '十几减5、4、3、2'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '分类与整理', lessons: [
              TextbookLesson(id: 'l6', title: '按指定标准分类'),
              TextbookLesson(id: 'l7', title: '自选标准分类并计数'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '100以内数的认识', lessons: [
              TextbookLesson(id: 'l8', title: '数数和数的组成'),
              TextbookLesson(id: 'l9', title: '数的顺序和比较大小'),
              TextbookLesson(id: 'l10', title: '整十数加一位数及相应的减法'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '认识人民币', lessons: [
              TextbookLesson(id: 'l11', title: '认识元、角、分'),
              TextbookLesson(id: 'l12', title: '人民币的简单计算'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '100以内的加法和减法（一）', lessons: [
              TextbookLesson(id: 'l13', title: '整十数加、减整十数'),
              TextbookLesson(id: 'l14', title: '两位数加一位数、整十数'),
              TextbookLesson(id: 'l15', title: '两位数减一位数、整十数'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '找规律', lessons: [
              TextbookLesson(id: 'l16', title: '图形和数字的排列规律'),
              TextbookLesson(id: 'l17', title: '简单数列的规律'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l18', title: '数与计算复习'),
              TextbookLesson(id: 'l19', title: '图形与分类复习'),
            ]),
          ]),
          // 二年级上册
          TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '长度单位', lessons: [
              TextbookLesson(id: 'l1', title: '认识厘米和米'),
              TextbookLesson(id: 'l2', title: '认识线段和测量'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '100以内的加法和减法（二）', lessons: [
              TextbookLesson(id: 'l3', title: '不进位加法和进位加法'),
              TextbookLesson(id: 'l4', title: '不退位减法和退位减法'),
              TextbookLesson(id: 'l5', title: '连加、连减和加减混合'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '角的初步认识', lessons: [
              TextbookLesson(id: 'l6', title: '认识角和直角'),
              TextbookLesson(id: 'l7', title: '锐角和钝角'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '表内乘法（一）', lessons: [
              TextbookLesson(id: 'l8', title: '乘法的初步认识'),
              TextbookLesson(id: 'l9', title: '2~6的乘法口诀'),
              TextbookLesson(id: 'l10', title: '用乘法解决问题'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '观察物体（一）', lessons: [
              TextbookLesson(id: 'l11', title: '从不同位置观察实物'),
              TextbookLesson(id: 'l12', title: '从不同位置观察立体图形'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '表内乘法（二）', lessons: [
              TextbookLesson(id: 'l13', title: '7~9的乘法口诀'),
              TextbookLesson(id: 'l14', title: '用乘法解决问题'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '量一量 比一比', lessons: [
              TextbookLesson(id: 'l15', title: '量一量、比一比'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '认识时间', lessons: [
              TextbookLesson(id: 'l16', title: '认识几时几分'),
              TextbookLesson(id: 'l17', title: '时间的简单计算'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '数学广角——搭配（一）', lessons: [
              TextbookLesson(id: 'l18', title: '简单的排列'),
              TextbookLesson(id: 'l19', title: '简单的组合'),
            ]),
          ]),
          // 二年级下册
          TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '数据收集整理', lessons: [
              TextbookLesson(id: 'l1', title: '数据收集整理'),
              TextbookLesson(id: 'l2', title: '用画"正"字的方法收集数据'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '表内除法（一）', lessons: [
              TextbookLesson(id: 'l3', title: '除法的初步认识'),
              TextbookLesson(id: 'l4', title: '用2~6的乘法口诀求商'),
              TextbookLesson(id: 'l5', title: '解决问题'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '图形的运动（一）', lessons: [
              TextbookLesson(id: 'l6', title: '轴对称图形'),
              TextbookLesson(id: 'l7', title: '平移和旋转'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '用2~6乘法口诀求商', lessons: [
              TextbookLesson(id: 'l8', title: '用口诀求商的练习'),
              TextbookLesson(id: 'l9', title: '解决问题'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '1000以内数的认识', lessons: [
              TextbookLesson(id: 'l10', title: '1000以内数的认识和读写'),
              TextbookLesson(id: 'l11', title: '数的组成和比较大小'),
              TextbookLesson(id: 'l12', title: '整百、整千数加减法'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '表内除法（二）', lessons: [
              TextbookLesson(id: 'l13', title: '用7、8、9的乘法口诀求商'),
              TextbookLesson(id: 'l14', title: '解决问题'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '混合运算', lessons: [
              TextbookLesson(id: 'l15', title: '同级运算的运算顺序'),
              TextbookLesson(id: 'l16', title: '含小括号的混合运算'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '万以内数的认识', lessons: [
              TextbookLesson(id: 'l17', title: '万以内数的认识和读写'),
              TextbookLesson(id: 'l18', title: '近似数和比较大小'),
              TextbookLesson(id: 'l19', title: '整百、整千数加减法'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '克和千克', lessons: [
              TextbookLesson(id: 'l20', title: '克的认识'),
              TextbookLesson(id: 'l21', title: '千克的认识和换算'),
            ]),
            TextbookUnit(id: 'u10', title: '第十单元', label: '数学广角——推理', lessons: [
              TextbookLesson(id: 'l22', title: '简单的逻辑推理'),
              TextbookLesson(id: 'l23', title: '数独基础推理'),
            ]),
          ]),
          // 三年级上册
          TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '时、分、秒', lessons: [
              TextbookLesson(id: 'l1', title: '秒的认识'),
              TextbookLesson(id: 'l2', title: '时间的简单计算'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '万以内的加法和减法（一）', lessons: [
              TextbookLesson(id: 'l3', title: '两位数加、减两位数'),
              TextbookLesson(id: 'l4', title: '几百几十加、减几百几十'),
              TextbookLesson(id: 'l5', title: '用估算解决问题'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '测量', lessons: [
              TextbookLesson(id: 'l6', title: '毫米和分米的认识'),
              TextbookLesson(id: 'l7', title: '千米的认识'),
              TextbookLesson(id: 'l8', title: '吨的认识'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '万以内的加法和减法（二）', lessons: [
              TextbookLesson(id: 'l9', title: '三位数加法'),
              TextbookLesson(id: 'l10', title: '三位数减法'),
              TextbookLesson(id: 'l11', title: '加、减法的验算'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '倍的认识', lessons: [
              TextbookLesson(id: 'l12', title: '倍的认识'),
              TextbookLesson(id: 'l13', title: '求一个数是另一个数的几倍'),
              TextbookLesson(id: 'l14', title: '求一个数的几倍是多少'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '多位数乘一位数', lessons: [
              TextbookLesson(id: 'l15', title: '口算乘法'),
              TextbookLesson(id: 'l16', title: '笔算乘法（不进位和进位）'),
              TextbookLesson(id: 'l17', title: '因数中有0的乘法和估算'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '数字编码', lessons: [
              TextbookLesson(id: 'l18', title: '数字编码'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '长方形和正方形', lessons: [
              TextbookLesson(id: 'l19', title: '四边形的认识'),
              TextbookLesson(id: 'l20', title: '周长的认识'),
              TextbookLesson(id: 'l21', title: '长方形和正方形的周长计算'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '分数的初步认识', lessons: [
              TextbookLesson(id: 'l22', title: '几分之一的认识'),
              TextbookLesson(id: 'l23', title: '几分之几的认识'),
              TextbookLesson(id: 'l24', title: '分数的简单计算和应用'),
            ]),
            TextbookUnit(id: 'u10', title: '第十单元', label: '数学广角——集合', lessons: [
              TextbookLesson(id: 'l25', title: '集合的认识'),
              TextbookLesson(id: 'l26', title: '用集合思想解决问题'),
            ]),
          ]),
          // 三年级下册
          TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '位置与方向（一）', lessons: [
              TextbookLesson(id: 'l1', title: '认识东、南、西、北'),
              TextbookLesson(id: 'l2', title: '认识东北、东南、西北、西南'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '除数是一位数的除法', lessons: [
              TextbookLesson(id: 'l3', title: '口算除法'),
              TextbookLesson(id: 'l4', title: '笔算除法（两位数、三位数除以一位数）'),
              TextbookLesson(id: 'l5', title: '有关0的除法和解决问题'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '复式统计表', lessons: [
              TextbookLesson(id: 'l6', title: '认识复式统计表'),
              TextbookLesson(id: 'l7', title: '根据统计表分析和解决问题'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '两位数乘两位数', lessons: [
              TextbookLesson(id: 'l8', title: '口算乘法'),
              TextbookLesson(id: 'l9', title: '笔算乘法（不进位和进位）'),
              TextbookLesson(id: 'l10', title: '解决问题'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '面积', lessons: [
              TextbookLesson(id: 'l11', title: '面积和面积单位'),
              TextbookLesson(id: 'l12', title: '长方形、正方形的面积计算'),
              TextbookLesson(id: 'l13', title: '面积单位间的进率'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '年、月、日', lessons: [
              TextbookLesson(id: 'l14', title: '年、月、日的认识'),
              TextbookLesson(id: 'l15', title: '24时计时法'),
              TextbookLesson(id: 'l16', title: '制作活动日历'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '小数的初步认识', lessons: [
              TextbookLesson(id: 'l17', title: '小数的认识'),
              TextbookLesson(id: 'l18', title: '简单的小数加、减法'),
              TextbookLesson(id: 'l19', title: '用小数解决实际问题'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '数学广角——搭配（二）', lessons: [
              TextbookLesson(id: 'l20', title: '简单的排列问题'),
              TextbookLesson(id: 'l21', title: '简单的组合问题'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l22', title: '数与计算复习'),
              TextbookLesson(id: 'l23', title: '图形与统计复习'),
            ]),
          ]),
          // 四年级上册
          TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '大数的认识', lessons: [
              TextbookLesson(id: 'l1', title: '亿以内数的认识和读写'),
              TextbookLesson(id: 'l2', title: '亿以内数的大小比较和改写'),
              TextbookLesson(id: 'l3', title: '亿以上数的认识和计算工具'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '公顷和平方千米', lessons: [
              TextbookLesson(id: 'l4', title: '公顷的认识'),
              TextbookLesson(id: 'l5', title: '平方千米的认识和换算'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '角的度量', lessons: [
              TextbookLesson(id: 'l6', title: '线段、直线、射线和角'),
              TextbookLesson(id: 'l7', title: '角的度量'),
              TextbookLesson(id: 'l8', title: '角的分类和画角'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '三位数乘两位数', lessons: [
              TextbookLesson(id: 'l9', title: '笔算乘法'),
              TextbookLesson(id: 'l10', title: '积的变化规律'),
              TextbookLesson(id: 'l11', title: '常见的数量关系'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '平行四边形和梯形', lessons: [
              TextbookLesson(id: 'l12', title: '平行与垂直'),
              TextbookLesson(id: 'l13', title: '平行四边形和梯形的认识'),
              TextbookLesson(id: 'l14', title: '画垂线和作高'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '除数是两位数的除法', lessons: [
              TextbookLesson(id: 'l15', title: '口算除法'),
              TextbookLesson(id: 'l16', title: '笔算除法（试商和调商）'),
              TextbookLesson(id: 'l17', title: '商的变化规律'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '条形统计图', lessons: [
              TextbookLesson(id: 'l18', title: '条形统计图的认识'),
              TextbookLesson(id: 'l19', title: '用条形统计图分析和解决问题'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '数学广角——优化', lessons: [
              TextbookLesson(id: 'l20', title: '沏茶问题'),
              TextbookLesson(id: 'l21', title: '烙饼问题和田忌赛马'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l22', title: '数与计算复习'),
              TextbookLesson(id: 'l23', title: '图形与统计复习'),
            ]),
          ]),
          // 四年级下册
          TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '四则运算', lessons: [
              TextbookLesson(id: 'l1', title: '加、减法的意义和各部分间的关系'),
              TextbookLesson(id: 'l2', title: '乘、除法的意义和各部分间的关系'),
              TextbookLesson(id: 'l3', title: '括号和0的运算'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '观察物体（二）', lessons: [
              TextbookLesson(id: 'l4', title: '从不同位置观察立体图形'),
              TextbookLesson(id: 'l5', title: '从同一位置观察不同立体图形'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '运算定律', lessons: [
              TextbookLesson(id: 'l6', title: '加法运算定律'),
              TextbookLesson(id: 'l7', title: '乘法运算定律'),
              TextbookLesson(id: 'l8', title: '简便计算'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '小数的意义和性质', lessons: [
              TextbookLesson(id: 'l9', title: '小数的意义和读写法'),
              TextbookLesson(id: 'l10', title: '小数的性质和大小比较'),
              TextbookLesson(id: 'l11', title: '小数点移动引起小数大小的变化'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '三角形', lessons: [
              TextbookLesson(id: 'l12', title: '三角形的认识'),
              TextbookLesson(id: 'l13', title: '三角形的分类'),
              TextbookLesson(id: 'l14', title: '三角形的内角和'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '小数的加法和减法', lessons: [
              TextbookLesson(id: 'l15', title: '小数加、减法'),
              TextbookLesson(id: 'l16', title: '小数加减混合运算'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '图形的运动（二）', lessons: [
              TextbookLesson(id: 'l17', title: '轴对称'),
              TextbookLesson(id: 'l18', title: '平移'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '平均数与条形统计图', lessons: [
              TextbookLesson(id: 'l19', title: '平均数的认识'),
              TextbookLesson(id: 'l20', title: '复式条形统计图'),
              TextbookLesson(id: 'l21', title: '营养午餐'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '数学广角——鸡兔同笼', lessons: [
              TextbookLesson(id: 'l22', title: '鸡兔同笼问题'),
              TextbookLesson(id: 'l23', title: '用假设法解题'),
            ]),
            TextbookUnit(id: 'u10', title: '第十单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l24', title: '数与计算复习'),
              TextbookLesson(id: 'l25', title: '图形与统计复习'),
            ]),
          ]),
          // 五年级上册
          TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '小数乘法', lessons: [
              TextbookLesson(id: 'l1', title: '小数乘整数'),
              TextbookLesson(id: 'l2', title: '小数乘小数'),
              TextbookLesson(id: 'l3', title: '整数乘法运算定律推广到小数'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '位置', lessons: [
              TextbookLesson(id: 'l4', title: '用数对表示位置'),
              TextbookLesson(id: 'l5', title: '用数对解决实际问题'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '小数除法', lessons: [
              TextbookLesson(id: 'l6', title: '小数除以整数'),
              TextbookLesson(id: 'l7', title: '一个数除以小数'),
              TextbookLesson(id: 'l8', title: '循环小数和商的近似数'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '可能性', lessons: [
              TextbookLesson(id: 'l9', title: '可能性'),
              TextbookLesson(id: 'l10', title: '可能性的大小和公平性'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '简易方程', lessons: [
              TextbookLesson(id: 'l11', title: '用字母表示数'),
              TextbookLesson(id: 'l12', title: '方程的意义和解方程'),
              TextbookLesson(id: 'l13', title: '实际问题与方程'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '多边形的面积', lessons: [
              TextbookLesson(id: 'l14', title: '平行四边形的面积'),
              TextbookLesson(id: 'l15', title: '三角形的面积'),
              TextbookLesson(id: 'l16', title: '梯形的面积和组合图形的面积'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '数学广角——植树问题', lessons: [
              TextbookLesson(id: 'l17', title: '两端都栽的植树问题'),
              TextbookLesson(id: 'l18', title: '两端都不栽和环形植树问题'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l19', title: '数与代数复习'),
              TextbookLesson(id: 'l20', title: '图形与统计复习'),
            ]),
          ]),
          // 五年级下册
          TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '观察物体（三）', lessons: [
              TextbookLesson(id: 'l1', title: '根据平面图拼搭立体图形'),
              TextbookLesson(id: 'l2', title: '从不同方向观察组合体'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '因数和倍数', lessons: [
              TextbookLesson(id: 'l3', title: '因数和倍数的认识'),
              TextbookLesson(id: 'l4', title: '2、5、3的倍数特征'),
              TextbookLesson(id: 'l5', title: '质数和合数'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '长方体和正方体', lessons: [
              TextbookLesson(id: 'l6', title: '长方体和正方体的认识'),
              TextbookLesson(id: 'l7', title: '长方体和正方体的表面积'),
              TextbookLesson(id: 'l8', title: '长方体和正方体的体积'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '分数的意义和性质', lessons: [
              TextbookLesson(id: 'l9', title: '分数的意义'),
              TextbookLesson(id: 'l10', title: '真分数和假分数'),
              TextbookLesson(id: 'l11', title: '分数的基本性质、约分和通分'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '图形的运动（三）', lessons: [
              TextbookLesson(id: 'l12', title: '旋转'),
              TextbookLesson(id: 'l13', title: '利用平移和旋转设计图案'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '分数的加法和减法', lessons: [
              TextbookLesson(id: 'l14', title: '同分母分数加减法'),
              TextbookLesson(id: 'l15', title: '异分母分数加减法'),
              TextbookLesson(id: 'l16', title: '分数加减混合运算'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '折线统计图', lessons: [
              TextbookLesson(id: 'l17', title: '单式折线统计图'),
              TextbookLesson(id: 'l18', title: '复式折线统计图的绘制和分析'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '数学广角——找次品', lessons: [
              TextbookLesson(id: 'l19', title: '从3个物品中找次品'),
              TextbookLesson(id: 'l20', title: '从多个物品中找次品'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l21', title: '数与计算复习'),
              TextbookLesson(id: 'l22', title: '图形与统计复习'),
            ]),
          ]),
          // 六年级上册
          TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '分数乘法', lessons: [
              TextbookLesson(id: 'l1', title: '分数乘整数'),
              TextbookLesson(id: 'l2', title: '分数乘分数'),
              TextbookLesson(id: 'l3', title: '分数乘法应用题'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '位置与方向（二）', lessons: [
              TextbookLesson(id: 'l4', title: '用方向和距离确定位置'),
              TextbookLesson(id: 'l5', title: '描述和绘制路线图'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '分数除法', lessons: [
              TextbookLesson(id: 'l6', title: '倒数的认识'),
              TextbookLesson(id: 'l7', title: '分数除法'),
              TextbookLesson(id: 'l8', title: '分数除法应用题'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '比', lessons: [
              TextbookLesson(id: 'l9', title: '比的意义和基本性质'),
              TextbookLesson(id: 'l10', title: '按比分配解决问题'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '圆', lessons: [
              TextbookLesson(id: 'l11', title: '圆的认识'),
              TextbookLesson(id: 'l12', title: '圆的周长'),
              TextbookLesson(id: 'l13', title: '圆的面积和扇形'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '百分数（一）', lessons: [
              TextbookLesson(id: 'l14', title: '百分数的意义和读写'),
              TextbookLesson(id: 'l15', title: '百分数和分数、小数的互化'),
              TextbookLesson(id: 'l16', title: '用百分数解决问题'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '扇形统计图', lessons: [
              TextbookLesson(id: 'l17', title: '扇形统计图的认识'),
              TextbookLesson(id: 'l18', title: '选择合适的统计图'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '数学广角——数与形', lessons: [
              TextbookLesson(id: 'l19', title: '数与形的关系'),
              TextbookLesson(id: 'l20', title: '用数形结合解决问题'),
            ]),
            TextbookUnit(id: 'u9', title: '第九单元', label: '总复习', lessons: [
              TextbookLesson(id: 'l21', title: '数与计算复习'),
              TextbookLesson(id: 'l22', title: '图形与统计复习'),
            ]),
          ]),
          // 六年级下册
          TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第一单元', label: '负数', lessons: [
              TextbookLesson(id: 'l1', title: '负数的认识'),
              TextbookLesson(id: 'l2', title: '在直线上表示正数和负数'),
            ]),
            TextbookUnit(id: 'u2', title: '第二单元', label: '百分数（二）', lessons: [
              TextbookLesson(id: 'l3', title: '折扣和成数'),
              TextbookLesson(id: 'l4', title: '税率和利率'),
              TextbookLesson(id: 'l5', title: '用百分数解决生活问题'),
            ]),
            TextbookUnit(id: 'u3', title: '第三单元', label: '圆柱与圆锥', lessons: [
              TextbookLesson(id: 'l6', title: '圆柱的认识和表面积'),
              TextbookLesson(id: 'l7', title: '圆柱的体积'),
              TextbookLesson(id: 'l8', title: '圆锥的认识和体积'),
            ]),
            TextbookUnit(id: 'u4', title: '第四单元', label: '比例', lessons: [
              TextbookLesson(id: 'l9', title: '比例的意义和基本性质'),
              TextbookLesson(id: 'l10', title: '正比例和反比例'),
              TextbookLesson(id: 'l11', title: '比例尺和图形的放大缩小'),
            ]),
            TextbookUnit(id: 'u5', title: '第五单元', label: '数学广角——鸽巢问题', lessons: [
              TextbookLesson(id: 'l12', title: '鸽巢原理（一）'),
              TextbookLesson(id: 'l13', title: '鸽巢原理（二）'),
            ]),
            TextbookUnit(id: 'u6', title: '第六单元', label: '整理和复习', lessons: [
              TextbookLesson(id: 'l14', title: '数的认识与运算复习'),
              TextbookLesson(id: 'l15', title: '图形与几何复习'),
            ]),
            TextbookUnit(id: 'u7', title: '第七单元', label: '小升初总复习——数与代数', lessons: [
              TextbookLesson(id: 'l16', title: '整数、小数、分数复习'),
              TextbookLesson(id: 'l17', title: '式与方程复习'),
            ]),
            TextbookUnit(id: 'u8', title: '第八单元', label: '小升初总复习——统计与综合', lessons: [
              TextbookLesson(id: 'l18', title: '统计与概率复习'),
              TextbookLesson(id: 'l19', title: '数学思考与方法复习'),
            ]),
          ]),
        ]),
      ];

    case Grade.junior:
      return [
        TextbookVersion(id: '人教版', name: '人教版', semesters: [
          // 七年级上册
          TextbookSemester(id: '初一上', name: '七年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一章', label: '有理数', lessons: [
              TextbookLesson(id: 'l1', title: '正数和负数'),
              TextbookLesson(id: 'l2', title: '有理数'),
              TextbookLesson(id: 'l3', title: '有理数的加减法'),
              TextbookLesson(id: 'l4', title: '有理数的乘除法'),
              TextbookLesson(id: 'l5', title: '有理数的乘方'),
            ]),
            TextbookUnit(id: 'u2', title: '第二章', label: '整式的加减', lessons: [
              TextbookLesson(id: 'l6', title: '整式'),
              TextbookLesson(id: 'l7', title: '整式的加减'),
            ]),
            TextbookUnit(id: 'u3', title: '第三章', label: '一元一次方程', lessons: [
              TextbookLesson(id: 'l8', title: '从算式到方程'),
              TextbookLesson(id: 'l9', title: '解一元一次方程（一）'),
              TextbookLesson(id: 'l10', title: '实际问题与一元一次方程'),
            ]),
            TextbookUnit(id: 'u4', title: '第四章', label: '几何图形初步', lessons: [
              TextbookLesson(id: 'l11', title: '几何图形'),
              TextbookLesson(id: 'l12', title: '直线、射线、线段'),
              TextbookLesson(id: 'l13', title: '角'),
            ]),
          ]),
          // 七年级下册
          TextbookSemester(id: '初一下', name: '七年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第五章', label: '相交线与平行线', lessons: [
              TextbookLesson(id: 'l1', title: '相交线'),
              TextbookLesson(id: 'l2', title: '平行线及其判定'),
              TextbookLesson(id: 'l3', title: '平行线的性质'),
              TextbookLesson(id: 'l4', title: '平移'),
            ]),
            TextbookUnit(id: 'u2', title: '第六章', label: '实数', lessons: [
              TextbookLesson(id: 'l5', title: '平方根'),
              TextbookLesson(id: 'l6', title: '立方根'),
              TextbookLesson(id: 'l7', title: '实数'),
            ]),
            TextbookUnit(id: 'u3', title: '第七章', label: '平面直角坐标系', lessons: [
              TextbookLesson(id: 'l8', title: '有序数对'),
              TextbookLesson(id: 'l9', title: '平面直角坐标系'),
            ]),
            TextbookUnit(id: 'u4', title: '第八章', label: '二元一次方程组', lessons: [
              TextbookLesson(id: 'l10', title: '二元一次方程组'),
              TextbookLesson(id: 'l11', title: '消元——解二元一次方程组'),
              TextbookLesson(id: 'l12', title: '实际问题与二元一次方程组'),
            ]),
          ]),
          // 八年级上册
          TextbookSemester(id: '初二上', name: '八年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第十一章', label: '三角形', lessons: [
              TextbookLesson(id: 'l1', title: '与三角形有关的线段'),
              TextbookLesson(id: 'l2', title: '与三角形有关的角'),
              TextbookLesson(id: 'l3', title: '多边形及其内角和'),
            ]),
            TextbookUnit(id: 'u2', title: '第十二章', label: '全等三角形', lessons: [
              TextbookLesson(id: 'l4', title: '全等三角形'),
              TextbookLesson(id: 'l5', title: '三角形全等的判定'),
              TextbookLesson(id: 'l6', title: '角的平分线的性质'),
            ]),
            TextbookUnit(id: 'u3', title: '第十三章', label: '轴对称', lessons: [
              TextbookLesson(id: 'l7', title: '轴对称'),
              TextbookLesson(id: 'l8', title: '画轴对称图形'),
              TextbookLesson(id: 'l9', title: '等腰三角形'),
            ]),
            TextbookUnit(id: 'u4', title: '第十四章', label: '整式的乘法与因式分解', lessons: [
              TextbookLesson(id: 'l10', title: '整式的乘法'),
              TextbookLesson(id: 'l11', title: '乘法公式'),
              TextbookLesson(id: 'l12', title: '因式分解'),
            ]),
            TextbookUnit(id: 'u5', title: '第十五章', label: '分式', lessons: [
              TextbookLesson(id: 'l13', title: '分式'),
              TextbookLesson(id: 'l14', title: '分式的运算'),
              TextbookLesson(id: 'l15', title: '分式方程'),
            ]),
          ]),
          // 八年级下册
          TextbookSemester(id: '初二下', name: '八年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第十六章', label: '二次根式', lessons: [
              TextbookLesson(id: 'l1', title: '二次根式'),
              TextbookLesson(id: 'l2', title: '二次根式的乘除'),
              TextbookLesson(id: 'l3', title: '二次根式的加减'),
            ]),
            TextbookUnit(id: 'u2', title: '第十七章', label: '勾股定理', lessons: [
              TextbookLesson(id: 'l4', title: '勾股定理'),
              TextbookLesson(id: 'l5', title: '勾股定理的逆定理'),
            ]),
            TextbookUnit(id: 'u3', title: '第十八章', label: '平行四边形', lessons: [
              TextbookLesson(id: 'l6', title: '平行四边形的判定'),
              TextbookLesson(id: 'l7', title: '矩形、菱形、正方形'),
            ]),
            TextbookUnit(id: 'u4', title: '第十九章', label: '一次函数', lessons: [
              TextbookLesson(id: 'l8', title: '函数'),
              TextbookLesson(id: 'l9', title: '一次函数'),
              TextbookLesson(id: 'l10', title: '课题学习：选择方案'),
            ]),
            TextbookUnit(id: 'u5', title: '第二十章', label: '数据的分析', lessons: [
              TextbookLesson(id: 'l11', title: '数据的集中趋势（平均数、中位数、众数）'),
              TextbookLesson(id: 'l12', title: '数据的波动程度（方差）'),
            ]),
          ]),
          // 九年级上册
          TextbookSemester(id: '初三上', name: '九年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第二十一章', label: '一元二次方程', lessons: [
              TextbookLesson(id: 'l1', title: '一元二次方程'),
              TextbookLesson(id: 'l2', title: '解一元二次方程'),
              TextbookLesson(id: 'l3', title: '实际问题与一元二次方程'),
            ]),
            TextbookUnit(id: 'u2', title: '第二十二章', label: '二次函数', lessons: [
              TextbookLesson(id: 'l4', title: '二次函数的图像和性质'),
              TextbookLesson(id: 'l5', title: '二次函数与一元二次方程'),
              TextbookLesson(id: 'l6', title: '实际问题与二次函数'),
            ]),
            TextbookUnit(id: 'u3', title: '第二十三章', label: '旋转', lessons: [
              TextbookLesson(id: 'l7', title: '图形的旋转'),
              TextbookLesson(id: 'l8', title: '中心对称'),
            ]),
            TextbookUnit(id: 'u4', title: '第二十四章', label: '圆', lessons: [
              TextbookLesson(id: 'l9', title: '圆的有关性质'),
              TextbookLesson(id: 'l10', title: '点和圆、直线和圆的位置关系'),
              TextbookLesson(id: 'l11', title: '正多边形和圆'),
              TextbookLesson(id: 'l12', title: '弧长和扇形面积'),
            ]),
            TextbookUnit(id: 'u5', title: '第二十五章', label: '概率初步', lessons: [
              TextbookLesson(id: 'l13', title: '随机事件与概率'),
              TextbookLesson(id: 'l14', title: '用列举法求概率'),
              TextbookLesson(id: 'l15', title: '用频率估计概率'),
            ]),
          ]),
          // 九年级下册
          TextbookSemester(id: '初三下', name: '九年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第二十六章', label: '反比例函数', lessons: [
              TextbookLesson(id: 'l1', title: '反比例函数'),
              TextbookLesson(id: 'l2', title: '实际问题与反比例函数'),
            ]),
            TextbookUnit(id: 'u2', title: '第二十七章', label: '相似', lessons: [
              TextbookLesson(id: 'l3', title: '图形的相似'),
              TextbookLesson(id: 'l4', title: '相似三角形'),
              TextbookLesson(id: 'l5', title: '位似'),
            ]),
            TextbookUnit(id: 'u3', title: '第二十八章', label: '锐角三角函数', lessons: [
              TextbookLesson(id: 'l6', title: '锐角三角函数'),
              TextbookLesson(id: 'l7', title: '解直角三角形及其应用'),
            ]),
            TextbookUnit(id: 'u4', title: '第二十九章', label: '投影与视图', lessons: [
              TextbookLesson(id: 'l8', title: '投影'),
              TextbookLesson(id: 'l9', title: '三视图'),
              TextbookLesson(id: 'l10', title: '课题学习：制作立体模型'),
            ]),
          ]),
        ]),
      ];

    case Grade.senior:
      return [
        TextbookVersion(id: '人教版A版', name: '人教版A版', semesters: [
          TextbookSemester(id: '必修一', name: '必修第一册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: '第一章', label: '集合与常用逻辑用语', lessons: [
              TextbookLesson(id: 'l1', title: '集合的概念'),
              TextbookLesson(id: 'l2', title: '集合间的基本关系'),
              TextbookLesson(id: 'l3', title: '集合的基本运算'),
              TextbookLesson(id: 'l4', title: '充分条件与必要条件'),
              TextbookLesson(id: 'l5', title: '全称量词与存在量词'),
            ]),
            TextbookUnit(id: 'u2', title: '第二章', label: '一元二次函数、方程和不等式', lessons: [
              TextbookLesson(id: 'l6', title: '等式性质与不等式性质'),
              TextbookLesson(id: 'l7', title: '基本不等式'),
              TextbookLesson(id: 'l8', title: '二次函数与一元二次方程、不等式'),
            ]),
            TextbookUnit(id: 'u3', title: '第三章', label: '函数的概念与性质', lessons: [
              TextbookLesson(id: 'l9', title: '函数的概念及其表示'),
              TextbookLesson(id: 'l10', title: '函数的基本性质'),
              TextbookLesson(id: 'l11', title: '幂函数'),
            ]),
            TextbookUnit(id: 'u4', title: '第四章', label: '指数函数与对数函数', lessons: [
              TextbookLesson(id: 'l12', title: '指数'),
              TextbookLesson(id: 'l13', title: '指数函数'),
              TextbookLesson(id: 'l14', title: '对数'),
              TextbookLesson(id: 'l15', title: '对数函数'),
            ]),
            TextbookUnit(id: 'u5', title: '第五章', label: '三角函数', lessons: [
              TextbookLesson(id: 'l16', title: '任意角和弧度制'),
              TextbookLesson(id: 'l17', title: '三角函数的概念'),
              TextbookLesson(id: 'l18', title: '三角恒等变换'),
            ]),
          ]),
          TextbookSemester(id: '必修二', name: '必修第二册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: '第六章', label: '平面向量及其应用', lessons: [
              TextbookLesson(id: 'l1', title: '平面向量的概念'),
              TextbookLesson(id: 'l2', title: '平面向量的运算'),
              TextbookLesson(id: 'l3', title: '平面向量基本定理及坐标表示'),
              TextbookLesson(id: 'l4', title: '余弦定理、正弦定理'),
            ]),
            TextbookUnit(id: 'u2', title: '第七章', label: '复数', lessons: [
              TextbookLesson(id: 'l5', title: '复数的概念'),
              TextbookLesson(id: 'l6', title: '复数的四则运算'),
            ]),
            TextbookUnit(id: 'u3', title: '第八章', label: '立体几何初步', lessons: [
              TextbookLesson(id: 'l7', title: '基本立体图形'),
              TextbookLesson(id: 'l8', title: '空间点、直线、平面之间的位置关系'),
            ]),
            TextbookUnit(id: 'u4', title: '第九章', label: '统计', lessons: [
              TextbookLesson(id: 'l9', title: '随机抽样'),
              TextbookLesson(id: 'l10', title: '用样本估计总体'),
            ]),
            TextbookUnit(id: 'u5', title: '第十章', label: '概率', lessons: [
              TextbookLesson(id: 'l11', title: '随机事件与概率'),
              TextbookLesson(id: 'l12', title: '事件的相互独立性'),
              TextbookLesson(id: 'l13', title: '频率与概率'),
            ]),
          ]),
          // 选择性必修第一册 (第一~三章: 空间向量 + 直线圆 + 圆锥曲线)
          TextbookSemester(id: '选必一', name: '选择性必修第一册', label: '第一册', units: [
            TextbookUnit(id: 'u1', title: '第一章', label: '空间向量与立体几何', lessons: [
              TextbookLesson(id: 'l1', title: '空间向量及其运算'),
              TextbookLesson(id: 'l2', title: '空间向量基本定理'),
              TextbookLesson(id: 'l3', title: '空间向量的坐标表示'),
              TextbookLesson(id: 'l4', title: '用空间向量研究距离、夹角问题'),
            ]),
            TextbookUnit(id: 'u2', title: '第二章', label: '直线和圆的方程', lessons: [
              TextbookLesson(id: 'l5', title: '直线的倾斜角与斜率'),
              TextbookLesson(id: 'l6', title: '直线的方程'),
              TextbookLesson(id: 'l7', title: '直线的交点坐标与距离公式'),
              TextbookLesson(id: 'l8', title: '圆的方程'),
              TextbookLesson(id: 'l9', title: '直线与圆、圆与圆的位置关系'),
            ]),
            TextbookUnit(id: 'u3', title: '第三章', label: '圆锥曲线的方程', lessons: [
              TextbookLesson(id: 'l10', title: '椭圆'),
              TextbookLesson(id: 'l11', title: '双曲线'),
              TextbookLesson(id: 'l12', title: '抛物线'),
            ]),
          ]),
          // 选择性必修第二册 (第四章 数列 + 第五章 导数)
          TextbookSemester(id: '选必二', name: '选择性必修第二册', label: '第二册', units: [
            TextbookUnit(id: 'u1', title: '第四章', label: '数列', lessons: [
              TextbookLesson(id: 'l1', title: '数列的概念'),
              TextbookLesson(id: 'l2', title: '等差数列'),
              TextbookLesson(id: 'l3', title: '等差数列的前n项和'),
              TextbookLesson(id: 'l4', title: '等比数列'),
              TextbookLesson(id: 'l5', title: '等比数列的前n项和'),
              TextbookLesson(id: 'l6', title: '数学归纳法'),
            ]),
            TextbookUnit(id: 'u2', title: '第五章', label: '一元函数的导数及其应用', lessons: [
              TextbookLesson(id: 'l7', title: '导数的概念及其意义'),
              TextbookLesson(id: 'l8', title: '导数的运算'),
              TextbookLesson(id: 'l9', title: '函数的单调性'),
              TextbookLesson(id: 'l10', title: '函数的极值与最值'),
              TextbookLesson(id: 'l11', title: '导数在函数研究中的综合应用'),
            ]),
          ]),
          // 选择性必修第三册 (第六~八章: 计数原理 + 随机变量 + 统计分析)
          TextbookSemester(id: '选必三', name: '选择性必修第三册', label: '第三册', units: [
            TextbookUnit(id: 'u1', title: '第六章', label: '计数原理', lessons: [
              TextbookLesson(id: 'l1', title: '分类加法计数原理与分步乘法计数原理'),
              TextbookLesson(id: 'l2', title: '排列'),
              TextbookLesson(id: 'l3', title: '组合'),
              TextbookLesson(id: 'l4', title: '二项式定理'),
            ]),
            TextbookUnit(id: 'u2', title: '第七章', label: '随机变量及其分布', lessons: [
              TextbookLesson(id: 'l5', title: '条件概率与全概率公式'),
              TextbookLesson(id: 'l6', title: '离散型随机变量及其分布列'),
              TextbookLesson(id: 'l7', title: '离散型随机变量的数字特征'),
              TextbookLesson(id: 'l8', title: '二项分布与超几何分布'),
              TextbookLesson(id: 'l9', title: '正态分布'),
            ]),
            TextbookUnit(id: 'u3', title: '第八章', label: '成对数据的统计分析', lessons: [
              TextbookLesson(id: 'l10', title: '成对数据的统计相关性'),
              TextbookLesson(id: 'l11', title: '一元线性回归模型及其应用'),
              TextbookLesson(id: 'l12', title: '列联表与独立性检验'),
            ]),
          ]),
        ]),
      ];
  }
}

// ---------- 英语教材（PEP版/人教版） ----------
List<TextbookVersion> _getEnglishTextbooks(Grade grade) {
  switch (grade) {
    case Grade.primary:
      return [
        TextbookVersion(id: 'PEP', name: 'PEP版（三年级起点）', semesters: [
          // 三年级上册
          TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Hello!', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Colours', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Look at me!', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'We love animals', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: "Let's eat!", lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'Happy birthday!', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 三年级下册
          TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Welcome back to school!', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'My family', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'At the zoo', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Where is my car?', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Do you like pears?', lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'How many?', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 四年级上册
          TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'My classroom', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'My schoolbag', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'My friends', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'My home', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: "Dinner's ready", lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'Meet my family!', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 四年级下册
          TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'My school', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'What time is it?', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Weather', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'At the farm', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'My clothes', lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'Shopping', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 五年级上册
          TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: "What's he like?", lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'My week', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'What would you like?', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'What can you do?', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'There is a big bed', lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'In a nature park', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 五年级下册
          TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'My day', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'My favourite season', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'My school calendar', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'When is the art show?', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Whose dog is it?', lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'Work quietly!', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 六年级上册
          TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'How can I get there?', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Ways to go to school', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'My weekend plan', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'I have a pen pal', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'What does he do?', lessons: [
              TextbookLesson(id: 'l13', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l14', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l15', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'How do you feel?', lessons: [
              TextbookLesson(id: 'l16', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l17', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l18', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u7', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l19', title: '复习与练习'),
              TextbookLesson(id: 'l20', title: 'Story time'),
            ]),
          ]),
          // 六年级下册
          TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'How tall are you?', lessons: [
              TextbookLesson(id: 'l1', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l2', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l3', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Last weekend', lessons: [
              TextbookLesson(id: 'l4', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l5', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l6', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Where did you go?', lessons: [
              TextbookLesson(id: 'l7', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l8', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l9', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Then and now', lessons: [
              TextbookLesson(id: 'l10', title: "A Let's talk & Let's learn"),
              TextbookLesson(id: 'l11', title: "B Let's learn & Read and write"),
              TextbookLesson(id: 'l12', title: 'C Story time'),
            ]),
            TextbookUnit(id: 'u5', title: 'Recycle 1', label: 'Recycle 1', lessons: [
              TextbookLesson(id: 'l13', title: '复习与练习'),
              TextbookLesson(id: 'l14', title: 'Story time'),
            ]),
          ]),
        ]),
      ];
      break;

    case Grade.junior:
      return [
        TextbookVersion(id: '人教版', name: '人教版 (Go for It!)', semesters: [
          // ===== 七年级上册 2024新版 (Starter 1~3 + Unit 1~7) =====
          TextbookSemester(id: '初一上', name: '七年级上册', label: '上册', units: [
            TextbookUnit(id: 'su1', title: 'Starter 1', label: 'Hello!', lessons: [
              TextbookLesson(id: 'l1', title: 'Greeting people and introducing yourself'),
              TextbookLesson(id: 'l2', title: 'ABCD letters and phonics'),
              TextbookLesson(id: 'l3', title: 'Project: Make your own name card'),
            ]),
            TextbookUnit(id: 'su2', title: 'Starter 2', label: 'Keep Tidy!', lessons: [
              TextbookLesson(id: 'l4', title: 'What do you have?'),
              TextbookLesson(id: 'l5', title: 'Where do you put your things?'),
              TextbookLesson(id: 'l6', title: 'Project: Guess what it is'),
            ]),
            TextbookUnit(id: 'su3', title: 'Starter 3', label: 'Welcome!', lessons: [
              TextbookLesson(id: 'l7', title: 'What is fun on a farm?'),
              TextbookLesson(id: 'l8', title: 'What is fun in a yard?'),
              TextbookLesson(id: 'l9', title: 'Project: Describe your own yard'),
            ]),
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'You and Me', lessons: [
              TextbookLesson(id: 'l10', title: 'How do we make new friends?'),
              TextbookLesson(id: 'l11', title: 'Grammar: Simple present tense (be)'),
              TextbookLesson(id: 'l12', title: 'Writing: A personal profile'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: "We're Family!", lessons: [
              TextbookLesson(id: 'l13', title: 'What does family mean to you?'),
              TextbookLesson(id: 'l14', title: 'Grammar: Possessive pronouns'),
              TextbookLesson(id: 'l15', title: 'Writing: Describe your family'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'My School', lessons: [
              TextbookLesson(id: 'l16', title: 'What is your school like?'),
              TextbookLesson(id: 'l17', title: 'Grammar: There be structure'),
              TextbookLesson(id: 'l18', title: 'Writing: An email about your school'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'My Favourite Subject', lessons: [
              TextbookLesson(id: 'l19', title: 'Why do you like this subject?'),
              TextbookLesson(id: 'l20', title: 'Grammar: Conjunctions (and/but/because)'),
              TextbookLesson(id: 'l21', title: 'Writing: A post about your favourite subject'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Fun Clubs', lessons: [
              TextbookLesson(id: 'l22', title: 'What club do you want to join?'),
              TextbookLesson(id: 'l23', title: 'Grammar: Can for ability'),
              TextbookLesson(id: 'l24', title: 'Writing: An ad for a school club'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'A Day in the Life', lessons: [
              TextbookLesson(id: 'l25', title: 'How do you spend your school day?'),
              TextbookLesson(id: 'l26', title: 'Grammar: Simple present tense & time prepositions'),
              TextbookLesson(id: 'l27', title: 'Writing: A daily routine'),
            ]),
            TextbookUnit(id: 'u7', title: 'Unit 7', label: 'Happy Birthday!', lessons: [
              TextbookLesson(id: 'l28', title: 'How do we celebrate birthdays?'),
              TextbookLesson(id: 'l29', title: 'Grammar: Wh-questions'),
              TextbookLesson(id: 'l30', title: 'Writing: A birthday invitation'),
            ]),
          ]),
          // ===== 七年级下册 2024新版 (Unit 1~8) =====
          TextbookSemester(id: '初一下', name: '七年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Animal Friends', lessons: [
              TextbookLesson(id: 'l1', title: 'Why do you like animals?'),
              TextbookLesson(id: 'l2', title: 'Grammar: Adjectives of quality'),
              TextbookLesson(id: 'l3', title: 'Writing: A fact file about an animal'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'No Rules, No Order', lessons: [
              TextbookLesson(id: 'l4', title: 'What rules do you follow?'),
              TextbookLesson(id: 'l5', title: 'Grammar: Imperatives & Modal verbs (must/can)'),
              TextbookLesson(id: 'l6', title: 'Writing: Rules for the library'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Keep Fit', lessons: [
              TextbookLesson(id: 'l7', title: 'How often do you do sport or exercise?'),
              TextbookLesson(id: 'l8', title: 'Grammar: Adverbs of frequency'),
              TextbookLesson(id: 'l9', title: 'Writing: A survey report on exercise habits'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Eat Well', lessons: [
              TextbookLesson(id: 'l10', title: 'What do you like to eat?'),
              TextbookLesson(id: 'l11', title: 'Grammar: Countable & uncountable nouns'),
              TextbookLesson(id: 'l12', title: 'Writing: A healthy menu'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Here and Now', lessons: [
              TextbookLesson(id: 'l13', title: 'What are you doing right now?'),
              TextbookLesson(id: 'l14', title: 'Grammar: Present continuous tense'),
              TextbookLesson(id: 'l15', title: 'Writing: Describe a scene in your town'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'Rain or Shine', lessons: [
              TextbookLesson(id: 'l16', title: 'How is the weather?'),
              TextbookLesson(id: 'l17', title: 'Grammar: Present continuous for future'),
              TextbookLesson(id: 'l18', title: 'Writing: A weather report'),
            ]),
            TextbookUnit(id: 'u7', title: 'Unit 7', label: 'A Day to Remember', lessons: [
              TextbookLesson(id: 'l19', title: 'What was your special day like?'),
              TextbookLesson(id: 'l20', title: 'Grammar: Simple past tense'),
              TextbookLesson(id: 'l21', title: 'Writing: A diary entry'),
            ]),
            TextbookUnit(id: 'u8', title: 'Unit 8', label: 'Once upon a Time', lessons: [
              TextbookLesson(id: 'l22', title: 'What can stories teach us?'),
              TextbookLesson(id: 'l23', title: 'Grammar: Simple past tense (irregular verbs)'),
              TextbookLesson(id: 'l24', title: 'Writing: Tell a story'),
            ]),
          ]),
          // ===== 八年级上册 (Unit 1~10) =====
          TextbookSemester(id: '初二上', name: '八年级上册', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Where did you go on vacation?', lessons: [
              TextbookLesson(id: 'l1', title: 'Talk about past events'),
              TextbookLesson(id: 'l2', title: 'Grammar: Simple past tense review'),
              TextbookLesson(id: 'l3', title: 'Writing: A travel diary'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'How often do you exercise?', lessons: [
              TextbookLesson(id: 'l4', title: 'Talk about how often you do things'),
              TextbookLesson(id: 'l5', title: 'Grammar: How often & adverbs of frequency'),
              TextbookLesson(id: 'l6', title: 'Writing: A report on good habits'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: "I'm more outgoing than my sister", lessons: [
              TextbookLesson(id: 'l7', title: 'Talk about personal traits'),
              TextbookLesson(id: 'l8', title: 'Grammar: Comparatives'),
              TextbookLesson(id: 'l9', title: 'Writing: Compare two friends'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: "What's the best movie theater?", lessons: [
              TextbookLesson(id: 'l10', title: 'Discuss preferences and comparisons'),
              TextbookLesson(id: 'l11', title: 'Grammar: Superlatives'),
              TextbookLesson(id: 'l12', title: 'Writing: A review of a place'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Do you want to watch a game show?', lessons: [
              TextbookLesson(id: 'l13', title: 'Talk about preferences and plans'),
              TextbookLesson(id: 'l14', title: 'Grammar: Infinitives as objects'),
              TextbookLesson(id: 'l15', title: 'Writing: A movie review'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: "I'm going to study computer science", lessons: [
              TextbookLesson(id: 'l16', title: 'Talk about future intentions'),
              TextbookLesson(id: 'l17', title: 'Grammar: Be going to'),
              TextbookLesson(id: 'l18', title: 'Writing: New Year\'s resolutions'),
            ]),
            TextbookUnit(id: 'u7', title: 'Unit 7', label: 'Will people have robots?', lessons: [
              TextbookLesson(id: 'l19', title: 'Make predictions about the future'),
              TextbookLesson(id: 'l20', title: 'Grammar: Simple future with will'),
              TextbookLesson(id: 'l21', title: 'Writing: A paragraph about your future life'),
            ]),
            TextbookUnit(id: 'u8', title: 'Unit 8', label: 'How do you make a banana milk shake?', lessons: [
              TextbookLesson(id: 'l22', title: 'Describe a process and follow instructions'),
              TextbookLesson(id: 'l23', title: 'Grammar: Imperatives & sequencing words'),
              TextbookLesson(id: 'l24', title: 'Writing: A recipe'),
            ]),
            TextbookUnit(id: 'u9', title: 'Unit 9', label: 'Can you come to my party?', lessons: [
              TextbookLesson(id: 'l25', title: 'Make, accept and decline invitations'),
              TextbookLesson(id: 'l26', title: 'Grammar: Modal verbs (can/must/have to)'),
              TextbookLesson(id: 'l27', title: 'Writing: An invitation letter'),
            ]),
            TextbookUnit(id: 'u10', title: 'Unit 10', label: "If you go to the party, you'll have a great time!", lessons: [
              TextbookLesson(id: 'l28', title: 'Talk about consequences'),
              TextbookLesson(id: 'l29', title: 'Grammar: First conditional (if...will)'),
              TextbookLesson(id: 'l30', title: 'Writing: Giving advice with conditionals'),
            ]),
          ]),
          // ===== 八年级下册 (Unit 1~10) =====
          TextbookSemester(id: '初二下', name: '八年级下册', label: '下册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: "What's the matter?", lessons: [
              TextbookLesson(id: 'l1', title: 'Talk about health problems and accidents'),
              TextbookLesson(id: 'l2', title: 'Grammar: Should/shouldn\'t for advice'),
              TextbookLesson(id: 'l3', title: 'Writing: A conversation about a health problem'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: "I'll help to clean up the city parks", lessons: [
              TextbookLesson(id: 'l4', title: 'Offer help'),
              TextbookLesson(id: 'l5', title: 'Grammar: Infinitives as objects & phrasal verbs'),
              TextbookLesson(id: 'l6', title: 'Writing: A letter about volunteering'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Could you please clean your room?', lessons: [
              TextbookLesson(id: 'l7', title: 'Make polite requests and ask for permission'),
              TextbookLesson(id: 'l8', title: 'Grammar: Could for polite requests'),
              TextbookLesson(id: 'l9', title: 'Writing: A letter asking for permission'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: "Why don't you talk to your parents?", lessons: [
              TextbookLesson(id: 'l10', title: 'Talk about problems and give advice'),
              TextbookLesson(id: 'l11', title: 'Grammar: Why don\'t you...? / You could...'),
              TextbookLesson(id: 'l12', title: 'Writing: A letter of advice'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'What were you doing when the rainstorm came?', lessons: [
              TextbookLesson(id: 'l13', title: 'Talk about past events in progress'),
              TextbookLesson(id: 'l14', title: 'Grammar: Past continuous tense'),
              TextbookLesson(id: 'l15', title: 'Writing: A narrative about an important event'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'An old man tried to move the mountains', lessons: [
              TextbookLesson(id: 'l16', title: 'Tell a story'),
              TextbookLesson(id: 'l17', title: 'Grammar: Conjunctions (unless/as soon as/so...that)'),
              TextbookLesson(id: 'l18', title: 'Writing: Retell a traditional story'),
            ]),
            TextbookUnit(id: 'u7', title: 'Unit 7', label: "What's the highest mountain in the world?", lessons: [
              TextbookLesson(id: 'l19', title: 'Talk about geography and nature'),
              TextbookLesson(id: 'l20', title: 'Grammar: Comparative & superlative with large numbers'),
              TextbookLesson(id: 'l21', title: 'Writing: A fact sheet about a natural wonder'),
            ]),
            TextbookUnit(id: 'u8', title: 'Unit 8', label: 'Have you read Treasure Island yet?', lessons: [
              TextbookLesson(id: 'l22', title: 'Talk about recent events and experiences'),
              TextbookLesson(id: 'l23', title: 'Grammar: Present perfect with already/yet'),
              TextbookLesson(id: 'l24', title: 'Writing: A book report'),
            ]),
            TextbookUnit(id: 'u9', title: 'Unit 9', label: 'Have you ever been to a museum?', lessons: [
              TextbookLesson(id: 'l25', title: 'Talk about past experiences'),
              TextbookLesson(id: 'l26', title: 'Grammar: Present perfect with ever/never'),
              TextbookLesson(id: 'l27', title: 'Writing: An ad for your hometown'),
            ]),
            TextbookUnit(id: 'u10', title: 'Unit 10', label: "I've had this bike for three years", lessons: [
              TextbookLesson(id: 'l28', title: 'Talk about possessions and things around you'),
              TextbookLesson(id: 'l29', title: 'Grammar: Present perfect with for/since'),
              TextbookLesson(id: 'l30', title: 'Writing: A paragraph about a favorite thing'),
            ]),
          ]),
          // ===== 九年级全一册 (Unit 1~14, 分上下) =====
          TextbookSemester(id: '初三上', name: '九年级全一册（上）', label: '上册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'How can we become good learners?', lessons: [
              TextbookLesson(id: 'l1', title: 'Talk about how to study'),
              TextbookLesson(id: 'l2', title: 'Grammar: Verb + by doing'),
              TextbookLesson(id: 'l3', title: 'Writing: Give advice on learning English'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'I think that mooncakes are delicious!', lessons: [
              TextbookLesson(id: 'l4', title: 'Give a personal reaction'),
              TextbookLesson(id: 'l5', title: 'Grammar: Objective clauses with that/if/whether'),
              TextbookLesson(id: 'l6', title: 'Writing: A letter about a Chinese festival'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Could you please tell me where the restrooms are?', lessons: [
              TextbookLesson(id: 'l7', title: 'Ask for information politely'),
              TextbookLesson(id: 'l8', title: 'Grammar: Objective clauses with wh- questions'),
              TextbookLesson(id: 'l9', title: 'Writing: A polite request letter'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'I used to be afraid of the dark', lessons: [
              TextbookLesson(id: 'l10', title: 'Talk about what you used to be like'),
              TextbookLesson(id: 'l11', title: 'Grammar: Used to'),
              TextbookLesson(id: 'l12', title: 'Writing: How I have changed'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'What are the shirts made of?', lessons: [
              TextbookLesson(id: 'l13', title: 'Talk about what products are made of and where they were made'),
              TextbookLesson(id: 'l14', title: 'Grammar: Passive voice (present tense)'),
              TextbookLesson(id: 'l15', title: 'Writing: Describe a product'),
            ]),
            TextbookUnit(id: 'u6', title: 'Unit 6', label: 'When was it invented?', lessons: [
              TextbookLesson(id: 'l16', title: 'Talk about the history of inventions'),
              TextbookLesson(id: 'l17', title: 'Grammar: Passive voice (past tense)'),
              TextbookLesson(id: 'l18', title: 'Writing: An introduction to an invention'),
            ]),
            TextbookUnit(id: 'u7', title: 'Unit 7', label: 'Teenagers should be allowed to choose their own clothes', lessons: [
              TextbookLesson(id: 'l19', title: 'Talk about what you are allowed to do'),
              TextbookLesson(id: 'l20', title: 'Grammar: Should + be allowed to'),
              TextbookLesson(id: 'l21', title: 'Writing: A set of rules'),
            ]),
          ]),
          TextbookSemester(id: '初三下', name: '九年级全一册（下）', label: '下册', units: [
            TextbookUnit(id: 'u8', title: 'Unit 8', label: 'It must belong to Carla', lessons: [
              TextbookLesson(id: 'l22', title: 'Make inferences'),
              TextbookLesson(id: 'l23', title: 'Grammar: Must/might/could/can\'t for inferences'),
              TextbookLesson(id: 'l24', title: 'Writing: A mystery story'),
            ]),
            TextbookUnit(id: 'u9', title: 'Unit 9', label: 'I like music that I can dance to', lessons: [
              TextbookLesson(id: 'l25', title: 'Express preferences'),
              TextbookLesson(id: 'l26', title: 'Grammar: Relative clauses with that/who'),
              TextbookLesson(id: 'l27', title: 'Writing: A review of a movie/book/CD'),
            ]),
            TextbookUnit(id: 'u10', title: 'Unit 10', label: "You're supposed to shake hands", lessons: [
              TextbookLesson(id: 'l28', title: 'Talk about customs and what you are supposed to do'),
              TextbookLesson(id: 'l29', title: 'Grammar: Be supposed to / be expected to'),
              TextbookLesson(id: 'l30', title: 'Writing: Customs in China'),
            ]),
            TextbookUnit(id: 'u11', title: 'Unit 11', label: 'Sad movies make me cry', lessons: [
              TextbookLesson(id: 'l31', title: 'Talk about how things affect you'),
              TextbookLesson(id: 'l32', title: 'Grammar: Make + sb + adj / do'),
              TextbookLesson(id: 'l33', title: 'Writing: An experience that made you feel...'),
            ]),
            TextbookUnit(id: 'u12', title: 'Unit 12', label: 'Life is full of the unexpected', lessons: [
              TextbookLesson(id: 'l34', title: 'Narrate past events'),
              TextbookLesson(id: 'l35', title: 'Grammar: Past perfect tense'),
              TextbookLesson(id: 'l36', title: 'Writing: A story about a lucky/unlucky day'),
            ]),
            TextbookUnit(id: 'u13', title: 'Unit 13', label: "We're trying to save the earth!", lessons: [
              TextbookLesson(id: 'l37', title: 'Talk about pollution and environmental protection'),
              TextbookLesson(id: 'l38', title: 'Grammar: Review of tenses'),
              TextbookLesson(id: 'l39', title: 'Writing: A proposal for protecting the environment'),
            ]),
            TextbookUnit(id: 'u14', title: 'Unit 14', label: 'I remember meeting all of you in Grade 7', lessons: [
              TextbookLesson(id: 'l40', title: 'Share memories and look forward to the future'),
              TextbookLesson(id: 'l41', title: 'Grammar: Review of structures'),
              TextbookLesson(id: 'l42', title: 'Writing: A graduation speech'),
            ]),
          ]),
        ]),
      ];

    case Grade.senior:
      return [
        TextbookVersion(id: '人教版', name: '人教版', semesters: [
          // 必修第一册 (6 units: Welcome + U1~U5)
          TextbookSemester(id: '必修一', name: '必修第一册', label: '第一册', units: [
            TextbookUnit(id: 'u0', title: 'Welcome Unit', label: 'Welcome Unit', lessons: [
              TextbookLesson(id: 'l1', title: 'Listening and Speaking'),
              TextbookLesson(id: 'l2', title: 'Reading: First Impressions'),
              TextbookLesson(id: 'l3', title: 'Grammar: Sentence Structure'),
            ]),
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Teenage Life', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: The Freshman Challenge'),
              TextbookLesson(id: 'l5', title: 'Grammar: Noun/Adjective/Adverb Phrases'),
              TextbookLesson(id: 'l6', title: 'Writing: A Letter of Advice'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Travelling Around', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Travel Peru'),
              TextbookLesson(id: 'l8', title: 'Grammar: Present Continuous for Future'),
              TextbookLesson(id: 'l9', title: 'Writing: A Travel Plan'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Sports and Fitness', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: Living Legends'),
              TextbookLesson(id: 'l11', title: 'Grammar: Tag Questions'),
              TextbookLesson(id: 'l12', title: 'Writing: A Page for a Wellness Book'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Natural Disasters', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: The Night the Earth Didn\'t Sleep'),
              TextbookLesson(id: 'l14', title: 'Grammar: Restrictive Relative Clauses'),
              TextbookLesson(id: 'l15', title: 'Writing: A Summary of a News Report'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Languages Around the World', lessons: [
              TextbookLesson(id: 'l16', title: 'Reading: The Chinese Writing System'),
              TextbookLesson(id: 'l17', title: 'Grammar: Restrictive Relative Clauses (where/when/why)'),
              TextbookLesson(id: 'l18', title: 'Writing: A Blog About English Study'),
            ]),
          ]),
          // 必修第二册 (5 units: U1~U5)
          TextbookSemester(id: '必修二', name: '必修第二册', label: '第二册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Cultural Heritage', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: From Problems to Solutions'),
              TextbookLesson(id: 'l2', title: 'Grammar: Restrictive Relative Clauses Review'),
              TextbookLesson(id: 'l3', title: 'Writing: A News Report'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Wildlife Protection', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: A Day in the Clouds'),
              TextbookLesson(id: 'l5', title: 'Grammar: Present Continuous Passive'),
              TextbookLesson(id: 'l6', title: 'Writing: A Poster'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'The Internet', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Stronger Together'),
              TextbookLesson(id: 'l8', title: 'Grammar: Present Perfect Passive'),
              TextbookLesson(id: 'l9', title: 'Writing: A Blog Post'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'History and Traditions', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: What\'s in a Name?'),
              TextbookLesson(id: 'l11', title: 'Grammar: Past Participle as Attribute/Object Complement'),
              TextbookLesson(id: 'l12', title: 'Writing: Describe a Place'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Music', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: The Virtual Choir'),
              TextbookLesson(id: 'l14', title: 'Grammar: Past Participle as Predicative/Adverbial'),
              TextbookLesson(id: 'l15', title: 'Writing: A Speech'),
            ]),
          ]),
          // 必修第三册 (5 units: U1~U5) — 新增
          TextbookSemester(id: '必修三', name: '必修第三册', label: '第三册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Festivals and Celebrations', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: Why Do We Celebrate Festivals?'),
              TextbookLesson(id: 'l2', title: 'Grammar: -ing Form as Attribute/Predicative'),
              TextbookLesson(id: 'l3', title: 'Writing: A Festival Experience'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Morals and Virtues', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: Mother of Ten Thousand Babies'),
              TextbookLesson(id: 'l5', title: 'Grammar: -ing Form as Object Complement/Adverbial'),
              TextbookLesson(id: 'l6', title: 'Writing: A Review of a Moral Fable'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Diverse Cultures', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: A Travel Journal About San Francisco'),
              TextbookLesson(id: 'l8', title: 'Grammar: Ellipsis'),
              TextbookLesson(id: 'l9', title: 'Writing: An Introduction to Your City/Town'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Space Exploration', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: Space: The Final Frontier'),
              TextbookLesson(id: 'l11', title: 'Grammar: Infinitives as Attribute/Adverbial'),
              TextbookLesson(id: 'l12', title: 'Writing: An Argumentative Essay'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'The Value of Money', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: The Million Pound Bank Note (Act 1 Scene 3)'),
              TextbookLesson(id: 'l14', title: 'Grammar: Modal Verbs + Review of Past Participles'),
              TextbookLesson(id: 'l15', title: 'Writing: A Scene for a Play'),
            ]),
          ]),
          // 选择性必修第一册 (5 units: U1~U5)
          TextbookSemester(id: '选必一', name: '选择性必修第一册', label: '第四册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'People of Achievement', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: Tu Youyou Awarded Nobel Prize'),
              TextbookLesson(id: 'l2', title: 'Grammar: Non-restrictive Relative Clauses'),
              TextbookLesson(id: 'l3', title: 'Writing: An Introduction to Someone You Admire'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Looking into the Future', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: Smart Homes to Make Life Easier'),
              TextbookLesson(id: 'l5', title: 'Grammar: Future Progressive Tense'),
              TextbookLesson(id: 'l6', title: 'Writing: An Opinion Essay on Technology'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Fascinating Parks', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Sarek National Park - Europe\'s Hidden Natural Treasure'),
              TextbookLesson(id: 'l8', title: 'Grammar: -ing Form as Subject'),
              TextbookLesson(id: 'l9', title: 'Writing: An Introduction to a Park'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Body Language', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: Listening to How Bodies Talk'),
              TextbookLesson(id: 'l11', title: 'Grammar: -ing Form as Object/Predicative'),
              TextbookLesson(id: 'l12', title: 'Writing: A Description of Body Language'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Working the Land', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: A Pioneer for All People (Yuan Longping)'),
              TextbookLesson(id: 'l14', title: 'Grammar: Subject Clauses'),
              TextbookLesson(id: 'l15', title: 'Writing: An Argumentative Essay on Farming'),
            ]),
          ]),
          // 选择性必修第二册 (5 units: U1~U5)
          TextbookSemester(id: '选必二', name: '选择性必修第二册', label: '第五册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Science and Scientists', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: John Snow Defeats King Cholera'),
              TextbookLesson(id: 'l2', title: 'Grammar: Predicative Clauses'),
              TextbookLesson(id: 'l3', title: 'Writing: An Essay on a Scientific Discovery'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Bridging Cultures', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: Welcome, Xie Lei! Business Student Building Bridges'),
              TextbookLesson(id: 'l5', title: 'Grammar: Noun Clauses Review'),
              TextbookLesson(id: 'l6', title: 'Writing: An Argumentative Letter on Studying Abroad'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Food and Culture', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Culture and Cuisine'),
              TextbookLesson(id: 'l8', title: 'Grammar: Past Perfect Tense'),
              TextbookLesson(id: 'l9', title: 'Writing: A Descriptive Essay on Local Food'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Journey Across a Vast Land', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: Seeing the True North via Rail (Vancouver to Toronto)'),
              TextbookLesson(id: 'l11', title: 'Grammar: Past Participle and -ing Form Review'),
              TextbookLesson(id: 'l12', title: 'Writing: An Email About a Journey'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'First Aid', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: First Aid for Burns'),
              TextbookLesson(id: 'l14', title: 'Grammar: Review of Verb Forms'),
              TextbookLesson(id: 'l15', title: 'Writing: A Narrative Essay About a First Aid Experience'),
            ]),
          ]),
          // 选择性必修第三册 (5 units: U1~U5)
          TextbookSemester(id: '选必三', name: '选择性必修第三册', label: '第六册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Art', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: A Short History of Western Painting'),
              TextbookLesson(id: 'l2', title: 'Grammar: Infinitives as Predicative'),
              TextbookLesson(id: 'l3', title: 'Writing: An Art Exhibition Announcement'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Healthy Lifestyle', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: Habits for a Healthy Lifestyle'),
              TextbookLesson(id: 'l5', title: 'Grammar: Infinitives as Subject'),
              TextbookLesson(id: 'l6', title: 'Writing: A Letter About Lifestyle Changes'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Environmental Protection', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Climate Change Requires the World\'s Attention'),
              TextbookLesson(id: 'l8', title: 'Grammar: Direct and Indirect Speech'),
              TextbookLesson(id: 'l9', title: 'Writing: A Report on an Environmental Issue'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Adversity and Courage', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: A Successful Failure (Shackleton\'s Antarctic Expedition)'),
              TextbookLesson(id: 'l11', title: 'Grammar: Present Perfect Continuous'),
              TextbookLesson(id: 'l12', title: 'Writing: A Continuation of a Story'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Poems', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: A Few Simple Forms of English Poems'),
              TextbookLesson(id: 'l14', title: 'Grammar: Review of Relative Clauses'),
              TextbookLesson(id: 'l15', title: 'Writing: Compose a Poem'),
            ]),
          ]),
          // 选择性必修第四册 (5 units: U1~U5) — 新增
          TextbookSemester(id: '选必四', name: '选择性必修第四册', label: '第七册', units: [
            TextbookUnit(id: 'u1', title: 'Unit 1', label: 'Science Fiction', lessons: [
              TextbookLesson(id: 'l1', title: 'Reading: Satisfaction Guaranteed (Adapted from Asimov)'),
              TextbookLesson(id: 'l2', title: 'Grammar: Passive Voice Review'),
              TextbookLesson(id: 'l3', title: 'Writing: A Sci-Fi Short Story'),
            ]),
            TextbookUnit(id: 'u2', title: 'Unit 2', label: 'Iconic Attractions', lessons: [
              TextbookLesson(id: 'l4', title: 'Reading: Australia — The Land of Icons'),
              TextbookLesson(id: 'l5', title: 'Grammar: Past Participle Review'),
              TextbookLesson(id: 'l6', title: 'Writing: An Introduction to a Country\'s Iconic Attraction'),
            ]),
            TextbookUnit(id: 'u3', title: 'Unit 3', label: 'Sea Exploration', lessons: [
              TextbookLesson(id: 'l7', title: 'Reading: Reaching Out Across the Sea'),
              TextbookLesson(id: 'l8', title: 'Grammar: Infinitive Review'),
              TextbookLesson(id: 'l9', title: 'Writing: An Argumentative Essay on Sea Exploration'),
            ]),
            TextbookUnit(id: 'u4', title: 'Unit 4', label: 'Sharing', lessons: [
              TextbookLesson(id: 'l10', title: 'Reading: Volunteering in the Bush (Papua New Guinea)'),
              TextbookLesson(id: 'l11', title: 'Grammar: Phrasal Verbs Review'),
              TextbookLesson(id: 'l12', title: 'Writing: A Speech About Volunteering'),
            ]),
            TextbookUnit(id: 'u5', title: 'Unit 5', label: 'Launching Your Career', lessons: [
              TextbookLesson(id: 'l13', title: 'Reading: Summer Camp — What\'s Your Career Path?'),
              TextbookLesson(id: 'l14', title: 'Grammar: Long Sentences Analysis'),
              TextbookLesson(id: 'l15', title: 'Writing: A CV / Cover Letter'),
            ]),
          ]),
        ]),
      ];
  }
}
