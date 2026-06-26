/// 猫咪老师 - 真实教材目录数据
/// 涵盖8大学科的真实教材章节（人教版/部编版/教科版）
library textbook_real_data;

import '../config/api_config.dart';
import 'textbook.dart';

// ============================================================
// 路由：根据学科+年级返回真实教材
// ============================================================

List<TextbookVersion> getRealTextbooks(Grade grade, String subjectKey) {
  switch (subjectKey) {
    case 'physics':   return _getPhysicsTextbooks(grade);
    case 'chemistry': return _getChemistryTextbooks(grade);
    case 'biology':   return _getBiologyTextbooks(grade);
    case 'history':   return _getHistoryTextbooks(grade);
    case 'geography': return _getGeographyTextbooks(grade);
    case 'morality':
    case 'politics':  return _getMoralityPoliticsTextbooks(grade);
    case 'science':   return _getScienceTextbooks(grade);
    default:          return _getFallbackTextbooks(grade, subjectKey);
  }
}

// ============================================================
// 物理 — 人教版
// ============================================================

List<TextbookVersion> _getPhysicsTextbooks(Grade grade) {
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '人教版', name: '人教版', semesters: [
      // 八年级上册
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一章', label: '机械运动', lessons: [
          TextbookLesson(id: 'l1', title: '长度和时间的测量'),
          TextbookLesson(id: 'l2', title: '运动的描述'),
          TextbookLesson(id: 'l3', title: '运动的快慢'),
          TextbookLesson(id: 'l4', title: '测量平均速度'),
        ]),
        TextbookUnit(id: 'u2', title: '第二章', label: '声现象', lessons: [
          TextbookLesson(id: 'l5', title: '声音的产生与传播'),
          TextbookLesson(id: 'l6', title: '声音的特性'),
          TextbookLesson(id: 'l7', title: '声的利用'),
          TextbookLesson(id: 'l8', title: '噪声的危害和控制'),
        ]),
        TextbookUnit(id: 'u3', title: '第三章', label: '物态变化', lessons: [
          TextbookLesson(id: 'l9', title: '温度'),
          TextbookLesson(id: 'l10', title: '熔化和凝固'),
          TextbookLesson(id: 'l11', title: '汽化和液化'),
          TextbookLesson(id: 'l12', title: '升华和凝华'),
        ]),
        TextbookUnit(id: 'u4', title: '第四章', label: '光现象', lessons: [
          TextbookLesson(id: 'l13', title: '光的直线传播'),
          TextbookLesson(id: 'l14', title: '光的反射'),
          TextbookLesson(id: 'l15', title: '平面镜成像'),
          TextbookLesson(id: 'l16', title: '光的折射'),
        ]),
        TextbookUnit(id: 'u5', title: '第五章', label: '透镜及其应用', lessons: [
          TextbookLesson(id: 'l17', title: '透镜'),
          TextbookLesson(id: 'l18', title: '生活中的透镜'),
          TextbookLesson(id: 'l19', title: '凸透镜成像的规律'),
          TextbookLesson(id: 'l20', title: '眼睛和眼镜'),
        ]),
        TextbookUnit(id: 'u6', title: '第六章', label: '质量与密度', lessons: [
          TextbookLesson(id: 'l21', title: '质量'),
          TextbookLesson(id: 'l22', title: '密度'),
          TextbookLesson(id: 'l23', title: '测量物质的密度'),
          TextbookLesson(id: 'l24', title: '密度与社会生活'),
        ]),
      ]),
      // 八年级下册
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第七章', label: '力', lessons: [
          TextbookLesson(id: 'l1', title: '力'),
          TextbookLesson(id: 'l2', title: '弹力'),
          TextbookLesson(id: 'l3', title: '重力'),
        ]),
        TextbookUnit(id: 'u2', title: '第八章', label: '运动和力', lessons: [
          TextbookLesson(id: 'l4', title: '牛顿第一定律'),
          TextbookLesson(id: 'l5', title: '二力平衡'),
          TextbookLesson(id: 'l6', title: '摩擦力'),
        ]),
        TextbookUnit(id: 'u3', title: '第九章', label: '压强', lessons: [
          TextbookLesson(id: 'l7', title: '压强'),
          TextbookLesson(id: 'l8', title: '液体的压强'),
          TextbookLesson(id: 'l9', title: '大气压强'),
          TextbookLesson(id: 'l10', title: '流体压强与流速的关系'),
        ]),
        TextbookUnit(id: 'u4', title: '第十章', label: '浮力', lessons: [
          TextbookLesson(id: 'l11', title: '浮力'),
          TextbookLesson(id: 'l12', title: '阿基米德原理'),
          TextbookLesson(id: 'l13', title: '物体的浮沉条件及应用'),
        ]),
        TextbookUnit(id: 'u5', title: '第十一章', label: '功和机械能', lessons: [
          TextbookLesson(id: 'l14', title: '功'),
          TextbookLesson(id: 'l15', title: '功率'),
          TextbookLesson(id: 'l16', title: '动能和势能'),
          TextbookLesson(id: 'l17', title: '机械能及其转化'),
        ]),
        TextbookUnit(id: 'u6', title: '第十二章', label: '简单机械', lessons: [
          TextbookLesson(id: 'l18', title: '杠杆'),
          TextbookLesson(id: 'l19', title: '滑轮'),
          TextbookLesson(id: 'l20', title: '机械效率'),
        ]),
      ]),
      // 九年级全一册
      TextbookSemester(id: '九全', name: '九年级全一册', label: '全一册', units: [
        TextbookUnit(id: 'u1', title: '第十三章', label: '内能', lessons: [
          TextbookLesson(id: 'l1', title: '分子热运动'),
          TextbookLesson(id: 'l2', title: '内能'),
          TextbookLesson(id: 'l3', title: '比热容'),
        ]),
        TextbookUnit(id: 'u2', title: '第十四章', label: '内能的利用', lessons: [
          TextbookLesson(id: 'l4', title: '热机'),
          TextbookLesson(id: 'l5', title: '热机的效率'),
          TextbookLesson(id: 'l6', title: '能量的转化和守恒'),
        ]),
        TextbookUnit(id: 'u3', title: '第十五章', label: '电流和电路', lessons: [
          TextbookLesson(id: 'l7', title: '两种电荷'),
          TextbookLesson(id: 'l8', title: '电流和电路'),
          TextbookLesson(id: 'l9', title: '串联和并联'),
          TextbookLesson(id: 'l10', title: '电流的测量'),
        ]),
        TextbookUnit(id: 'u4', title: '第十六章', label: '电压 电阻', lessons: [
          TextbookLesson(id: 'l11', title: '电压'),
          TextbookLesson(id: 'l12', title: '串并联电路中电压的规律'),
          TextbookLesson(id: 'l13', title: '电阻'),
          TextbookLesson(id: 'l14', title: '变阻器'),
        ]),
        TextbookUnit(id: 'u5', title: '第十七章', label: '欧姆定律', lessons: [
          TextbookLesson(id: 'l15', title: '电流与电压和电阻的关系'),
          TextbookLesson(id: 'l16', title: '欧姆定律'),
          TextbookLesson(id: 'l17', title: '电阻的测量'),
        ]),
        TextbookUnit(id: 'u6', title: '第十八章', label: '电功率', lessons: [
          TextbookLesson(id: 'l18', title: '电能 电功'),
          TextbookLesson(id: 'l19', title: '电功率'),
          TextbookLesson(id: 'l20', title: '测量小灯泡的电功率'),
          TextbookLesson(id: 'l21', title: '焦耳定律'),
        ]),
        TextbookUnit(id: 'u7', title: '第十九章', label: '生活用电', lessons: [
          TextbookLesson(id: 'l22', title: '家庭电路'),
          TextbookLesson(id: 'l23', title: '家庭电路中电流过大的原因'),
          TextbookLesson(id: 'l24', title: '安全用电'),
        ]),
        TextbookUnit(id: 'u8', title: '第二十章', label: '电与磁', lessons: [
          TextbookLesson(id: 'l25', title: '磁现象 磁场'),
          TextbookLesson(id: 'l26', title: '电生磁'),
          TextbookLesson(id: 'l27', title: '电磁铁 电磁继电器'),
          TextbookLesson(id: 'l28', title: '电动机'),
          TextbookLesson(id: 'l29', title: '磁生电'),
        ]),
        TextbookUnit(id: 'u9', title: '第二十一章', label: '信息的传递', lessons: [
          TextbookLesson(id: 'l30', title: '现代顺风耳——电话'),
          TextbookLesson(id: 'l31', title: '电磁波的海洋'),
        ]),
        TextbookUnit(id: 'u10', title: '第二十二章', label: '能源与可持续发展', lessons: [
          TextbookLesson(id: 'l32', title: '能源'),
          TextbookLesson(id: 'l33', title: '核能'),
          TextbookLesson(id: 'l34', title: '太阳能'),
        ]),
      ]),
    ])];
  }

  // 高中物理 人教版(2019)
  return [TextbookVersion(id: '人教版', name: '人教版(2019版)', semesters: [
    // 必修第一册
    TextbookSemester(id: '必修一', name: '必修第一册', label: '必修一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '运动的描述', lessons: [
        TextbookLesson(id: 'l1', title: '质点 参考系'),
        TextbookLesson(id: 'l2', title: '时间 位移'),
        TextbookLesson(id: 'l3', title: '位置变化快慢的描述——速度'),
        TextbookLesson(id: 'l4', title: '速度变化快慢的描述——加速度'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '匀变速直线运动的研究', lessons: [
        TextbookLesson(id: 'l5', title: '实验：探究小车速度随时间变化的规律'),
        TextbookLesson(id: 'l6', title: '匀变速直线运动的速度与时间的关系'),
        TextbookLesson(id: 'l7', title: '匀变速直线运动的位移与时间的关系'),
        TextbookLesson(id: 'l8', title: '自由落体运动'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '相互作用——力', lessons: [
        TextbookLesson(id: 'l9', title: '重力与弹力'),
        TextbookLesson(id: 'l10', title: '摩擦力'),
        TextbookLesson(id: 'l11', title: '牛顿第三定律'),
        TextbookLesson(id: 'l12', title: '力的合成和分解'),
        TextbookLesson(id: 'l13', title: '共点力的平衡'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '运动和力的关系', lessons: [
        TextbookLesson(id: 'l14', title: '牛顿第一定律'),
        TextbookLesson(id: 'l15', title: '实验：探究加速度与力、质量的关系'),
        TextbookLesson(id: 'l16', title: '牛顿第二定律'),
        TextbookLesson(id: 'l17', title: '力学单位制'),
        TextbookLesson(id: 'l18', title: '牛顿运动定律的应用'),
        TextbookLesson(id: 'l19', title: '超重和失重'),
      ]),
    ]),
    // 必修第二册
    TextbookSemester(id: '必修二', name: '必修第二册', label: '必修二', units: [
      TextbookUnit(id: 'u1', title: '第五章', label: '抛体运动', lessons: [
        TextbookLesson(id: 'l1', title: '曲线运动'),
        TextbookLesson(id: 'l2', title: '运动的合成与分解'),
        TextbookLesson(id: 'l3', title: '实验：探究平抛运动的特点'),
        TextbookLesson(id: 'l4', title: '抛体运动的规律'),
      ]),
      TextbookUnit(id: 'u2', title: '第六章', label: '圆周运动', lessons: [
        TextbookLesson(id: 'l5', title: '圆周运动'),
        TextbookLesson(id: 'l6', title: '向心力'),
        TextbookLesson(id: 'l7', title: '向心加速度'),
        TextbookLesson(id: 'l8', title: '生活中的圆周运动'),
      ]),
      TextbookUnit(id: 'u3', title: '第七章', label: '万有引力与宇宙航行', lessons: [
        TextbookLesson(id: 'l9', title: '行星的运动'),
        TextbookLesson(id: 'l10', title: '万有引力定律'),
        TextbookLesson(id: 'l11', title: '万有引力理论的成就'),
        TextbookLesson(id: 'l12', title: '宇宙航行'),
        TextbookLesson(id: 'l13', title: '相对论时空观与牛顿力学的局限性'),
      ]),
      TextbookUnit(id: 'u4', title: '第八章', label: '机械能守恒定律', lessons: [
        TextbookLesson(id: 'l14', title: '功与功率'),
        TextbookLesson(id: 'l15', title: '重力势能'),
        TextbookLesson(id: 'l16', title: '动能和动能定理'),
        TextbookLesson(id: 'l17', title: '机械能守恒定律'),
        TextbookLesson(id: 'l18', title: '实验：验证机械能守恒定律'),
      ]),
    ]),
    // 必修第三册
    TextbookSemester(id: '必修三', name: '必修第三册', label: '必修三', units: [
      TextbookUnit(id: 'u1', title: '第九章', label: '静电场及其应用', lessons: [
        TextbookLesson(id: 'l1', title: '电荷'),
        TextbookLesson(id: 'l2', title: '库仑定律'),
        TextbookLesson(id: 'l3', title: '电场 电场强度'),
        TextbookLesson(id: 'l4', title: '静电的防止与利用'),
      ]),
      TextbookUnit(id: 'u2', title: '第十章', label: '静电场中的能量', lessons: [
        TextbookLesson(id: 'l5', title: '电势能和电势'),
        TextbookLesson(id: 'l6', title: '电势差'),
        TextbookLesson(id: 'l7', title: '电势差与电场强度的关系'),
        TextbookLesson(id: 'l8', title: '电容器的电容'),
        TextbookLesson(id: 'l9', title: '带电粒子在电场中的运动'),
      ]),
      TextbookUnit(id: 'u3', title: '第十一章', label: '电路及其应用', lessons: [
        TextbookLesson(id: 'l10', title: '电源和电流'),
        TextbookLesson(id: 'l11', title: '导体的电阻'),
        TextbookLesson(id: 'l12', title: '实验：导体电阻率的测量'),
        TextbookLesson(id: 'l13', title: '串联电路和并联电路'),
        TextbookLesson(id: 'l14', title: '实验：练习使用多用电表'),
      ]),
      TextbookUnit(id: 'u4', title: '第十二章', label: '电能 能量守恒定律', lessons: [
        TextbookLesson(id: 'l15', title: '电路中的能量转化'),
        TextbookLesson(id: 'l16', title: '闭合电路的欧姆定律'),
        TextbookLesson(id: 'l17', title: '实验：电池电动势和内阻的测量'),
        TextbookLesson(id: 'l18', title: '能源与可持续发展'),
      ]),
      TextbookUnit(id: 'u5', title: '第十三章', label: '电磁感应与电磁波初步', lessons: [
        TextbookLesson(id: 'l19', title: '磁场 磁感线'),
        TextbookLesson(id: 'l20', title: '磁感应强度 磁通量'),
        TextbookLesson(id: 'l21', title: '电磁感应现象及应用'),
        TextbookLesson(id: 'l22', title: '电磁波的发现及应用'),
        TextbookLesson(id: 'l23', title: '能量量子化'),
      ]),
    ]),
    // 选择性必修第一册
    TextbookSemester(id: '选必一', name: '选择性必修第一册', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '动量守恒定律', lessons: [
        TextbookLesson(id: 'l1', title: '动量'),
        TextbookLesson(id: 'l2', title: '动量定理'),
        TextbookLesson(id: 'l3', title: '动量守恒定律'),
        TextbookLesson(id: 'l4', title: '实验：验证动量守恒定律'),
        TextbookLesson(id: 'l5', title: '弹性碰撞和非弹性碰撞'),
        TextbookLesson(id: 'l6', title: '反冲现象 火箭'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '机械振动', lessons: [
        TextbookLesson(id: 'l7', title: '简谐运动'),
        TextbookLesson(id: 'l8', title: '简谐运动的描述'),
        TextbookLesson(id: 'l9', title: '简谐运动的回复力和能量'),
        TextbookLesson(id: 'l10', title: '单摆'),
        TextbookLesson(id: 'l11', title: '实验：用单摆测量重力加速度'),
        TextbookLesson(id: 'l12', title: '受迫振动 共振'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '机械波', lessons: [
        TextbookLesson(id: 'l13', title: '波的形成'),
        TextbookLesson(id: 'l14', title: '波的描述'),
        TextbookLesson(id: 'l15', title: '波的反射、折射和衍射'),
        TextbookLesson(id: 'l16', title: '波的干涉'),
        TextbookLesson(id: 'l17', title: '多普勒效应'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '光', lessons: [
        TextbookLesson(id: 'l18', title: '光的折射'),
        TextbookLesson(id: 'l19', title: '全反射'),
        TextbookLesson(id: 'l20', title: '光的干涉'),
        TextbookLesson(id: 'l21', title: '实验：用双缝干涉测量光的波长'),
        TextbookLesson(id: 'l22', title: '光的衍射'),
        TextbookLesson(id: 'l23', title: '光的偏振 激光'),
      ]),
    ]),
    // 选择性必修第二册
    TextbookSemester(id: '选必二', name: '选择性必修第二册', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '安培力与洛伦兹力', lessons: [
        TextbookLesson(id: 'l1', title: '磁场对通电导线的作用力'),
        TextbookLesson(id: 'l2', title: '磁场对运动电荷的作用力'),
        TextbookLesson(id: 'l3', title: '带电粒子在匀强磁场中的运动'),
        TextbookLesson(id: 'l4', title: '质谱仪与回旋加速器'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '电磁感应', lessons: [
        TextbookLesson(id: 'l5', title: '楞次定律'),
        TextbookLesson(id: 'l6', title: '法拉第电磁感应定律'),
        TextbookLesson(id: 'l7', title: '涡流、电磁阻尼和电磁驱动'),
        TextbookLesson(id: 'l8', title: '互感和自感'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '交变电流', lessons: [
        TextbookLesson(id: 'l9', title: '交变电流'),
        TextbookLesson(id: 'l10', title: '交变电流的描述'),
        TextbookLesson(id: 'l11', title: '变压器'),
        TextbookLesson(id: 'l12', title: '电能的输送'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '电磁振荡与电磁波', lessons: [
        TextbookLesson(id: 'l13', title: '电磁振荡'),
        TextbookLesson(id: 'l14', title: '电磁场与电磁波'),
        TextbookLesson(id: 'l15', title: '无线电波的发射和接收'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '传感器', lessons: [
        TextbookLesson(id: 'l16', title: '认识传感器'),
        TextbookLesson(id: 'l17', title: '常见传感器的工作原理及应用'),
        TextbookLesson(id: 'l18', title: '利用传感器制作简单的自动控制装置'),
      ]),
    ]),
    // 选择性必修第三册
    TextbookSemester(id: '选必三', name: '选择性必修第三册', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '分子动理论', lessons: [
        TextbookLesson(id: 'l1', title: '分子动理论的基本内容'),
        TextbookLesson(id: 'l2', title: '实验：用油膜法估测油酸分子的大小'),
        TextbookLesson(id: 'l3', title: '分子运动速率分布规律'),
        TextbookLesson(id: 'l4', title: '分子动能和分子势能'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '气体、固体和液体', lessons: [
        TextbookLesson(id: 'l5', title: '温度和温标'),
        TextbookLesson(id: 'l6', title: '气体的等温变化'),
        TextbookLesson(id: 'l7', title: '气体的等压变化和等容变化'),
        TextbookLesson(id: 'l8', title: '固体'),
        TextbookLesson(id: 'l9', title: '液体'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '热力学定律', lessons: [
        TextbookLesson(id: 'l10', title: '功、热和内能的改变'),
        TextbookLesson(id: 'l11', title: '热力学第一定律'),
        TextbookLesson(id: 'l12', title: '能量守恒定律'),
        TextbookLesson(id: 'l13', title: '热力学第二定律'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '原子结构和波粒二象性', lessons: [
        TextbookLesson(id: 'l14', title: '普朗克黑体辐射理论'),
        TextbookLesson(id: 'l15', title: '光电效应'),
        TextbookLesson(id: 'l16', title: '原子的核式结构模型'),
        TextbookLesson(id: 'l17', title: '氢原子光谱和玻尔的原子模型'),
        TextbookLesson(id: 'l18', title: '粒子的波动性和量子力学的建立'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '原子核', lessons: [
        TextbookLesson(id: 'l19', title: '原子核的组成'),
        TextbookLesson(id: 'l20', title: '放射性元素的衰变'),
        TextbookLesson(id: 'l21', title: '核力与结合能'),
        TextbookLesson(id: 'l22', title: '核裂变与核聚变'),
        TextbookLesson(id: 'l23', title: '基本粒子'),
      ]),
    ]),
  ])];
}

// ============================================================
// 化学 — 人教版
// ============================================================

List<TextbookVersion> _getChemistryTextbooks(Grade grade) {
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '人教版', name: '人教版', semesters: [
      // 九年级上册
      TextbookSemester(id: '九上', name: '九年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '走进化学世界', lessons: [
          TextbookLesson(id: 'l1', title: '物质的变化和性质'),
          TextbookLesson(id: 'l2', title: '化学是一门以实验为基础的科学'),
          TextbookLesson(id: 'l3', title: '走进化学实验室'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们周围的空气', lessons: [
          TextbookLesson(id: 'l4', title: '空气'),
          TextbookLesson(id: 'l5', title: '氧气'),
          TextbookLesson(id: 'l6', title: '制取氧气'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '物质构成的奥秘', lessons: [
          TextbookLesson(id: 'l7', title: '分子和原子'),
          TextbookLesson(id: 'l8', title: '原子的结构'),
          TextbookLesson(id: 'l9', title: '元素'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '自然界的水', lessons: [
          TextbookLesson(id: 'l10', title: '爱护水资源'),
          TextbookLesson(id: 'l11', title: '水的净化'),
          TextbookLesson(id: 'l12', title: '水的组成'),
          TextbookLesson(id: 'l13', title: '化学式与化合价'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '化学方程式', lessons: [
          TextbookLesson(id: 'l14', title: '质量守恒定律'),
          TextbookLesson(id: 'l15', title: '如何正确书写化学方程式'),
          TextbookLesson(id: 'l16', title: '利用化学方程式的简单计算'),
        ]),
        TextbookUnit(id: 'u6', title: '第六单元', label: '碳和碳的氧化物', lessons: [
          TextbookLesson(id: 'l17', title: '金刚石、石墨和C60'),
          TextbookLesson(id: 'l18', title: '二氧化碳制取的研究'),
          TextbookLesson(id: 'l19', title: '二氧化碳和一氧化碳'),
        ]),
        TextbookUnit(id: 'u7', title: '第七单元', label: '燃料及其利用', lessons: [
          TextbookLesson(id: 'l20', title: '燃烧和灭火'),
          TextbookLesson(id: 'l21', title: '燃料的合理利用与开发'),
        ]),
      ]),
      // 九年级下册
      TextbookSemester(id: '九下', name: '九年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第八单元', label: '金属和金属材料', lessons: [
          TextbookLesson(id: 'l1', title: '金属材料'),
          TextbookLesson(id: 'l2', title: '金属的化学性质'),
          TextbookLesson(id: 'l3', title: '金属资源的利用和保护'),
        ]),
        TextbookUnit(id: 'u2', title: '第九单元', label: '溶液', lessons: [
          TextbookLesson(id: 'l1', title: '溶液的形成'),
          TextbookLesson(id: 'l2', title: '溶解度'),
          TextbookLesson(id: 'l3', title: '溶液的浓度'),
        ]),
        TextbookUnit(id: 'u3', title: '第十单元', label: '酸和碱', lessons: [
          TextbookLesson(id: 'l1', title: '常见的酸和碱'),
          TextbookLesson(id: 'l2', title: '酸和碱的中和反应'),
        ]),
        TextbookUnit(id: 'u4', title: '第十一单元', label: '盐 化肥', lessons: [
          TextbookLesson(id: 'l1', title: '生活中常见的盐'),
          TextbookLesson(id: 'l2', title: '粗盐中难溶性杂质的去除'),
          TextbookLesson(id: 'l3', title: '化学肥料'),
        ]),
        TextbookUnit(id: 'u5', title: '第十二单元', label: '化学与生活', lessons: [
          TextbookLesson(id: 'l1', title: '人类重要的营养物质'),
          TextbookLesson(id: 'l2', title: '化学元素与人体健康'),
          TextbookLesson(id: 'l3', title: '有机合成材料'),
        ]),
        TextbookUnit(id: 'u6', title: '第十三单元', label: '化学与社会发展', lessons: [
          TextbookLesson(id: 'l1', title: '化学与能源'),
          TextbookLesson(id: 'l2', title: '化学与材料'),
          TextbookLesson(id: 'l3', title: '化学与环境'),
        ]),
        TextbookUnit(id: 'u7', title: '实验活动', label: '实验活动', lessons: [
          TextbookLesson(id: 'l1', title: '实验活动1 氧气的实验室制取与性质'),
          TextbookLesson(id: 'l2', title: '实验活动2 二氧化碳的实验室制取与性质'),
          TextbookLesson(id: 'l3', title: '实验活动3 燃烧的条件'),
          TextbookLesson(id: 'l4', title: '实验活动4 金属的物理性质和化学性质'),
          TextbookLesson(id: 'l5', title: '实验活动5 一定溶质质量分数的氯化钠溶液的配制'),
          TextbookLesson(id: 'l6', title: '实验活动6 酸碱的化学性质'),
          TextbookLesson(id: 'l7', title: '实验活动7 溶液酸碱性的检验'),
          TextbookLesson(id: 'l8', title: '实验活动8 粗盐中难溶性杂质的去除'),
        ]),
      ]),
    ])];
  }
  // 高中化学 人教版(2019)
  return [TextbookVersion(id: '人教版', name: '人教版(2019版)', semesters: [
    // 必修第一册
    TextbookSemester(id: '必修一', name: '必修第一册', label: '必修一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '物质及其变化', lessons: [
        TextbookLesson(id: 'l1', title: '物质的分类及转化'),
        TextbookLesson(id: 'l2', title: '离子反应'),
        TextbookLesson(id: 'l3', title: '氧化还原反应'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '海水中的重要元素——钠和氯', lessons: [
        TextbookLesson(id: 'l4', title: '钠及其化合物'),
        TextbookLesson(id: 'l5', title: '氯及其化合物'),
        TextbookLesson(id: 'l6', title: '物质的量'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '铁 金属材料', lessons: [
        TextbookLesson(id: 'l7', title: '铁及其化合物'),
        TextbookLesson(id: 'l8', title: '金属材料'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '物质结构 元素周期律', lessons: [
        TextbookLesson(id: 'l9', title: '原子结构与元素周期表'),
        TextbookLesson(id: 'l10', title: '元素周期律'),
        TextbookLesson(id: 'l11', title: '化学键'),
      ]),
    ]),
    // 必修第二册
    TextbookSemester(id: '必修二', name: '必修第二册', label: '必修二', units: [
      TextbookUnit(id: 'u1', title: '第五章', label: '化工生产中的重要非金属元素', lessons: [
        TextbookLesson(id: 'l1', title: '硫及其化合物'),
        TextbookLesson(id: 'l2', title: '氮及其化合物'),
        TextbookLesson(id: 'l3', title: '无机非金属材料'),
      ]),
      TextbookUnit(id: 'u2', title: '第六章', label: '化学反应与能量', lessons: [
        TextbookLesson(id: 'l4', title: '化学反应与能量变化'),
        TextbookLesson(id: 'l5', title: '化学反应的速率与限度'),
      ]),
      TextbookUnit(id: 'u3', title: '第七章', label: '有机化合物', lessons: [
        TextbookLesson(id: 'l6', title: '认识有机化合物'),
        TextbookLesson(id: 'l7', title: '乙烯与有机高分子材料'),
        TextbookLesson(id: 'l8', title: '乙醇与乙酸'),
        TextbookLesson(id: 'l9', title: '基本营养物质'),
      ]),
      TextbookUnit(id: 'u4', title: '第八章', label: '化学与可持续发展', lessons: [
        TextbookLesson(id: 'l10', title: '自然资源的开发利用'),
        TextbookLesson(id: 'l11', title: '化学品的合理使用'),
        TextbookLesson(id: 'l12', title: '环境保护与绿色化学'),
      ]),
    ]),
    // 选择性必修一
    TextbookSemester(id: '选必一', name: '选择性必修一', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '化学反应的热效应', lessons: [
        TextbookLesson(id: 'l1', title: '反应热'),
        TextbookLesson(id: 'l2', title: '反应热的计算'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '化学反应速率与化学平衡', lessons: [
        TextbookLesson(id: 'l3', title: '化学反应速率'),
        TextbookLesson(id: 'l4', title: '化学平衡'),
        TextbookLesson(id: 'l5', title: '化学反应的方向'),
        TextbookLesson(id: 'l6', title: '化学反应的调控'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '水溶液中的离子反应与平衡', lessons: [
        TextbookLesson(id: 'l7', title: '电离平衡'),
        TextbookLesson(id: 'l8', title: '水的电离和溶液的pH'),
        TextbookLesson(id: 'l9', title: '盐类的水解'),
        TextbookLesson(id: 'l10', title: '沉淀溶解平衡'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '化学反应与电能', lessons: [
        TextbookLesson(id: 'l11', title: '原电池'),
        TextbookLesson(id: 'l12', title: '电解池'),
        TextbookLesson(id: 'l13', title: '金属的腐蚀与防护'),
      ]),
    ]),
    // 选择性必修二
    TextbookSemester(id: '选必二', name: '选择性必修二', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '原子结构与性质', lessons: [
        TextbookLesson(id: 'l1', title: '原子结构'),
        TextbookLesson(id: 'l2', title: '原子结构与元素的性质'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '分子结构与性质', lessons: [
        TextbookLesson(id: 'l3', title: '共价键'),
        TextbookLesson(id: 'l4', title: '分子的空间结构'),
        TextbookLesson(id: 'l5', title: '分子结构与物质的性质'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '晶体结构与性质', lessons: [
        TextbookLesson(id: 'l6', title: '物质的聚集状态与晶体的常识'),
        TextbookLesson(id: 'l7', title: '分子晶体与共价晶体'),
        TextbookLesson(id: 'l8', title: '金属晶体与离子晶体'),
        TextbookLesson(id: 'l9', title: '配合物与超分子'),
      ]),
    ]),
    // 选择性必修三
    TextbookSemester(id: '选必三', name: '选择性必修三', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '有机化合物的结构特点与研究方法', lessons: [
        TextbookLesson(id: 'l1', title: '有机化合物的结构特点'),
        TextbookLesson(id: 'l2', title: '研究有机化合物的一般方法'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '烃', lessons: [
        TextbookLesson(id: 'l3', title: '烷烃'),
        TextbookLesson(id: 'l4', title: '烯烃 炔烃'),
        TextbookLesson(id: 'l5', title: '芳香烃'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '烃的衍生物', lessons: [
        TextbookLesson(id: 'l6', title: '卤代烃'),
        TextbookLesson(id: 'l7', title: '醇 酚'),
        TextbookLesson(id: 'l8', title: '醛 酮'),
        TextbookLesson(id: 'l9', title: '羧酸 羧酸衍生物'),
        TextbookLesson(id: 'l10', title: '有机合成'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '生物大分子', lessons: [
        TextbookLesson(id: 'l11', title: '糖类'),
        TextbookLesson(id: 'l12', title: '蛋白质'),
        TextbookLesson(id: 'l13', title: '核酸'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '合成高分子', lessons: [
        TextbookLesson(id: 'l14', title: '合成高分子的基本方法'),
        TextbookLesson(id: 'l15', title: '高分子材料'),
      ]),
    ]),
  ])];
}

// ============================================================
// 生物 — 人教版
// ============================================================

List<TextbookVersion> _getBiologyTextbooks(Grade grade) {
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '人教版', name: '人教版', semesters: [
      // ============= 七年级上册 (5 单元) =============
      TextbookSemester(id: '七上', name: '七年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '生物和生物圈', lessons: [
          TextbookLesson(id: 'l1', title: '生物的特征'),
          TextbookLesson(id: 'l2', title: '调查周边环境中的生物'),
          TextbookLesson(id: 'l3', title: '生物与环境的关系'),
          TextbookLesson(id: 'l4', title: '生态系统'),
          TextbookLesson(id: 'l5', title: '生物圈是最大的生态系统'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '生物体的结构层次', lessons: [
          TextbookLesson(id: 'l1', title: '练习使用显微镜'),
          TextbookLesson(id: 'l2', title: '植物细胞'),
          TextbookLesson(id: 'l3', title: '动物细胞'),
          TextbookLesson(id: 'l4', title: '细胞的生活'),
          TextbookLesson(id: 'l5', title: '细胞通过分裂产生新细胞'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '生物圈中的绿色植物', lessons: [
          TextbookLesson(id: 'l1', title: '藻类、苔藓和蕨类植物'),
          TextbookLesson(id: 'l2', title: '种子植物'),
          TextbookLesson(id: 'l3', title: '种子的萌发'),
          TextbookLesson(id: 'l4', title: '植株的生长'),
          TextbookLesson(id: 'l5', title: '开花和结果'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '绿色植物的生活方式', lessons: [
          TextbookLesson(id: 'l1', title: '光合作用'),
          TextbookLesson(id: 'l2', title: '植物的呼吸作用'),
          TextbookLesson(id: 'l3', title: '绿色植物与生物圈的水循环'),
          TextbookLesson(id: 'l4', title: '绿色植物是生物圈中有机物的制造者'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '绿色植物与生物圈', lessons: [
          TextbookLesson(id: 'l1', title: '绿色植物与生物圈的碳—氧平衡'),
          TextbookLesson(id: 'l2', title: '爱护植被，绿化祖国'),
        ]),
      ]),
      // ============= 七年级下册 (5 单元) =============
      TextbookSemester(id: '七下', name: '七年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第六单元', label: '生物圈中的人', lessons: [
          TextbookLesson(id: 'l1', title: '人类的起源和发展'),
          TextbookLesson(id: 'l2', title: '人的生殖'),
          TextbookLesson(id: 'l3', title: '青春期'),
        ]),
        TextbookUnit(id: 'u2', title: '第七单元', label: '人体的营养', lessons: [
          TextbookLesson(id: 'l1', title: '食物中的营养物质'),
          TextbookLesson(id: 'l2', title: '消化和吸收'),
          TextbookLesson(id: 'l3', title: '合理营养与食品安全'),
        ]),
        TextbookUnit(id: 'u3', title: '第八单元', label: '人体的呼吸', lessons: [
          TextbookLesson(id: 'l1', title: '呼吸道对空气的处理'),
          TextbookLesson(id: 'l2', title: '发生在肺内的气体交换'),
          TextbookLesson(id: 'l3', title: '空气质量与健康'),
        ]),
        TextbookUnit(id: 'u4', title: '第九单元', label: '人体内物质的运输', lessons: [
          TextbookLesson(id: 'l1', title: '血液'),
          TextbookLesson(id: 'l2', title: '血管'),
          TextbookLesson(id: 'l3', title: '心脏'),
          TextbookLesson(id: 'l4', title: '输血与血型'),
        ]),
        TextbookUnit(id: 'u5', title: '第十单元', label: '人体内废物的排出', lessons: [
          TextbookLesson(id: 'l1', title: '尿液的形成和排出'),
          TextbookLesson(id: 'l2', title: '人体皮肤的结构和功能'),
        ]),
      ]),
      // ============= 八年级上册 (5 单元) =============
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第十一单元', label: '生物圈中的其他生物', lessons: [
          TextbookLesson(id: 'l1', title: '无脊椎动物'),
          TextbookLesson(id: 'l2', title: '脊椎动物'),
          TextbookLesson(id: 'l3', title: '动物的运动'),
          TextbookLesson(id: 'l4', title: '动物的行为'),
        ]),
        TextbookUnit(id: 'u2', title: '第十二单元', label: '动物的运动和行为', lessons: [
          TextbookLesson(id: 'l1', title: '动物的运动依赖于一定的结构'),
          TextbookLesson(id: 'l2', title: '先天性行为和学习行为'),
          TextbookLesson(id: 'l3', title: '社会行为'),
        ]),
        TextbookUnit(id: 'u3', title: '第十三单元', label: '动物在生物圈中的作用', lessons: [
          TextbookLesson(id: 'l1', title: '动物在自然界中的作用'),
          TextbookLesson(id: 'l2', title: '动物与人类生活的关系'),
        ]),
        TextbookUnit(id: 'u4', title: '第十四单元', label: '分布广泛的细菌和真菌', lessons: [
          TextbookLesson(id: 'l1', title: '细菌和真菌的分布'),
          TextbookLesson(id: 'l2', title: '细菌'),
          TextbookLesson(id: 'l3', title: '真菌'),
        ]),
        TextbookUnit(id: 'u5', title: '第十五单元', label: '细菌和真菌在生物圈中的作用', lessons: [
          TextbookLesson(id: 'l1', title: '细菌和真菌在自然界中的作用'),
          TextbookLesson(id: 'l2', title: '人类对细菌和真菌的利用'),
        ]),
      ]),
      // ============= 八年级下册 (5 单元) =============
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第十六单元', label: '生物的多样性及其保护', lessons: [
          TextbookLesson(id: 'l1', title: '尝试对生物进行分类'),
          TextbookLesson(id: 'l2', title: '从种到界'),
          TextbookLesson(id: 'l3', title: '认识生物的多样性'),
          TextbookLesson(id: 'l4', title: '保护生物的多样性'),
        ]),
        TextbookUnit(id: 'u2', title: '第十七单元', label: '生物圈中生命的延续和发展', lessons: [
          TextbookLesson(id: 'l1', title: '植物的生殖'),
          TextbookLesson(id: 'l2', title: '昆虫的生殖和发育'),
          TextbookLesson(id: 'l3', title: '两栖动物的生殖和发育'),
          TextbookLesson(id: 'l4', title: '鸟的生殖和发育'),
        ]),
        TextbookUnit(id: 'u3', title: '第十八单元', label: '生命的进化', lessons: [
          TextbookLesson(id: 'l1', title: '地球上生命的起源'),
          TextbookLesson(id: 'l2', title: '生物进化的历程'),
          TextbookLesson(id: 'l3', title: '生物进化的原因'),
        ]),
        TextbookUnit(id: 'u4', title: '第十九单元', label: '传染病和免疫', lessons: [
          TextbookLesson(id: 'l1', title: '传染病及其预防'),
          TextbookLesson(id: 'l2', title: '免疫与计划免疫'),
          TextbookLesson(id: 'l3', title: '艾滋病'),
          TextbookLesson(id: 'l4', title: '用药与急救'),
        ]),
        TextbookUnit(id: 'u5', title: '第二十单元', label: '健康地生活', lessons: [
          TextbookLesson(id: 'l1', title: '评价自己的健康状况'),
          TextbookLesson(id: 'l2', title: '选择健康的生活方式'),
        ]),
      ]),
    ])];
  }

  // 高中生物 人教版(2019)
  return [TextbookVersion(id: '人教版', name: '人教版(2019版)', semesters: [
    // 必修一：分子与细胞
    TextbookSemester(id: '必修一', name: '必修第一册（分子与细胞）', label: '必修一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '走进细胞', lessons: [
        TextbookLesson(id: 'l1', title: '细胞是生命活动的基本单位'),
        TextbookLesson(id: 'l2', title: '细胞的多样性和统一性'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '组成细胞的分子', lessons: [
        TextbookLesson(id: 'l3', title: '细胞中的元素和化合物'),
        TextbookLesson(id: 'l4', title: '细胞中的无机物'),
        TextbookLesson(id: 'l5', title: '细胞中的糖类和脂质'),
        TextbookLesson(id: 'l6', title: '蛋白质是生命活动的主要承担者'),
        TextbookLesson(id: 'l7', title: '核酸是遗传信息的携带者'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '细胞的基本结构', lessons: [
        TextbookLesson(id: 'l8', title: '细胞膜——系统的边界'),
        TextbookLesson(id: 'l9', title: '细胞器——系统内的分工合作'),
        TextbookLesson(id: 'l10', title: '细胞核——系统的控制中心'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '细胞的物质输入和输出', lessons: [
        TextbookLesson(id: 'l11', title: '物质跨膜运输的实例'),
        TextbookLesson(id: 'l12', title: '生物膜的流动镶嵌模型'),
        TextbookLesson(id: 'l13', title: '物质跨膜运输的方式'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '细胞的能量供应和利用', lessons: [
        TextbookLesson(id: 'l14', title: '降低化学反应活化能的酶'),
        TextbookLesson(id: 'l15', title: '细胞的能量"通货"——ATP'),
        TextbookLesson(id: 'l16', title: 'ATP的主要来源——细胞呼吸'),
        TextbookLesson(id: 'l17', title: '能量之源——光与光合作用'),
      ]),
      TextbookUnit(id: 'u6', title: '第六章', label: '细胞的生命历程', lessons: [
        TextbookLesson(id: 'l18', title: '细胞的增殖'),
        TextbookLesson(id: 'l19', title: '细胞的分化'),
        TextbookLesson(id: 'l20', title: '细胞的衰老和凋亡'),
        TextbookLesson(id: 'l21', title: '细胞的癌变'),
      ]),
    ]),
    // 必修二：遗传与进化
    TextbookSemester(id: '必修二', name: '必修第二册（遗传与进化）', label: '必修二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '遗传因子的发现', lessons: [
        TextbookLesson(id: 'l1', title: '孟德尔的豌豆杂交实验（一）'),
        TextbookLesson(id: 'l2', title: '孟德尔的豌豆杂交实验（二）'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '基因和染色体的关系', lessons: [
        TextbookLesson(id: 'l3', title: '减数分裂和受精作用'),
        TextbookLesson(id: 'l4', title: '基因在染色体上'),
        TextbookLesson(id: 'l5', title: '伴性遗传'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '基因的本质', lessons: [
        TextbookLesson(id: 'l6', title: 'DNA是主要的遗传物质'),
        TextbookLesson(id: 'l7', title: 'DNA分子的结构'),
        TextbookLesson(id: 'l8', title: 'DNA的复制'),
        TextbookLesson(id: 'l9', title: '基因是有遗传效应的DNA片段'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '基因的表达', lessons: [
        TextbookLesson(id: 'l10', title: '基因指导蛋白质的合成'),
        TextbookLesson(id: 'l11', title: '基因表达与性状的关系'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '基因突变及其他变异', lessons: [
        TextbookLesson(id: 'l12', title: '基因突变和基因重组'),
        TextbookLesson(id: 'l13', title: '染色体变异'),
        TextbookLesson(id: 'l14', title: '人类遗传病'),
      ]),
      TextbookUnit(id: 'u6', title: '第六章', label: '生物的进化', lessons: [
        TextbookLesson(id: 'l15', title: '生物有共同祖先的证据'),
        TextbookLesson(id: 'l16', title: '自然选择与适应的形成'),
        TextbookLesson(id: 'l17', title: '种群基因组成的变化'),
        TextbookLesson(id: 'l18', title: '协同进化与生物多样性的形成'),
      ]),
    ]),
    // 选择性必修一：稳态与调节
    TextbookSemester(id: '选必一', name: '选择性必修一（稳态与调节）', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '人体的内环境与稳态', lessons: [
        TextbookLesson(id: 'l1', title: '细胞生活的环境'),
        TextbookLesson(id: 'l2', title: '内环境的稳态'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '神经调节', lessons: [
        TextbookLesson(id: 'l3', title: '神经调节的结构基础'),
        TextbookLesson(id: 'l4', title: '神经冲动的产生和传导'),
        TextbookLesson(id: 'l5', title: '人脑的高级功能'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '体液调节', lessons: [
        TextbookLesson(id: 'l6', title: '激素与内分泌系统'),
        TextbookLesson(id: 'l7', title: '激素调节的过程'),
        TextbookLesson(id: 'l8', title: '体液调节与神经调节的关系'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '免疫调节', lessons: [
        TextbookLesson(id: 'l9', title: '免疫系统的组成和功能'),
        TextbookLesson(id: 'l10', title: '特异性免疫'),
        TextbookLesson(id: 'l11', title: '免疫失调'),
        TextbookLesson(id: 'l12', title: '免疫学的应用'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '植物生命活动的调节', lessons: [
        TextbookLesson(id: 'l13', title: '植物生长素'),
        TextbookLesson(id: 'l14', title: '其他植物激素'),
        TextbookLesson(id: 'l15', title: '植物生长调节剂的应用'),
        TextbookLesson(id: 'l16', title: '环境因素参与调节植物的生命活动'),
      ]),
    ]),
    // 选择性必修二：生物与环境
    TextbookSemester(id: '选必二', name: '选择性必修二（生物与环境）', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '种群及其动态', lessons: [
        TextbookLesson(id: 'l1', title: '种群的特征'),
        TextbookLesson(id: 'l2', title: '种群密度的调查方法'),
        TextbookLesson(id: 'l3', title: '种群数量的变化'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '群落及其演替', lessons: [
        TextbookLesson(id: 'l4', title: '群落的结构'),
        TextbookLesson(id: 'l5', title: '群落的主要类型'),
        TextbookLesson(id: 'l6', title: '群落的演替'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '生态系统及其稳定性', lessons: [
        TextbookLesson(id: 'l7', title: '生态系统的结构'),
        TextbookLesson(id: 'l8', title: '生态系统的能量流动'),
        TextbookLesson(id: 'l9', title: '生态系统的物质循环'),
        TextbookLesson(id: 'l10', title: '生态系统的信息传递'),
        TextbookLesson(id: 'l11', title: '生态系统的稳定性'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '人与环境', lessons: [
        TextbookLesson(id: 'l12', title: '人类活动对生态环境的影响'),
        TextbookLesson(id: 'l13', title: '生物多样性及其保护'),
        TextbookLesson(id: 'l14', title: '生态工程'),
      ]),
    ]),
    // 选择性必修三：生物技术与工程
    TextbookSemester(id: '选必三', name: '选择性必修三（生物技术与工程）', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '发酵工程', lessons: [
        TextbookLesson(id: 'l1', title: '传统发酵技术的应用'),
        TextbookLesson(id: 'l2', title: '微生物的培养技术'),
        TextbookLesson(id: 'l3', title: '发酵工程及其应用'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '细胞工程', lessons: [
        TextbookLesson(id: 'l4', title: '植物细胞工程'),
        TextbookLesson(id: 'l5', title: '动物细胞工程'),
        TextbookLesson(id: 'l6', title: '干细胞的研究与应用'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '基因工程', lessons: [
        TextbookLesson(id: 'l7', title: '重组DNA技术的基本工具'),
        TextbookLesson(id: 'l8', title: '基因工程的基本操作程序'),
        TextbookLesson(id: 'l9', title: '基因工程的应用'),
        TextbookLesson(id: 'l10', title: '蛋白质工程'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '生物技术的安全性与伦理问题', lessons: [
        TextbookLesson(id: 'l11', title: '转基因产品的安全性'),
        TextbookLesson(id: 'l12', title: '克隆技术的伦理问题'),
        TextbookLesson(id: 'l13', title: '禁止生物武器'),
      ]),
    ]),
  ])];
}

// ============================================================
// 历史 — 部编版
// ============================================================

List<TextbookVersion> _getHistoryTextbooks(Grade grade) {
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '部编版', name: '部编版', semesters: [
      TextbookSemester(id: '七上', name: '七年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '史前时期：中国境内早期人类与文明的起源', lessons: [
          TextbookLesson(id: 'l1', title: '中国境内早期人类的代表——北京人'),
          TextbookLesson(id: 'l2', title: '原始农耕生活'),
          TextbookLesson(id: 'l3', title: '远古的传说'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '夏商周时期：早期国家与社会变革', lessons: [
          TextbookLesson(id: 'l4', title: '夏商周的更替'),
          TextbookLesson(id: 'l5', title: '青铜器与甲骨文'),
          TextbookLesson(id: 'l6', title: '动荡的春秋时期'),
          TextbookLesson(id: 'l7', title: '战国时期的社会变化'),
          TextbookLesson(id: 'l8', title: '百家争鸣'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '秦汉时期：统一多民族国家的建立和巩固', lessons: [
          TextbookLesson(id: 'l9', title: '秦统一中国'),
          TextbookLesson(id: 'l10', title: '秦末农民大起义'),
          TextbookLesson(id: 'l11', title: '西汉建立和文景之治'),
          TextbookLesson(id: 'l12', title: '汉武帝巩固大一统王朝'),
          TextbookLesson(id: 'l13', title: '东汉的兴衰'),
          TextbookLesson(id: 'l14', title: '沟通中外文明的丝绸之路'),
          TextbookLesson(id: 'l15', title: '两汉的科技和文化'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '三国两晋南北朝时期：政权分立与民族交融', lessons: [
          TextbookLesson(id: 'l16', title: '三国鼎立'),
          TextbookLesson(id: 'l17', title: '西晋的短暂统一和北方各族的内迁'),
          TextbookLesson(id: 'l18', title: '东晋南朝时期江南地区的开发'),
          TextbookLesson(id: 'l19', title: '北魏政治和北方民族大交融'),
          TextbookLesson(id: 'l20', title: '魏晋南北朝的科技与文化'),
        ]),
      ]),
      TextbookSemester(id: '七下', name: '七年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '隋唐时期：繁荣与开放的时代', lessons: [
          TextbookLesson(id: 'l1', title: '隋朝的统一与灭亡'),
          TextbookLesson(id: 'l2', title: '从贞观之治到开元盛世'),
          TextbookLesson(id: 'l3', title: '盛唐气象'),
          TextbookLesson(id: 'l4', title: '唐朝的中外文化交流'),
          TextbookLesson(id: 'l5', title: '安史之乱与唐朝衰亡'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '辽宋夏金元时期：民族关系发展和社会变化', lessons: [
          TextbookLesson(id: 'l6', title: '北宋的政治'),
          TextbookLesson(id: 'l7', title: '辽、西夏与北宋的并立'),
          TextbookLesson(id: 'l8', title: '金与南宋的对峙'),
          TextbookLesson(id: 'l9', title: '宋代经济的发展'),
          TextbookLesson(id: 'l10', title: '蒙古族的兴起与元朝的建立'),
          TextbookLesson(id: 'l11', title: '元朝的统治'),
          TextbookLesson(id: 'l12', title: '宋元时期的都市和文化'),
          TextbookLesson(id: 'l13', title: '宋元时期的科技与中外交通'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '明清时期：统一多民族国家的巩固与发展', lessons: [
          TextbookLesson(id: 'l14', title: '明朝的统治'),
          TextbookLesson(id: 'l15', title: '明朝的对外关系'),
          TextbookLesson(id: 'l16', title: '明朝的科技、建筑与文学'),
          TextbookLesson(id: 'l17', title: '明朝的灭亡'),
          TextbookLesson(id: 'l18', title: '统一多民族国家的巩固和发展'),
          TextbookLesson(id: 'l19', title: '清朝前期社会经济的发展'),
          TextbookLesson(id: 'l20', title: '清朝君主专制的强化'),
          TextbookLesson(id: 'l21', title: '清朝前期的文学艺术'),
        ]),
      ]),
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '中国开始沦为半殖民地半封建社会', lessons: [
          TextbookLesson(id: 'l1', title: '鸦片战争'),
          TextbookLesson(id: 'l2', title: '第二次鸦片战争'),
          TextbookLesson(id: 'l3', title: '太平天国运动'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '近代化的早期探索与民族危机的加剧', lessons: [
          TextbookLesson(id: 'l4', title: '洋务运动'),
          TextbookLesson(id: 'l5', title: '甲午中日战争与列强瓜分中国狂潮'),
          TextbookLesson(id: 'l6', title: '戊戌变法'),
          TextbookLesson(id: 'l7', title: '八国联军侵华与辛丑条约签订'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '资产阶级民主革命与中华民国的建立', lessons: [
          TextbookLesson(id: 'l8', title: '革命先行者孙中山'),
          TextbookLesson(id: 'l9', title: '辛亥革命'),
          TextbookLesson(id: 'l10', title: '中华民国的创建'),
          TextbookLesson(id: 'l11', title: '北洋政府的统治与军阀割据'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '新民主主义革命的开始', lessons: [
          TextbookLesson(id: 'l12', title: '新文化运动'),
          TextbookLesson(id: 'l13', title: '五四运动'),
          TextbookLesson(id: 'l14', title: '中国共产党诞生'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '从国共合作到国共对立', lessons: [
          TextbookLesson(id: 'l15', title: '北伐战争'),
          TextbookLesson(id: 'l16', title: '毛泽东开辟井冈山道路'),
          TextbookLesson(id: 'l17', title: '中国工农红军长征'),
        ]),
        TextbookUnit(id: 'u6', title: '第六单元', label: '中华民族的抗日战争', lessons: [
          TextbookLesson(id: 'l18', title: '从九一八事变到西安事变'),
          TextbookLesson(id: 'l19', title: '七七事变与全民族抗战'),
          TextbookLesson(id: 'l20', title: '正面战场的抗战'),
          TextbookLesson(id: 'l21', title: '敌后战场的抗战'),
          TextbookLesson(id: 'l22', title: '抗日战争的胜利'),
        ]),
        TextbookUnit(id: 'u7', title: '第七单元', label: '人民解放战争', lessons: [
          TextbookLesson(id: 'l23', title: '内战爆发'),
          TextbookLesson(id: 'l24', title: '人民解放战争的胜利'),
        ]),
        TextbookUnit(id: 'u8', title: '第八单元', label: '近代经济、社会生活与教育文化事业的发展', lessons: [
          TextbookLesson(id: 'l25', title: '经济和社会生活的变化'),
          TextbookLesson(id: 'l26', title: '教育文化事业的发展'),
        ]),
      ]),
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '中华人民共和国的成立和巩固', lessons: [
          TextbookLesson(id: 'l1', title: '中华人民共和国成立'),
          TextbookLesson(id: 'l2', title: '抗美援朝'),
          TextbookLesson(id: 'l3', title: '土地改革'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '社会主义制度的建立与社会主义建设的探索', lessons: [
          TextbookLesson(id: 'l4', title: '新中国工业化的起步和人民代表大会制度的确立'),
          TextbookLesson(id: 'l5', title: '三大改造'),
          TextbookLesson(id: 'l6', title: '艰辛探索与建设成就'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '中国特色社会主义道路', lessons: [
          TextbookLesson(id: 'l7', title: '伟大的历史转折'),
          TextbookLesson(id: 'l8', title: '经济体制改革'),
          TextbookLesson(id: 'l9', title: '对外开放'),
          TextbookLesson(id: 'l10', title: '建设中国特色社会主义'),
          TextbookLesson(id: 'l11', title: '为实现中国梦而努力奋斗'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '民族团结与祖国统一', lessons: [
          TextbookLesson(id: 'l12', title: '民族大团结'),
          TextbookLesson(id: 'l13', title: '香港和澳门的回归'),
          TextbookLesson(id: 'l14', title: '海峡两岸的交往'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '国防建设与外交成就', lessons: [
          TextbookLesson(id: 'l15', title: '钢铁长城'),
          TextbookLesson(id: 'l16', title: '独立自主的和平外交'),
          TextbookLesson(id: 'l17', title: '外交事业的发展'),
        ]),
        TextbookUnit(id: 'u6', title: '第六单元', label: '科技文化与社会生活', lessons: [
          TextbookLesson(id: 'l18', title: '科技文化成就'),
          TextbookLesson(id: 'l19', title: '社会生活的变迁'),
        ]),
      ]),
      TextbookSemester(id: '九上', name: '九年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '古代亚非文明', lessons: [
          TextbookLesson(id: 'l1', title: '古代埃及'),
          TextbookLesson(id: 'l2', title: '古代两河流域'),
          TextbookLesson(id: 'l3', title: '古代印度'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '古代欧洲文明', lessons: [
          TextbookLesson(id: 'l4', title: '希腊城邦和亚历山大帝国'),
          TextbookLesson(id: 'l5', title: '罗马城邦和罗马帝国'),
          TextbookLesson(id: 'l6', title: '希腊罗马古典文化'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '封建时代的欧洲', lessons: [
          TextbookLesson(id: 'l7', title: '基督教的兴起和法兰克王国'),
          TextbookLesson(id: 'l8', title: '西欧庄园'),
          TextbookLesson(id: 'l9', title: '中世纪城市和大学的兴起'),
          TextbookLesson(id: 'l10', title: '拜占庭帝国和查士丁尼法典'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '封建时代的亚洲国家', lessons: [
          TextbookLesson(id: 'l11', title: '古代日本'),
          TextbookLesson(id: 'l12', title: '阿拉伯帝国'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '步入近代', lessons: [
          TextbookLesson(id: 'l13', title: '西欧经济和社会的发展'),
          TextbookLesson(id: 'l14', title: '文艺复兴运动'),
          TextbookLesson(id: 'l15', title: '探寻新航路'),
          TextbookLesson(id: 'l16', title: '早期殖民掠夺'),
        ]),
        TextbookUnit(id: 'u6', title: '第六单元', label: '资本主义制度的初步确立', lessons: [
          TextbookLesson(id: 'l17', title: '君主立宪制的英国'),
          TextbookLesson(id: 'l18', title: '美国的独立'),
          TextbookLesson(id: 'l19', title: '法国大革命和拿破仑帝国'),
        ]),
        TextbookUnit(id: 'u7', title: '第七单元', label: '工业革命和国际共产主义运动的兴起', lessons: [
          TextbookLesson(id: 'l20', title: '第一次工业革命'),
          TextbookLesson(id: 'l21', title: '马克思主义的诞生和国际共产主义运动的兴起'),
        ]),
      ]),
      TextbookSemester(id: '九下', name: '九年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '殖民地人民的反抗与资本主义制度的扩展', lessons: [
          TextbookLesson(id: 'l1', title: '殖民地人民的反抗斗争'),
          TextbookLesson(id: 'l2', title: '俄国的改革'),
          TextbookLesson(id: 'l3', title: '美国内战'),
          TextbookLesson(id: 'l4', title: '日本明治维新'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '第二次工业革命和近代科学文化', lessons: [
          TextbookLesson(id: 'l5', title: '第二次工业革命'),
          TextbookLesson(id: 'l6', title: '工业化国家的社会变化'),
          TextbookLesson(id: 'l7', title: '近代科学与文化'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '第一次世界大战和战后初期的世界', lessons: [
          TextbookLesson(id: 'l8', title: '第一次世界大战'),
          TextbookLesson(id: 'l9', title: '列宁与十月革命'),
          TextbookLesson(id: 'l10', title: '凡尔赛条约和九国公约'),
          TextbookLesson(id: 'l11', title: '苏联的社会主义建设'),
          TextbookLesson(id: 'l12', title: '亚非拉民族民主运动的高涨'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '经济大危机和第二次世界大战', lessons: [
          TextbookLesson(id: 'l13', title: '罗斯福新政'),
          TextbookLesson(id: 'l14', title: '法西斯国家的侵略扩张'),
          TextbookLesson(id: 'l15', title: '第二次世界大战'),
        ]),
        TextbookUnit(id: 'u5', title: '第五单元', label: '二战后的世界变化', lessons: [
          TextbookLesson(id: 'l16', title: '冷战'),
          TextbookLesson(id: 'l17', title: '战后资本主义的新变化'),
          TextbookLesson(id: 'l18', title: '社会主义的发展与挫折'),
          TextbookLesson(id: 'l19', title: '亚非拉国家的新发展'),
        ]),
        TextbookUnit(id: 'u6', title: '第六单元', label: '走向和平发展的世界', lessons: [
          TextbookLesson(id: 'l20', title: '联合国与世界贸易组织'),
          TextbookLesson(id: 'l21', title: '冷战后的世界格局'),
          TextbookLesson(id: 'l22', title: '不断发展的现代社会'),
        ]),
      ]),
    ])];
  }
  // 高中历史 部编版(2019)
  return [TextbookVersion(id: '部编版', name: '部编版(2019版)', semesters: [
    TextbookSemester(id: '纲要上', name: '中外历史纲要（上）', label: '纲要上', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '从中华文明起源到秦汉统一多民族封建国家的建立与巩固', lessons: [
        TextbookLesson(id: 'l1', title: '中华文明的起源与早期国家'),
        TextbookLesson(id: 'l2', title: '诸侯纷争与变法运动'),
        TextbookLesson(id: 'l3', title: '秦统一多民族封建国家的建立'),
        TextbookLesson(id: 'l4', title: '西汉与东汉——统一多民族封建国家的巩固'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '三国两晋南北朝的民族交融与隋唐统一多民族封建国家的发展', lessons: [
        TextbookLesson(id: 'l5', title: '三国两晋南北朝的政权更迭与民族交融'),
        TextbookLesson(id: 'l6', title: '从隋唐盛世到五代十国'),
        TextbookLesson(id: 'l7', title: '隋唐制度的变化与创新'),
        TextbookLesson(id: 'l8', title: '三国至隋唐的文化'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '辽宋夏金多民族政权的并立与元朝的统一', lessons: [
        TextbookLesson(id: 'l9', title: '两宋的政治和军事'),
        TextbookLesson(id: 'l10', title: '辽夏金元的统治'),
        TextbookLesson(id: 'l11', title: '辽宋夏金元的经济与社会'),
        TextbookLesson(id: 'l12', title: '辽宋夏金元的文化'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '明清中国版图的奠定与面临的挑战', lessons: [
        TextbookLesson(id: 'l13', title: '从明朝建立到清军入关'),
        TextbookLesson(id: 'l14', title: '清朝前中期的鼎盛与危机'),
        TextbookLesson(id: 'l15', title: '明至清中叶的经济与文化'),
      ]),
      TextbookUnit(id: 'u5', title: '第五单元', label: '晚清时期的内忧外患与救亡图存', lessons: [
        TextbookLesson(id: 'l16', title: '两次鸦片战争'),
        TextbookLesson(id: 'l17', title: '国家出路的探索与列强侵略的加剧'),
        TextbookLesson(id: 'l18', title: '挽救民族危亡的斗争'),
      ]),
      TextbookUnit(id: 'u6', title: '第六单元', label: '辛亥革命与中华民国的建立', lessons: [
        TextbookLesson(id: 'l19', title: '辛亥革命'),
        TextbookLesson(id: 'l20', title: '北洋军阀统治时期的政治、经济与文化'),
      ]),
      TextbookUnit(id: 'u7', title: '第七单元', label: '中国共产党成立与新民主主义革命兴起', lessons: [
        TextbookLesson(id: 'l21', title: '五四运动与中国共产党的诞生'),
        TextbookLesson(id: 'l22', title: '南京国民政府的统治和中国共产党开辟革命新道路'),
      ]),
      TextbookUnit(id: 'u8', title: '第八单元', label: '中华民族的抗日战争和人民解放战争', lessons: [
        TextbookLesson(id: 'l23', title: '从局部抗战到全面抗战'),
        TextbookLesson(id: 'l24', title: '全民族浴血奋战与抗日战争的胜利'),
        TextbookLesson(id: 'l25', title: '人民解放战争'),
      ]),
      TextbookUnit(id: 'u9', title: '第九单元', label: '中华人民共和国的成立和社会主义革命与建设', lessons: [
        TextbookLesson(id: 'l26', title: '中华人民共和国成立和向社会主义的过渡'),
        TextbookLesson(id: 'l27', title: '社会主义建设在探索中曲折发展'),
      ]),
      TextbookUnit(id: 'u10', title: '第十单元', label: '改革开放与社会主义现代化建设新时期', lessons: [
        TextbookLesson(id: 'l28', title: '中国特色社会主义道路的开辟与发展'),
        TextbookLesson(id: 'l29', title: '改革开放以来的巨大成就'),
      ]),
    ]),
    TextbookSemester(id: '纲要下', name: '中外历史纲要（下）', label: '纲要下', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '古代文明的产生与发展', lessons: [
        TextbookLesson(id: 'l1', title: '文明的产生与早期发展'),
        TextbookLesson(id: 'l2', title: '古代世界的帝国与文明的交流'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '中古时期的世界', lessons: [
        TextbookLesson(id: 'l3', title: '中古时期的欧洲'),
        TextbookLesson(id: 'l4', title: '中古时期的亚洲'),
        TextbookLesson(id: 'l5', title: '古代非洲与美洲'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '走向整体的世界', lessons: [
        TextbookLesson(id: 'l6', title: '全球航路的开辟'),
        TextbookLesson(id: 'l7', title: '全球联系的初步建立与世界格局的演变'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '资本主义制度的确立', lessons: [
        TextbookLesson(id: 'l8', title: '欧洲的思想解放运动'),
        TextbookLesson(id: 'l9', title: '资产阶级革命与资本主义制度的确立'),
      ]),
      TextbookUnit(id: 'u5', title: '第五单元', label: '工业革命与马克思主义的诞生', lessons: [
        TextbookLesson(id: 'l10', title: '影响世界的工业革命'),
        TextbookLesson(id: 'l11', title: '马克思主义的诞生与传播'),
      ]),
      TextbookUnit(id: 'u6', title: '第六单元', label: '世界殖民体系与亚非拉民族独立运动', lessons: [
        TextbookLesson(id: 'l12', title: '资本主义世界殖民体系的形成'),
        TextbookLesson(id: 'l13', title: '亚非拉民族独立运动'),
      ]),
      TextbookUnit(id: 'u7', title: '第七单元', label: '世界大战、十月革命与国际秩序的演变', lessons: [
        TextbookLesson(id: 'l14', title: '第一次世界大战与战后国际秩序'),
        TextbookLesson(id: 'l15', title: '十月革命的胜利与苏联的社会主义实践'),
        TextbookLesson(id: 'l16', title: '亚非拉民族民主运动的高涨'),
        TextbookLesson(id: 'l17', title: '第二次世界大战与战后国际秩序的形成'),
      ]),
      TextbookUnit(id: 'u8', title: '第八单元', label: '20世纪下半叶世界的新变化', lessons: [
        TextbookLesson(id: 'l18', title: '冷战与国际格局的演变'),
        TextbookLesson(id: 'l19', title: '资本主义国家的新变化'),
        TextbookLesson(id: 'l20', title: '社会主义国家的发展与变化'),
        TextbookLesson(id: 'l21', title: '世界殖民体系的瓦解与新兴国家的发展'),
      ]),
      TextbookUnit(id: 'u9', title: '第九单元', label: '当代世界发展的特点与主要趋势', lessons: [
        TextbookLesson(id: 'l22', title: '世界多极化与经济全球化'),
        TextbookLesson(id: 'l23', title: '和平发展合作共赢的时代潮流'),
      ]),
    ]),
    TextbookSemester(id: '选必一', name: '选择性必修一', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '政治制度', lessons: [
        TextbookLesson(id: 'l1', title: '中国古代政治制度的形成与发展'),
        TextbookLesson(id: 'l2', title: '西方国家古代和近代政治制度的演变'),
        TextbookLesson(id: 'l3', title: '中国近代至当代政治制度的演变'),
        TextbookLesson(id: 'l4', title: '中国历代变法和改革'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '官员的选拔与管理', lessons: [
        TextbookLesson(id: 'l5', title: '中国古代官员的选拔与管理'),
        TextbookLesson(id: 'l6', title: '西方的文官制度'),
        TextbookLesson(id: 'l7', title: '近代以来中国的官员选拔与管理'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '法律与教化', lessons: [
        TextbookLesson(id: 'l8', title: '中国古代的法治与教化'),
        TextbookLesson(id: 'l9', title: '近代西方的法律与教化'),
        TextbookLesson(id: 'l10', title: '当代中国的法治与精神文明建设'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '民族关系与国家关系', lessons: [
        TextbookLesson(id: 'l11', title: '中国古代的民族关系与对外交往'),
        TextbookLesson(id: 'l12', title: '近代西方民族国家与国际法的发展'),
        TextbookLesson(id: 'l13', title: '当代中国的民族政策'),
        TextbookLesson(id: 'l14', title: '当代中国的外交'),
      ]),
      TextbookUnit(id: 'u5', title: '第五单元', label: '货币与赋税制度', lessons: [
        TextbookLesson(id: 'l15', title: '货币的使用与世界货币体系的形成'),
        TextbookLesson(id: 'l16', title: '中国赋税制度的演变'),
      ]),
      TextbookUnit(id: 'u6', title: '第六单元', label: '基层治理与社会保障', lessons: [
        TextbookLesson(id: 'l17', title: '中国古代的户籍制度与社会治理'),
        TextbookLesson(id: 'l18', title: '世界主要国家的基层治理与社会保障'),
      ]),
    ]),
    TextbookSemester(id: '选必二', name: '选择性必修二', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '食物生产与社会生活', lessons: [
        TextbookLesson(id: 'l1', title: '从食物采集到食物生产'),
        TextbookLesson(id: 'l2', title: '新航路开辟后的食物物种交流'),
        TextbookLesson(id: 'l3', title: '现代食物的生产、储备与食品安全'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '生产工具与劳作方式', lessons: [
        TextbookLesson(id: 'l4', title: '古代的生产工具与劳作'),
        TextbookLesson(id: 'l5', title: '工业革命与工厂制度'),
        TextbookLesson(id: 'l6', title: '现代科技进步与人类社会发展'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '商业贸易与日常生活', lessons: [
        TextbookLesson(id: 'l7', title: '古代的商业贸易'),
        TextbookLesson(id: 'l8', title: '世界市场与商业贸易'),
        TextbookLesson(id: 'l9', title: '20世纪以来人类的经济与生活'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '村落、城镇与居住环境', lessons: [
        TextbookLesson(id: 'l10', title: '古代的村落、集镇和城市'),
        TextbookLesson(id: 'l11', title: '近代以来的城市化进程'),
      ]),
      TextbookUnit(id: 'u5', title: '第五单元', label: '交通与社会变迁', lessons: [
        TextbookLesson(id: 'l12', title: '水陆交通的变迁'),
        TextbookLesson(id: 'l13', title: '现代交通运输的新变化'),
      ]),
      TextbookUnit(id: 'u6', title: '第六单元', label: '医疗与公共卫生', lessons: [
        TextbookLesson(id: 'l14', title: '历史上的疫病与医学成就'),
        TextbookLesson(id: 'l15', title: '现代医疗卫生体系与社会生活'),
      ]),
    ]),
    TextbookSemester(id: '选必三', name: '选择性必修三', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '源远流长的中华文化', lessons: [
        TextbookLesson(id: 'l1', title: '中华优秀传统文化的内涵与特点'),
        TextbookLesson(id: 'l2', title: '中华文化的世界意义'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '丰富多样的世界文化', lessons: [
        TextbookLesson(id: 'l3', title: '古代西亚、非洲文化'),
        TextbookLesson(id: 'l4', title: '欧洲文化的形成'),
        TextbookLesson(id: 'l5', title: '南亚、东亚与美洲的文化'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '人口迁徙、文化交融与认同', lessons: [
        TextbookLesson(id: 'l6', title: '古代人类的迁徙和区域文化的形成'),
        TextbookLesson(id: 'l7', title: '近代殖民活动和人口的跨地域转移'),
        TextbookLesson(id: 'l8', title: '现代社会的移民和多元文化'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '商路、贸易与文化交流', lessons: [
        TextbookLesson(id: 'l9', title: '古代的商路、贸易与文化交流'),
        TextbookLesson(id: 'l10', title: '近代以来的世界贸易与文化交流的扩展'),
      ]),
      TextbookUnit(id: 'u5', title: '第五单元', label: '战争与文化交锋', lessons: [
        TextbookLesson(id: 'l11', title: '古代战争与地域文化的演变'),
        TextbookLesson(id: 'l12', title: '近代战争与西方文化的扩张'),
        TextbookLesson(id: 'l13', title: '现代战争与不同文化的碰撞和交流'),
      ]),
      TextbookUnit(id: 'u6', title: '第六单元', label: '文化的传承与保护', lessons: [
        TextbookLesson(id: 'l14', title: '文化传承的多种载体及其发展'),
        TextbookLesson(id: 'l15', title: '文化遗产：全人类共同的财富'),
      ]),
    ]),
  ])];
}

// ============================================================
// 地理 — 人教版
// ============================================================

List<TextbookVersion> _getGeographyTextbooks(Grade grade) {
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '人教版', name: '人教版', semesters: [
      // 七年级上册
      TextbookSemester(id: '七上', name: '七年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一章', label: '地球和地图', lessons: [
          TextbookLesson(id: 'l1', title: '地球和地球仪'),
          TextbookLesson(id: 'l2', title: '地球的运动'),
          TextbookLesson(id: 'l3', title: '地图的阅读'),
          TextbookLesson(id: 'l4', title: '地形图的判读'),
        ]),
        TextbookUnit(id: 'u2', title: '第二章', label: '大洲和大洋', lessons: [
          TextbookLesson(id: 'l5', title: '大洲和大洋'),
          TextbookLesson(id: 'l6', title: '海陆的变迁'),
        ]),
        TextbookUnit(id: 'u3', title: '第三章', label: '天气与气候', lessons: [
          TextbookLesson(id: 'l7', title: '多变的天气'),
          TextbookLesson(id: 'l8', title: '气温的变化与分布'),
          TextbookLesson(id: 'l9', title: '降水的变化与分布'),
          TextbookLesson(id: 'l10', title: '世界的气候'),
          TextbookLesson(id: 'l11', title: '世界的聚落'),
        ]),
        TextbookUnit(id: 'u4', title: '第四章', label: '居民与聚落', lessons: [
          TextbookLesson(id: 'l12', title: '人口与人种'),
          TextbookLesson(id: 'l13', title: '世界的语言和宗教'),
          TextbookLesson(id: 'l14', title: '人类的居住地——聚落'),
        ]),
        TextbookUnit(id: 'u5', title: '第五章', label: '发展与合作', lessons: [
          TextbookLesson(id: 'l15', title: '发展与合作'),
        ]),
      ]),
      // 七年级下册
      TextbookSemester(id: '七下', name: '七年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第六章', label: '我们生活的大洲——亚洲', lessons: [
          TextbookLesson(id: 'l1', title: '位置和范围'),
          TextbookLesson(id: 'l2', title: '自然环境'),
          TextbookLesson(id: 'l3', title: '人文环境'),
        ]),
        TextbookUnit(id: 'u2', title: '第七章', label: '我们邻近的国家和地区', lessons: [
          TextbookLesson(id: 'l4', title: '日本'),
          TextbookLesson(id: 'l5', title: '东南亚'),
          TextbookLesson(id: 'l6', title: '印度'),
          TextbookLesson(id: 'l7', title: '俄罗斯'),
        ]),
        TextbookUnit(id: 'u3', title: '第八章', label: '东半球其他的地区和国家', lessons: [
          TextbookLesson(id: 'l8', title: '中东'),
          TextbookLesson(id: 'l9', title: '欧洲西部'),
          TextbookLesson(id: 'l10', title: '撒哈拉以南的非洲'),
          TextbookLesson(id: 'l11', title: '澳大利亚'),
        ]),
        TextbookUnit(id: 'u4', title: '第九章', label: '西半球的国家', lessons: [
          TextbookLesson(id: 'l12', title: '美国'),
          TextbookLesson(id: 'l13', title: '巴西'),
        ]),
        TextbookUnit(id: 'u5', title: '第十章', label: '极地地区', lessons: [
          TextbookLesson(id: 'l14', title: '极地地区'),
        ]),
      ]),
      // 八年级上册
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一章', label: '从世界看中国', lessons: [
          TextbookLesson(id: 'l1', title: '疆域'),
          TextbookLesson(id: 'l2', title: '人口'),
          TextbookLesson(id: 'l3', title: '民族'),
        ]),
        TextbookUnit(id: 'u2', title: '第二章', label: '中国的自然环境', lessons: [
          TextbookLesson(id: 'l4', title: '地形和地势'),
          TextbookLesson(id: 'l5', title: '气候'),
          TextbookLesson(id: 'l6', title: '河流'),
          TextbookLesson(id: 'l7', title: '自然灾害'),
        ]),
        TextbookUnit(id: 'u3', title: '第三章', label: '中国的自然资源', lessons: [
          TextbookLesson(id: 'l8', title: '自然资源的基本特征'),
          TextbookLesson(id: 'l9', title: '土地资源'),
          TextbookLesson(id: 'l10', title: '水资源'),
        ]),
        TextbookUnit(id: 'u4', title: '第四章', label: '中国经济的发展', lessons: [
          TextbookLesson(id: 'l11', title: '交通运输'),
          TextbookLesson(id: 'l12', title: '农业'),
          TextbookLesson(id: 'l13', title: '工业'),
        ]),
      ]),
      // 八年级下册
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第五章', label: '中国的地理差异', lessons: [
          TextbookLesson(id: 'l1', title: '四大地理区域的划分'),
          TextbookLesson(id: 'l2', title: '北方地区和南方地区'),
          TextbookLesson(id: 'l3', title: '西北地区和青藏地区'),
        ]),
        TextbookUnit(id: 'u2', title: '第六章', label: '北方地区', lessons: [
          TextbookLesson(id: 'l4', title: '自然特征与农业'),
          TextbookLesson(id: 'l5', title: '"白山黑水"——东北三省'),
          TextbookLesson(id: 'l6', title: '世界最大的黄土堆积区——黄土高原'),
          TextbookLesson(id: 'l7', title: '祖国的首都——北京'),
        ]),
        TextbookUnit(id: 'u3', title: '第七章', label: '南方地区', lessons: [
          TextbookLesson(id: 'l8', title: '自然特征与农业'),
          TextbookLesson(id: 'l9', title: '"鱼米之乡"——长江三角洲地区'),
          TextbookLesson(id: 'l10', title: '"东方明珠"——香港和澳门'),
          TextbookLesson(id: 'l11', title: '祖国的神圣领土——台湾省'),
        ]),
        TextbookUnit(id: 'u4', title: '第八章', label: '西北地区', lessons: [
          TextbookLesson(id: 'l12', title: '自然特征与农业'),
          TextbookLesson(id: 'l13', title: '干旱的宝地——塔里木盆地'),
        ]),
        TextbookUnit(id: 'u5', title: '第九章', label: '青藏地区', lessons: [
          TextbookLesson(id: 'l14', title: '自然特征与农业'),
          TextbookLesson(id: 'l15', title: '高原湿地——三江源地区'),
        ]),
        TextbookUnit(id: 'u6', title: '第十章', label: '中国在世界中', lessons: [
          TextbookLesson(id: 'l16', title: '中国在世界中'),
        ]),
      ]),
    ])];
  }

  // 高中地理 人教版(2019)
  return [TextbookVersion(id: '人教版', name: '人教版(2019版)', semesters: [
    // 必修第一册
    TextbookSemester(id: '必修一', name: '必修第一册', label: '必修一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '宇宙中的地球', lessons: [
        TextbookLesson(id: 'l1', title: '地球的宇宙环境'),
        TextbookLesson(id: 'l2', title: '太阳对地球的影响'),
        TextbookLesson(id: 'l3', title: '地球的历史'),
        TextbookLesson(id: 'l4', title: '地球的圈层结构'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '地球上的大气', lessons: [
        TextbookLesson(id: 'l5', title: '大气的组成与垂直分层'),
        TextbookLesson(id: 'l6', title: '大气受热过程和大气运动'),
        TextbookLesson(id: 'l7', title: '大气环流'),
        TextbookLesson(id: 'l8', title: '常见天气系统'),
        TextbookLesson(id: 'l9', title: '气压带和风带对气候的影响'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '地球上的水', lessons: [
        TextbookLesson(id: 'l10', title: '水循环'),
        TextbookLesson(id: 'l11', title: '海水的性质'),
        TextbookLesson(id: 'l12', title: '海水的运动'),
        TextbookLesson(id: 'l13', title: '海—气相互作用及其影响'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '地貌', lessons: [
        TextbookLesson(id: 'l14', title: '常见地貌类型'),
        TextbookLesson(id: 'l15', title: '地貌的观察'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '植被与土壤', lessons: [
        TextbookLesson(id: 'l16', title: '植被'),
        TextbookLesson(id: 'l17', title: '土壤'),
      ]),
      TextbookUnit(id: 'u6', title: '第六章', label: '自然灾害', lessons: [
        TextbookLesson(id: 'l18', title: '气象灾害'),
        TextbookLesson(id: 'l19', title: '地质灾害'),
        TextbookLesson(id: 'l20', title: '防灾减灾'),
        TextbookLesson(id: 'l21', title: '地理信息技术在防灾减灾中的应用'),
      ]),
    ]),
    // 必修第二册
    TextbookSemester(id: '必修二', name: '必修第二册', label: '必修二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '人口', lessons: [
        TextbookLesson(id: 'l1', title: '人口分布'),
        TextbookLesson(id: 'l2', title: '人口迁移'),
        TextbookLesson(id: 'l3', title: '人口容量'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '乡村和城镇', lessons: [
        TextbookLesson(id: 'l4', title: '乡村和城镇空间结构'),
        TextbookLesson(id: 'l5', title: '城镇化'),
        TextbookLesson(id: 'l6', title: '地域文化与城乡景观'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '产业区位因素', lessons: [
        TextbookLesson(id: 'l7', title: '农业区位因素及其变化'),
        TextbookLesson(id: 'l8', title: '工业区位因素及其变化'),
        TextbookLesson(id: 'l9', title: '服务业区位因素及其变化'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '区域发展', lessons: [
        TextbookLesson(id: 'l10', title: '区域交通运输布局'),
        TextbookLesson(id: 'l11', title: '我国区域发展战略'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '人地关系与环境问题', lessons: [
        TextbookLesson(id: 'l12', title: '人类面临的主要环境问题'),
        TextbookLesson(id: 'l13', title: '可持续发展'),
      ]),
    ]),
    // 选择性必修一：自然地理基础
    TextbookSemester(id: '选必一', name: '选择性必修一（自然地理基础）', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '地球的运动', lessons: [
        TextbookLesson(id: 'l1', title: '地球的自转和公转'),
        TextbookLesson(id: 'l2', title: '地球运动的地理意义'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '地表形态的塑造', lessons: [
        TextbookLesson(id: 'l3', title: '岩石圈的物质循环'),
        TextbookLesson(id: 'l4', title: '构造地貌的形成'),
        TextbookLesson(id: 'l5', title: '河流地貌的发育'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '大气的运动', lessons: [
        TextbookLesson(id: 'l6', title: '常见天气系统'),
        TextbookLesson(id: 'l7', title: '气压带和风带'),
        TextbookLesson(id: 'l8', title: '气候类型的形成与变化'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '水的运动', lessons: [
        TextbookLesson(id: 'l9', title: '水循环及其地理意义'),
        TextbookLesson(id: 'l10', title: '洋流及其地理意义'),
        TextbookLesson(id: 'l11', title: '水资源及其利用'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '自然环境的整体性与差异性', lessons: [
        TextbookLesson(id: 'l12', title: '自然环境的整体性'),
        TextbookLesson(id: 'l13', title: '自然环境的地域分异规律'),
      ]),
    ]),
    // 选择性必修二：区域发展
    TextbookSemester(id: '选必二', name: '选择性必修二（区域发展）', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '认识区域', lessons: [
        TextbookLesson(id: 'l1', title: '区域的含义与类型'),
        TextbookLesson(id: 'l2', title: '区域特征与区域划分'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '区域发展', lessons: [
        TextbookLesson(id: 'l3', title: '区域发展阶段与产业结构'),
        TextbookLesson(id: 'l4', title: '区域协调发展'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '区域生态环境建设', lessons: [
        TextbookLesson(id: 'l5', title: '荒漠化的防治——以我国西北地区为例'),
        TextbookLesson(id: 'l6', title: '森林的开发和保护——以亚马孙热带雨林为例'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '区域自然资源综合开发利用', lessons: [
        TextbookLesson(id: 'l7', title: '能源资源的开发——以我国山西省为例'),
        TextbookLesson(id: 'l8', title: '河流的综合开发——以美国田纳西河流域为例'),
      ]),
      TextbookUnit(id: 'u5', title: '第五章', label: '区域可持续发展', lessons: [
        TextbookLesson(id: 'l9', title: '区域工业化与城市化——以我国珠江三角洲地区为例'),
        TextbookLesson(id: 'l10', title: '资源的跨区域调配——以我国西气东输为例'),
      ]),
    ]),
    // 选择性必修三：资源、环境与国家安全
    TextbookSemester(id: '选必三', name: '选择性必修三（资源、环境与国家安全）', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一章', label: '自然环境与人类社会', lessons: [
        TextbookLesson(id: 'l1', title: '自然环境的服务功能'),
        TextbookLesson(id: 'l2', title: '自然资源及其利用'),
      ]),
      TextbookUnit(id: 'u2', title: '第二章', label: '资源安全与国家安全', lessons: [
        TextbookLesson(id: 'l3', title: '资源安全对国家安全的影响'),
        TextbookLesson(id: 'l4', title: '保障国家资源安全'),
      ]),
      TextbookUnit(id: 'u3', title: '第三章', label: '环境安全与国家安全', lessons: [
        TextbookLesson(id: 'l5', title: '环境问题及其危害'),
        TextbookLesson(id: 'l6', title: '环境污染与国家安全'),
        TextbookLesson(id: 'l7', title: '生态破坏与国家安全'),
      ]),
      TextbookUnit(id: 'u4', title: '第四章', label: '保障国家安全的战略与措施', lessons: [
        TextbookLesson(id: 'l8', title: '走向生态文明'),
        TextbookLesson(id: 'l9', title: '国家安全的战略与措施'),
      ]),
    ]),
  ])];
}

// ============================================================
// 道德与法治 / 政治 — 部编版
// ============================================================

List<TextbookVersion> _getMoralityPoliticsTextbooks(Grade grade) {
    // 小学道德与法治 — 部编版（12学期）
  if (grade == Grade.primary) {
    return [TextbookVersion(id: '部编版', name: '部编版（道德与法治）', semesters: [
      // 一年级上册
      TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我是小学生啦', lessons: [
          TextbookLesson(id: 'l1', title: '开开心心上学去'),
          TextbookLesson(id: 'l2', title: '拉拉手交朋友'),
          TextbookLesson(id: 'l3', title: '我认识您了'),
          TextbookLesson(id: 'l4', title: '上学路上'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '校园生活真快乐', lessons: [
          TextbookLesson(id: 'l5', title: '我们的校园'),
          TextbookLesson(id: 'l6', title: '校园里的号令'),
          TextbookLesson(id: 'l7', title: '课间十分钟'),
          TextbookLesson(id: 'l8', title: '上课了'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '家中的安全与健康', lessons: [
          TextbookLesson(id: 'l9', title: '玩得真开心'),
          TextbookLesson(id: 'l10', title: '吃饭有讲究'),
          TextbookLesson(id: 'l11', title: '别伤着自己'),
          TextbookLesson(id: 'l12', title: '早睡早起'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '天气虽冷有温暖', lessons: [
          TextbookLesson(id: 'l13', title: '美丽的冬天'),
          TextbookLesson(id: 'l14', title: '健康过冬天'),
          TextbookLesson(id: 'l15', title: '快乐过新年'),
          TextbookLesson(id: 'l16', title: '新年的礼物'),
        ]),
      ]),
      // 一年级下册
      TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我的好习惯', lessons: [
          TextbookLesson(id: 'l1', title: '我们爱整洁'),
          TextbookLesson(id: 'l2', title: '我们有精神'),
          TextbookLesson(id: 'l3', title: '我不拖拉'),
          TextbookLesson(id: 'l4', title: '不做小马虎'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我和大自然', lessons: [
          TextbookLesson(id: 'l5', title: '风儿轻轻吹'),
          TextbookLesson(id: 'l6', title: '花儿草儿真美丽'),
          TextbookLesson(id: 'l7', title: '可爱的动物'),
          TextbookLesson(id: 'l8', title: '大自然谢谢您'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我爱我家', lessons: [
          TextbookLesson(id: 'l9', title: '我和我的家'),
          TextbookLesson(id: 'l10', title: '家人的爱'),
          TextbookLesson(id: 'l11', title: '让我自己来整理'),
          TextbookLesson(id: 'l12', title: '干点家务活'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '我们在一起', lessons: [
          TextbookLesson(id: 'l13', title: '我想和你们一起玩'),
          TextbookLesson(id: 'l14', title: '请帮我一下吧'),
          TextbookLesson(id: 'l15', title: '分享真快乐'),
          TextbookLesson(id: 'l16', title: '大家一起来'),
        ]),
      ]),
      // 二年级上册
      TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们的节假日', lessons: [
          TextbookLesson(id: 'l1', title: '假期有收获'),
          TextbookLesson(id: 'l2', title: '周末巧安排'),
          TextbookLesson(id: 'l3', title: '欢欢喜喜庆国庆'),
          TextbookLesson(id: 'l4', title: '团团圆圆过中秋'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们的班级', lessons: [
          TextbookLesson(id: 'l5', title: '我爱我们班'),
          TextbookLesson(id: 'l6', title: '班级生活有规则'),
          TextbookLesson(id: 'l7', title: '我是班级值日生'),
          TextbookLesson(id: 'l8', title: '装扮我们的教室'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们在公共场所', lessons: [
          TextbookLesson(id: 'l9', title: '这些是大家的'),
          TextbookLesson(id: 'l10', title: '我们不乱扔'),
          TextbookLesson(id: 'l11', title: '大家排好队'),
          TextbookLesson(id: 'l12', title: '我们小点儿声'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '我们生活的地方', lessons: [
          TextbookLesson(id: 'l13', title: '我爱家乡山和水'),
          TextbookLesson(id: 'l14', title: '家乡物产养育我'),
          TextbookLesson(id: 'l15', title: '家乡新变化'),
          TextbookLesson(id: 'l16', title: '可亲可敬的家乡人'),
        ]),
      ]),
      // 二年级下册
      TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '让我试试看', lessons: [
          TextbookLesson(id: 'l1', title: '挑战第一次'),
          TextbookLesson(id: 'l2', title: '学做快乐鸟'),
          TextbookLesson(id: 'l3', title: '做个开心果'),
          TextbookLesson(id: 'l4', title: '试种一粒籽'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们好好玩', lessons: [
          TextbookLesson(id: 'l5', title: '健康游戏我常玩'),
          TextbookLesson(id: 'l6', title: '传统游戏我会玩'),
          TextbookLesson(id: 'l7', title: '我们有新玩法'),
          TextbookLesson(id: 'l8', title: '安全地玩'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '绿色小卫士', lessons: [
          TextbookLesson(id: 'l9', title: '小水滴的诉说'),
          TextbookLesson(id: 'l10', title: '清新空气是个宝'),
          TextbookLesson(id: 'l11', title: '我是一张纸'),
          TextbookLesson(id: 'l12', title: '我的环保小搭档'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '我会努力的', lessons: [
          TextbookLesson(id: 'l13', title: '我能行'),
          TextbookLesson(id: 'l14', title: '学习有方法'),
          TextbookLesson(id: 'l15', title: '坚持才会有收获'),
          TextbookLesson(id: 'l16', title: '奖励一下自己'),
        ]),
      ]),
      // 三年级上册
      TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '快乐学习', lessons: [
          TextbookLesson(id: 'l1', title: '学习伴我成长'),
          TextbookLesson(id: 'l2', title: '我学习我快乐'),
          TextbookLesson(id: 'l3', title: '做学习的主人'),
          TextbookLesson(id: 'l4', title: '说说我们的学校'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们的学校', lessons: [
          TextbookLesson(id: 'l5', title: '说说我们的学校'),
          TextbookLesson(id: 'l6', title: '走近我们的老师'),
          TextbookLesson(id: 'l7', title: '让我们的学校更美好'),
          TextbookLesson(id: 'l8', title: '心中的一百一十'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '安全护我成长', lessons: [
          TextbookLesson(id: 'l9', title: '生命最宝贵'),
          TextbookLesson(id: 'l10', title: '安全记心上'),
          TextbookLesson(id: 'l11', title: '心中的一百一十九'),
          TextbookLesson(id: 'l12', title: '关爱生命'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '家是最温暖的地方', lessons: [
          TextbookLesson(id: 'l13', title: '父母多爱我'),
          TextbookLesson(id: 'l14', title: '爸爸妈妈在我心中'),
          TextbookLesson(id: 'l15', title: '家庭的记忆'),
          TextbookLesson(id: 'l16', title: '传统节日中的家'),
        ]),
      ]),
      // 三年级下册
      TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我和我的同伴', lessons: [
          TextbookLesson(id: 'l1', title: '我是独特的'),
          TextbookLesson(id: 'l2', title: '不一样的你我他'),
          TextbookLesson(id: 'l3', title: '我很诚实'),
          TextbookLesson(id: 'l4', title: '同学相伴'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我在这里长大', lessons: [
          TextbookLesson(id: 'l5', title: '我的家在这里'),
          TextbookLesson(id: 'l6', title: '请到我的家乡来'),
          TextbookLesson(id: 'l7', title: '邻里间的温暖'),
          TextbookLesson(id: 'l8', title: '家乡的喜与忧'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的公共生活', lessons: [
          TextbookLesson(id: 'l9', title: '大家的老师'),
          TextbookLesson(id: 'l10', title: '生活离不开规则'),
          TextbookLesson(id: 'l11', title: '爱心的传递者'),
          TextbookLesson(id: 'l12', title: '四通八达的交通'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '多样的交通和通信', lessons: [
          TextbookLesson(id: 'l13', title: '四通八达的交通'),
          TextbookLesson(id: 'l14', title: '慧眼看交通'),
          TextbookLesson(id: 'l15', title: '万里一线牵'),
          TextbookLesson(id: 'l16', title: '网络新世界'),
        ]),
      ]),
      // 四年级上册
      TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '与班级共成长', lessons: [
          TextbookLesson(id: 'l1', title: '我们的班规我们订'),
          TextbookLesson(id: 'l2', title: '我们班四岁了'),
          TextbookLesson(id: 'l3', title: '我们的班徽'),
          TextbookLesson(id: 'l4', title: '我们的班集体'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '为父母分担', lessons: [
          TextbookLesson(id: 'l5', title: '少让父母为我操心'),
          TextbookLesson(id: 'l6', title: '这些事我来做'),
          TextbookLesson(id: 'l7', title: '我的家庭贡献'),
          TextbookLesson(id: 'l8', title: '与家务活签约'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '信息万花筒', lessons: [
          TextbookLesson(id: 'l9', title: '健康看电视'),
          TextbookLesson(id: 'l10', title: '网络新世界'),
          TextbookLesson(id: 'l11', title: '正确认识广告'),
          TextbookLesson(id: 'l12', title: '神奇的宝盒'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '让生活多一些绿色', lessons: [
          TextbookLesson(id: 'l13', title: '暴增的垃圾'),
          TextbookLesson(id: 'l14', title: '减少垃圾变废为宝'),
          TextbookLesson(id: 'l15', title: '低碳生活每一天'),
          TextbookLesson(id: 'l16', title: '我们所了解的环境污染'),
        ]),
      ]),
      // 四年级下册
      TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '同伴与交往', lessons: [
          TextbookLesson(id: 'l1', title: '我们的好朋友'),
          TextbookLesson(id: 'l2', title: '说话要算数'),
          TextbookLesson(id: 'l3', title: '当冲突发生'),
          TextbookLesson(id: 'l4', title: '遇到欺负怎么办'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '做聪明的消费者', lessons: [
          TextbookLesson(id: 'l5', title: '买东西的学问'),
          TextbookLesson(id: 'l6', title: '合理消费'),
          TextbookLesson(id: 'l7', title: '有多少浪费本可避免'),
          TextbookLesson(id: 'l8', title: '维权意识不能少'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '美好生活哪里来', lessons: [
          TextbookLesson(id: 'l9', title: '我们的衣食之源'),
          TextbookLesson(id: 'l10', title: '这些东西哪里来'),
          TextbookLesson(id: 'l11', title: '生活离不开他们'),
          TextbookLesson(id: 'l12', title: '感谢他们的劳动'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '感受家乡文化', lessons: [
          TextbookLesson(id: 'l13', title: '风俗的演变'),
          TextbookLesson(id: 'l14', title: '多姿多彩的民间艺术'),
          TextbookLesson(id: 'l15', title: '家乡的喜与忧'),
          TextbookLesson(id: 'l16', title: '我们当地的风俗'),
        ]),
      ]),
      // 五年级上册
      TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '面对成长中的新问题', lessons: [
          TextbookLesson(id: 'l1', title: '自主选择课余生活'),
          TextbookLesson(id: 'l2', title: '学会沟通交流'),
          TextbookLesson(id: 'l3', title: '主动拒绝烟酒与毒品'),
          TextbookLesson(id: 'l4', title: '合理消费'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们是班级的主人', lessons: [
          TextbookLesson(id: 'l5', title: '选举产生班委会'),
          TextbookLesson(id: 'l6', title: '协商决定班级事务'),
          TextbookLesson(id: 'l7', title: '我们的班规'),
          TextbookLesson(id: 'l8', title: '集体的事情大家做'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的国土我们的家园', lessons: [
          TextbookLesson(id: 'l9', title: '我们神圣的国土'),
          TextbookLesson(id: 'l10', title: '中华民族一家亲'),
          TextbookLesson(id: 'l11', title: '好山好水好风光'),
          TextbookLesson(id: 'l12', title: '一方水土养一方人'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '骄人祖先灿烂文化', lessons: [
          TextbookLesson(id: 'l13', title: '美丽文字民族瑰宝'),
          TextbookLesson(id: 'l14', title: '古代科技耀我中华'),
          TextbookLesson(id: 'l15', title: '传统美德源远流长'),
          TextbookLesson(id: 'l16', title: '天下兴亡匹夫有责'),
        ]),
      ]),
      // 五年级下册
      TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们一家人', lessons: [
          TextbookLesson(id: 'l1', title: '读懂彼此的心'),
          TextbookLesson(id: 'l2', title: '让我们的家更美好'),
          TextbookLesson(id: 'l3', title: '弘扬优秀家风'),
          TextbookLesson(id: 'l4', title: '我是小小当家人'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '公共生活靠大家', lessons: [
          TextbookLesson(id: 'l5', title: '我们的公共生活'),
          TextbookLesson(id: 'l6', title: '建立良好的公共秩序'),
          TextbookLesson(id: 'l7', title: '我参与我奉献'),
          TextbookLesson(id: 'l8', title: '参与公益'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '百年追梦复兴中华', lessons: [
          TextbookLesson(id: 'l9', title: '不甘屈辱奋勇抗争'),
          TextbookLesson(id: 'l10', title: '推翻帝制民族觉醒'),
          TextbookLesson(id: 'l11', title: '中国有了共产党'),
          TextbookLesson(id: 'l12', title: '夺取抗日战争和人民解放战争的胜利'),
          TextbookLesson(id: 'l13', title: '屹立在世界的东方'),
          TextbookLesson(id: 'l14', title: '富起来到强起来'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '多样的文明丰富多彩的生活', lessons: [
          TextbookLesson(id: 'l15', title: '我们这里的民间艺术'),
          TextbookLesson(id: 'l16', title: '多姿多彩的民间艺术'),
          TextbookLesson(id: 'l17', title: '探访古代文明'),
          TextbookLesson(id: 'l18', title: '闻名世界的文化遗产'),
        ]),
      ]),
      // 六年级上册
      TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们的守护者', lessons: [
          TextbookLesson(id: 'l1', title: '感受生活中的法律'),
          TextbookLesson(id: 'l2', title: '宪法是根本法'),
          TextbookLesson(id: 'l3', title: '公民意味着什么'),
          TextbookLesson(id: 'l4', title: '公民的基本权利和义务'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们是公民', lessons: [
          TextbookLesson(id: 'l5', title: '公民意味着什么'),
          TextbookLesson(id: 'l6', title: '公民的基本权利和义务'),
          TextbookLesson(id: 'l7', title: '国家机构有哪些'),
          TextbookLesson(id: 'l8', title: '人大代表为人民'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的国家机构', lessons: [
          TextbookLesson(id: 'l9', title: '国家机构有哪些'),
          TextbookLesson(id: 'l10', title: '人大代表为人民'),
          TextbookLesson(id: 'l11', title: '权利受到制约和监督'),
          TextbookLesson(id: 'l12', title: '我们是场外代表'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '法律保护我们健康成长', lessons: [
          TextbookLesson(id: 'l13', title: '我们受特殊保护'),
          TextbookLesson(id: 'l14', title: '知法守法依法维权'),
          TextbookLesson(id: 'l15', title: '未成年人保护法'),
          TextbookLesson(id: 'l16', title: '预防未成年人犯罪法'),
        ]),
      ]),
      // 六年级下册
      TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '完善自我健康成长', lessons: [
          TextbookLesson(id: 'l1', title: '学会尊重'),
          TextbookLesson(id: 'l2', title: '学会宽容'),
          TextbookLesson(id: 'l3', title: '学会反思'),
          TextbookLesson(id: 'l4', title: '完善自我'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '爱护地球共同责任', lessons: [
          TextbookLesson(id: 'l5', title: '地球我们的家园'),
          TextbookLesson(id: 'l6', title: '环境问题敲响了警钟'),
          TextbookLesson(id: 'l7', title: '我们共同的责任'),
          TextbookLesson(id: 'l8', title: '战争带来的伤害'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '多样文明多彩生活', lessons: [
          TextbookLesson(id: 'l9', title: '探访古代文明'),
          TextbookLesson(id: 'l10', title: '闻名世界的文化遗产'),
          TextbookLesson(id: 'l11', title: '尊重文化多样性'),
          TextbookLesson(id: 'l12', title: '中国文化走向世界'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '科技让梦想成真', lessons: [
          TextbookLesson(id: 'l13', title: '科技发展造福人类'),
          TextbookLesson(id: 'l14', title: '科技是把双刃剑'),
          TextbookLesson(id: 'l15', title: '科技发展造福人类'),
          TextbookLesson(id: 'l16', title: '善于思考勇于创新'),
        ]),
      ]),
    ])];
  }

  if (grade == Grade.primary) {
    return [TextbookVersion(id: '部编版', name: '部编版（道德与法治）', semesters: [
      // ============= 一年级上册 =============
      TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我是小学生', lessons: [
          TextbookLesson(id: 'l1', title: '开开心心上学去'),
          TextbookLesson(id: 'l2', title: '拉拉手，交朋友'),
          TextbookLesson(id: 'l3', title: '我认识你啦'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '校园生活真快乐', lessons: [
          TextbookLesson(id: 'l1', title: '我们的校园'),
          TextbookLesson(id: 'l2', title: '校园里的号令'),
          TextbookLesson(id: 'l3', title: '课间十分钟'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '家中的安全与健康', lessons: [
          TextbookLesson(id: 'l1', title: '吃饭有讲究'),
          TextbookLesson(id: 'l2', title: '别伤着自己'),
          TextbookLesson(id: 'l3', title: '这样玩安全'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '天气虽冷有温暖', lessons: [
          TextbookLesson(id: 'l1', title: '我的小名片'),
          TextbookLesson(id: 'l2', title: '我的一家人'),
          TextbookLesson(id: 'l3', title: '温暖的家'),
        ]),
      ]),
      // ============= 一年级下册 =============
      TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我的好习惯', lessons: [
          TextbookLesson(id: 'l1', title: '我想和你一起玩'),
          TextbookLesson(id: 'l2', title: '分享真快乐'),
          TextbookLesson(id: 'l3', title: '做事不拖拉'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我和大自然', lessons: [
          TextbookLesson(id: 'l1', title: '风儿轻轻吹'),
          TextbookLesson(id: 'l2', title: '花儿草儿真美丽'),
          TextbookLesson(id: 'l3', title: '大自然中玩水'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我爱我家', lessons: [
          TextbookLesson(id: 'l1', title: '全家福'),
          TextbookLesson(id: 'l2', title: '我为家人添欢乐'),
          TextbookLesson(id: 'l3', title: '我和我的家'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '我们在一起', lessons: [
          TextbookLesson(id: 'l1', title: '大家的"朋友"'),
          TextbookLesson(id: 'l2', title: '快乐的儿童节'),
          TextbookLesson(id: 'l3', title: '我们小点儿声'),
        ]),
      ]),
      // ============= 二年级上册 =============
      TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们的班级', lessons: [
          TextbookLesson(id: 'l1', title: '我们爱集体'),
          TextbookLesson(id: 'l2', title: '班级生活有规则'),
          TextbookLesson(id: 'l3', title: '我们班上的同学'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '金色的秋天', lessons: [
          TextbookLesson(id: 'l1', title: '我爱秋天'),
          TextbookLesson(id: 'l2', title: '美丽的树叶'),
          TextbookLesson(id: 'l3', title: '家乡的物产'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '家中的我', lessons: [
          TextbookLesson(id: 'l1', title: '我是家里的开心果'),
          TextbookLesson(id: 'l2', title: '我有一双勤巧手'),
          TextbookLesson(id: 'l3', title: '我能照顾自己'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '面对困难我不怕', lessons: [
          TextbookLesson(id: 'l1', title: '遇到问题自己想办法'),
          TextbookLesson(id: 'l2', title: '我的"缺点"不怕说'),
          TextbookLesson(id: 'l3', title: '我不任性'),
        ]),
      ]),
      // ============= 二年级下册 =============
      TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '让我试试看', lessons: [
          TextbookLesson(id: 'l1', title: '做事不拖拉'),
          TextbookLesson(id: 'l2', title: '我能做好'),
          TextbookLesson(id: 'l3', title: '挑战第一次'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '学做小雄鹰', lessons: [
          TextbookLesson(id: 'l1', title: '小水滴的诉说'),
          TextbookLesson(id: 'l2', title: '我们不乱扔'),
          TextbookLesson(id: 'l3', title: '我能区分'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '做个好公民', lessons: [
          TextbookLesson(id: 'l1', title: '诚实的孩子人人夸'),
          TextbookLesson(id: 'l2', title: '我不说谎'),
          TextbookLesson(id: 'l3', title: '勇敢面对'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '愉快的合作', lessons: [
          TextbookLesson(id: 'l1', title: '大家一起来'),
          TextbookLesson(id: 'l2', title: '配合来合作'),
          TextbookLesson(id: 'l3', title: '小水滴要睡觉'),
        ]),
      ]),
      // ============= 三年级上册 =============
      TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '快乐学习', lessons: [
          TextbookLesson(id: 'l1', title: '学习伴我成长'),
          TextbookLesson(id: 'l2', title: '做学习的主人'),
          TextbookLesson(id: 'l3', title: '我爱学语文'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们的学校', lessons: [
          TextbookLesson(id: 'l1', title: '说说我们的学校'),
          TextbookLesson(id: 'l2', title: '让我们的学校更美好'),
          TextbookLesson(id: 'l3', title: '我爱家乡的山和水'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '安全护我成长', lessons: [
          TextbookLesson(id: 'l1', title: '生命最宝贵'),
          TextbookLesson(id: 'l2', title: '安全记心上'),
          TextbookLesson(id: 'l3', title: '心中的"110"'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '家是最温暖的地方', lessons: [
          TextbookLesson(id: 'l1', title: '说说我的家'),
          TextbookLesson(id: 'l2', title: '让爱住我家'),
          TextbookLesson(id: 'l3', title: '我们共欢乐'),
        ]),
      ]),
      // ============= 三年级下册 =============
      TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我和我的同伴', lessons: [
          TextbookLesson(id: 'l1', title: '我是独特的'),
          TextbookLesson(id: 'l2', title: '不一样的你我他'),
          TextbookLesson(id: 'l3', title: '我很诚实'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我做学习的主人', lessons: [
          TextbookLesson(id: 'l1', title: '我学会了'),
          TextbookLesson(id: 'l2', title: '不马虎'),
          TextbookLesson(id: 'l3', title: '让座'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的生活离不开规则', lessons: [
          TextbookLesson(id: 'l1', title: '生活离不开规则'),
          TextbookLesson(id: 'l2', title: '规则的意义'),
          TextbookLesson(id: 'l3', title: '做守规则的人'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '我们的家乡 我们的祖国', lessons: [
          TextbookLesson(id: 'l1', title: '我的家乡在哪里'),
          TextbookLesson(id: 'l2', title: '请到我的家乡来'),
          TextbookLesson(id: 'l3', title: '祖国的怀抱'),
        ]),
      ]),
      // ============= 四年级上册 =============
      TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '与班级共成长', lessons: [
          TextbookLesson(id: 'l1', title: '我们班四岁了'),
          TextbookLesson(id: 'l2', title: '我们的班规我们订'),
          TextbookLesson(id: 'l3', title: '我们班 他们班'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '为父母分担', lessons: [
          TextbookLesson(id: 'l1', title: '我能为父母做什么'),
          TextbookLesson(id: 'l2', title: '少让父母为我操心'),
          TextbookLesson(id: 'l3', title: '我和我的爸爸妈妈'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '信息万花筒', lessons: [
          TextbookLesson(id: 'l1', title: '多种渠道来了解'),
          TextbookLesson(id: 'l2', title: '正确认识广告'),
          TextbookLesson(id: 'l3', title: '做个聪明的消费者'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '让生活多一些绿色', lessons: [
          TextbookLesson(id: 'l1', title: '我们也需要呼吸'),
          TextbookLesson(id: 'l2', title: '我们的环保行动'),
          TextbookLesson(id: 'l3', title: '低碳生活每一天'),
        ]),
      ]),
      // ============= 四年级下册 =============
      TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '同伴与友谊', lessons: [
          TextbookLesson(id: 'l1', title: '我们的好朋友'),
          TextbookLesson(id: 'l2', title: '做朋友真好'),
          TextbookLesson(id: 'l3', title: '说声"谢谢"'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '做聪明的消费者', lessons: [
          TextbookLesson(id: 'l1', title: '消费与生活'),
          TextbookLesson(id: 'l2', title: '慧眼辨优劣'),
          TextbookLesson(id: 'l3', title: '购物小窍门'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '美好生活哪里来', lessons: [
          TextbookLesson(id: 'l1', title: '我们的生活哪里来'),
          TextbookLesson(id: 'l2', title: '劳动最光荣'),
          TextbookLesson(id: 'l3', title: '白白的大米哪里来'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '感受家乡文化 关心家乡发展', lessons: [
          TextbookLesson(id: 'l1', title: '我们的家乡'),
          TextbookLesson(id: 'l2', title: '家乡的民风民俗'),
          TextbookLesson(id: 'l3', title: '日新月异的家乡'),
        ]),
      ]),
      // ============= 五年级上册 =============
      TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '面对成长中的新问题', lessons: [
          TextbookLesson(id: 'l1', title: '我的潜能'),
          TextbookLesson(id: 'l2', title: '学会调控情绪'),
          TextbookLesson(id: 'l3', title: '我的朋友'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们是班级的主人', lessons: [
          TextbookLesson(id: 'l1', title: '班委会的职责'),
          TextbookLesson(id: 'l2', title: '集体生活需要合作'),
          TextbookLesson(id: 'l3', title: '诚实守信'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的国土 我们的家园', lessons: [
          TextbookLesson(id: 'l1', title: '我的祖国辽阔而美丽'),
          TextbookLesson(id: 'l2', title: '好山好水好地方'),
          TextbookLesson(id: 'l3', title: '守护精神家园'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '骄人祖先 灿烂文化', lessons: [
          TextbookLesson(id: 'l1', title: '我们中华民族'),
          TextbookLesson(id: 'l2', title: '我的家乡人'),
          TextbookLesson(id: 'l3', title: '传统美德源远流长'),
        ]),
      ]),
      // ============= 五年级下册 (特殊: 3 单元) =============
      TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们一家人', lessons: [
          TextbookLesson(id: 'l1', title: '读懂彼此的心'),
          TextbookLesson(id: 'l2', title: '让真情在沟通中流动'),
          TextbookLesson(id: 'l3', title: '我们的大家庭'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '公共生活靠大家', lessons: [
          TextbookLesson(id: 'l1', title: '我们的生活需要'),
          TextbookLesson(id: 'l2', title: '参与公共生活'),
          TextbookLesson(id: 'l3', title: '善用法律护权益'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '百年追梦 复兴中华', lessons: [
          TextbookLesson(id: 'l1', title: '夺取抗日战争和人民解放战争的胜利'),
          TextbookLesson(id: 'l2', title: '屹立在世界的东方'),
          TextbookLesson(id: 'l3', title: '改革开放在中国'),
          TextbookLesson(id: 'l4', title: '富起来到强起来'),
          TextbookLesson(id: 'l5', title: '夺取新征程新胜利'),
          TextbookLesson(id: 'l6', title: '走进新时代'),
          TextbookLesson(id: 'l7', title: '我们是共产主义接班人'),
        ]),
      ]),
      // ============= 六年级上册 =============
      TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们的守护者', lessons: [
          TextbookLesson(id: 'l1', title: '人民子弟兵'),
          TextbookLesson(id: 'l2', title: '敬畏自然'),
          TextbookLesson(id: 'l3', title: '做个聪明的消费者'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '我们是公民', lessons: [
          TextbookLesson(id: 'l1', title: '我是中国公民'),
          TextbookLesson(id: 'l2', title: '宪法是根本法'),
          TextbookLesson(id: 'l3', title: '公民的基本权利与义务'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '我们的国家机构', lessons: [
          TextbookLesson(id: 'l1', title: '国家机构有哪些'),
          TextbookLesson(id: 'l2', title: '认识居民委员会'),
          TextbookLesson(id: 'l3', title: '人大代表为人民'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '法律在我们身边', lessons: [
          TextbookLesson(id: 'l1', title: '法律是什么'),
          TextbookLesson(id: 'l2', title: '未成年人保护法'),
          TextbookLesson(id: 'l3', title: '我们受特殊保护'),
        ]),
      ]),
      // ============= 六年级下册 =============
      TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '完善自我 健康成长', lessons: [
          TextbookLesson(id: 'l1', title: '学会尊重'),
          TextbookLesson(id: 'l2', title: '学会宽容'),
          TextbookLesson(id: 'l3', title: '学会反思'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '爱护人类共同的家园', lessons: [
          TextbookLesson(id: 'l1', title: '我们生活的世界'),
          TextbookLesson(id: 'l2', title: '为世界添色'),
          TextbookLesson(id: 'l3', title: '应对自然灾害'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '多样文明 多彩生活', lessons: [
          TextbookLesson(id: 'l1', title: '透视社会多样性'),
          TextbookLesson(id: 'l2', title: '人们多样的生活方式'),
          TextbookLesson(id: 'l3', title: '现代科技给我们生活带来的变化'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '让世界更美好', lessons: [
          TextbookLesson(id: 'l1', title: '我们爱和平'),
          TextbookLesson(id: 'l2', title: '战争带来的伤害'),
          TextbookLesson(id: 'l3', title: '让和平之声响彻全球'),
        ]),
      ]),
    ])];
  }
  if (grade == Grade.junior) {
    return [TextbookVersion(id: '部编版', name: '部编版（道德与法治）', semesters: [
      // 七年级上册
      TextbookSemester(id: '七上', name: '七年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '成长的节拍', lessons: [
          TextbookLesson(id: 'l1', title: '中学序曲'),
          TextbookLesson(id: 'l2', title: '少年当自强'),
          TextbookLesson(id: 'l3', title: '发现自己'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '友谊的天空', lessons: [
          TextbookLesson(id: 'l4', title: '友谊与成长同行'),
          TextbookLesson(id: 'l5', title: '交友的智慧'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '师长情谊', lessons: [
          TextbookLesson(id: 'l6', title: '走近老师'),
          TextbookLesson(id: 'l7', title: '师生交往'),
          TextbookLesson(id: 'l8', title: '亲情之爱'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '生命的思考', lessons: [
          TextbookLesson(id: 'l9', title: '探问生命'),
          TextbookLesson(id: 'l10', title: '珍视生命'),
          TextbookLesson(id: 'l11', title: '绽放生命之花'),
        ]),
      ]),
      // 七年级下册
      TextbookSemester(id: '七下', name: '七年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '青春时光', lessons: [
          TextbookLesson(id: 'l1', title: '青春的邀约'),
          TextbookLesson(id: 'l2', title: '青春的心弦'),
          TextbookLesson(id: 'l3', title: '青春的证明'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '做情绪情感的主人', lessons: [
          TextbookLesson(id: 'l4', title: '揭开情绪的面纱'),
          TextbookLesson(id: 'l5', title: '品味情感'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '在集体中成长', lessons: [
          TextbookLesson(id: 'l6', title: '集体生活邀请我'),
          TextbookLesson(id: 'l7', title: '集体生活成就我'),
          TextbookLesson(id: 'l8', title: '共奏和谐乐章'),
          TextbookLesson(id: 'l9', title: '美好的集体'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '走进法治天地', lessons: [
          TextbookLesson(id: 'l10', title: '法律在我们身边'),
          TextbookLesson(id: 'l11', title: '法律保障生活'),
        ]),
      ]),
      // 八年级上册
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '走进社会生活', lessons: [
          TextbookLesson(id: 'l1', title: '丰富的社会生活'),
          TextbookLesson(id: 'l2', title: '网络改变世界'),
          TextbookLesson(id: 'l3', title: '网络空间不是法外之地'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '遵守社会规则', lessons: [
          TextbookLesson(id: 'l4', title: '维护秩序'),
          TextbookLesson(id: 'l5', title: '尊重他人'),
          TextbookLesson(id: 'l6', title: '以礼待人'),
          TextbookLesson(id: 'l7', title: '诚实守信'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '承担社会责任', lessons: [
          TextbookLesson(id: 'l8', title: '责任与角色同在'),
          TextbookLesson(id: 'l9', title: '做负责任的人'),
          TextbookLesson(id: 'l10', title: '做负责任的公民'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '维护国家利益', lessons: [
          TextbookLesson(id: 'l11', title: '国家好 大家才会好'),
          TextbookLesson(id: 'l12', title: '树立总体国家安全观'),
          TextbookLesson(id: 'l13', title: '维护国家安全'),
        ]),
      ]),
      // 八年级下册
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '坚持宪法至上', lessons: [
          TextbookLesson(id: 'l1', title: '党的主张和人民意志的统一'),
          TextbookLesson(id: 'l2', title: '治国安邦的总章程'),
          TextbookLesson(id: 'l3', title: '坚持依宪治国'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '理解权利义务', lessons: [
          TextbookLesson(id: 'l4', title: '公民基本权利'),
          TextbookLesson(id: 'l5', title: '依法行使权利'),
          TextbookLesson(id: 'l6', title: '公民基本义务'),
          TextbookLesson(id: 'l7', title: '依法履行义务'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '人民当家作主', lessons: [
          TextbookLesson(id: 'l8', title: '根本政治制度'),
          TextbookLesson(id: 'l9', title: '基本政治制度'),
          TextbookLesson(id: 'l10', title: '国家机构'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '崇尚法治精神', lessons: [
          TextbookLesson(id: 'l11', title: '尊重自由平等'),
          TextbookLesson(id: 'l12', title: '维护公平正义'),
        ]),
      ]),
      // 九年级上册
      TextbookSemester(id: '九上', name: '九年级上册', label: '上册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '富强之路', lessons: [
          TextbookLesson(id: 'l1', title: '踏上强国之路'),
          TextbookLesson(id: 'l2', title: '创新驱动发展'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '民主与法治', lessons: [
          TextbookLesson(id: 'l3', title: '生活在新型民主国家'),
          TextbookLesson(id: 'l4', title: '建设法治中国'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '文明与家园', lessons: [
          TextbookLesson(id: 'l5', title: '延续文化血脉'),
          TextbookLesson(id: 'l6', title: '凝聚价值追求'),
        ]),
        TextbookUnit(id: 'u4', title: '第四单元', label: '和谐与梦想', lessons: [
          TextbookLesson(id: 'l7', title: '促进民族团结'),
          TextbookLesson(id: 'l8', title: '维护祖国统一'),
          TextbookLesson(id: 'l9', title: '中国梦 我的梦'),
        ]),
      ]),
      // 九年级下册
      TextbookSemester(id: '九下', name: '九年级下册', label: '下册', units: [
        TextbookUnit(id: 'u1', title: '第一单元', label: '我们共同的世界', lessons: [
          TextbookLesson(id: 'l1', title: '开放互动的世界'),
          TextbookLesson(id: 'l2', title: '构建人类命运共同体'),
        ]),
        TextbookUnit(id: 'u2', title: '第二单元', label: '世界大舞台上的中国', lessons: [
          TextbookLesson(id: 'l3', title: '同住地球村'),
          TextbookLesson(id: 'l4', title: '与世界深度互动'),
        ]),
        TextbookUnit(id: 'u3', title: '第三单元', label: '走向未来的少年', lessons: [
          TextbookLesson(id: 'l5', title: '少年的担当'),
          TextbookLesson(id: 'l6', title: '我的毕业季'),
          TextbookLesson(id: 'l7', title: '从这里出发'),
        ]),
      ]),
    ])];
  }

  // 高中政治 部编版(2020)
  return [TextbookVersion(id: '部编版', name: '部编版(2020版)', semesters: [
    // 必修一：中国特色社会主义
    TextbookSemester(id: '必修一', name: '必修一（中国特色社会主义）', label: '必修一', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '中国特色社会主义的创立、发展和完善', lessons: [
        TextbookLesson(id: 'l1', title: '原始社会的解体和阶级社会的演进'),
        TextbookLesson(id: 'l2', title: '社会主义从空想到科学、从理论到实践'),
        TextbookLesson(id: 'l3', title: '中国特色社会主义道路的开辟与发展'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '只有社会主义才能救中国', lessons: [
        TextbookLesson(id: 'l4', title: '新民主主义革命的胜利'),
        TextbookLesson(id: 'l5', title: '社会主义制度在中国的确立'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '只有中国特色社会主义才能发展中国', lessons: [
        TextbookLesson(id: 'l6', title: '伟大的改革开放'),
        TextbookLesson(id: 'l7', title: '中国特色社会主义道路、理论、制度、文化'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '只有坚持和发展中国特色社会主义才能实现中华民族伟大复兴', lessons: [
        TextbookLesson(id: 'l8', title: '中国梦'),
        TextbookLesson(id: 'l9', title: '实现中华民族伟大复兴的中国梦'),
      ]),
    ]),
    // 必修二：经济与社会
    TextbookSemester(id: '必修二', name: '必修二（经济与社会）', label: '必修二', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '我国的基本经济制度', lessons: [
        TextbookLesson(id: 'l1', title: '公有制为主体 多种所有制经济共同发展'),
        TextbookLesson(id: 'l2', title: '坚持按劳分配为主体、多种分配方式并存'),
        TextbookLesson(id: 'l3', title: '社会主义市场经济体制'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '使市场在资源配置中起决定性作用', lessons: [
        TextbookLesson(id: 'l4', title: '市场配置资源'),
        TextbookLesson(id: 'l5', title: '更好发挥政府作用'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '新发展理念与高质量发展', lessons: [
        TextbookLesson(id: 'l6', title: '坚持新发展理念'),
        TextbookLesson(id: 'l7', title: '推动高质量发展'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '我国的个人收入分配与社会保障', lessons: [
        TextbookLesson(id: 'l8', title: '我国的个人收入分配'),
        TextbookLesson(id: 'l9', title: '我国的社会保障'),
      ]),
    ]),
    // 必修三：政治与法治
    TextbookSemester(id: '必修三', name: '必修三（政治与法治）', label: '必修三', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '中国共产党的领导', lessons: [
        TextbookLesson(id: 'l1', title: '中华人民共和国成立前各种政治力量'),
        TextbookLesson(id: 'l2', title: '中国共产党领导人民站起来、富起来、强起来'),
        TextbookLesson(id: 'l3', title: '坚持和加强党的全面领导'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '人民当家作主', lessons: [
        TextbookLesson(id: 'l4', title: '全过程人民民主'),
        TextbookLesson(id: 'l5', title: '人民代表大会制度'),
        TextbookLesson(id: 'l6', title: '中国共产党领导的多党合作和政治协商制度'),
        TextbookLesson(id: 'l7', title: '民族区域自治制度'),
        TextbookLesson(id: 'l8', title: '基层群众自治制度'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '全面依法治国', lessons: [
        TextbookLesson(id: 'l9', title: '法治国家'),
        TextbookLesson(id: 'l10', title: '法治政府'),
        TextbookLesson(id: 'l11', title: '法治社会'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '巩固党的执政地位', lessons: [
        TextbookLesson(id: 'l12', title: '坚持科学执政、民主执政、依法执政'),
        TextbookLesson(id: 'l13', title: '全面从严治党'),
      ]),
    ]),
    // 必修四：哲学与文化
    TextbookSemester(id: '必修四', name: '必修四（哲学与文化）', label: '必修四', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '探索世界与把握规律', lessons: [
        TextbookLesson(id: 'l1', title: '世界的物质性'),
        TextbookLesson(id: 'l2', title: '世界的普遍联系和永恒发展'),
        TextbookLesson(id: 'l3', title: '唯物辩证法的实质与核心'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '认识社会与价值选择', lessons: [
        TextbookLesson(id: 'l4', title: '实践与认识的辩证关系'),
        TextbookLesson(id: 'l5', title: '社会历史的本质'),
        TextbookLesson(id: 'l6', title: '社会历史的主体'),
        TextbookLesson(id: 'l7', title: '价值与价值观'),
        TextbookLesson(id: 'l8', title: '价值的创造与实现'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '文化传承与文化创新', lessons: [
        TextbookLesson(id: 'l9', title: '文化的内涵与功能'),
        TextbookLesson(id: 'l10', title: '优秀文化传承与创新'),
        TextbookLesson(id: 'l11', title: '中华优秀传统文化'),
        TextbookLesson(id: 'l12', title: '革命文化与社会主义先进文化'),
      ]),
    ]),
    // 选择性必修一：当代国际政治与经济
    TextbookSemester(id: '选必一', name: '选择性必修一（当代国际政治与经济）', label: '选必一', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '各具特色的国家', lessons: [
        TextbookLesson(id: 'l1', title: '国家的本质'),
        TextbookLesson(id: 'l2', title: '国家的政权组织形式'),
        TextbookLesson(id: 'l3', title: '国家的结构形式'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '世界多极化', lessons: [
        TextbookLesson(id: 'l4', title: '世界多极化的趋势'),
        TextbookLesson(id: 'l5', title: '国际组织'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '经济全球化', lessons: [
        TextbookLesson(id: 'l6', title: '经济全球化的深入发展'),
        TextbookLesson(id: 'l7', title: '国际组织与全球治理'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '中国的外交', lessons: [
        TextbookLesson(id: 'l8', title: '中国外交政策的形成与发展'),
        TextbookLesson(id: 'l9', title: '构建人类命运共同体'),
      ]),
    ]),
    // 选择性必修二：法律与生活
    TextbookSemester(id: '选必二', name: '选择性必修二（法律与生活）', label: '选必二', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '民事权利与义务', lessons: [
        TextbookLesson(id: 'l1', title: '认真对待民事权利与义务'),
        TextbookLesson(id: 'l2', title: '积极维护人身权利'),
        TextbookLesson(id: 'l3', title: '依法保护财产权'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '家庭与婚姻', lessons: [
        TextbookLesson(id: 'l4', title: '婚姻家庭中的权利与义务'),
        TextbookLesson(id: 'l5', title: '父母与子女间的权利与义务'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '就业与创业', lessons: [
        TextbookLesson(id: 'l6', title: '树立正确的就业观'),
        TextbookLesson(id: 'l7', title: '劳动合同与劳动者权益'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '社会争议解决', lessons: [
        TextbookLesson(id: 'l8', title: '纠纷的多元解决方式'),
        TextbookLesson(id: 'l9', title: '诉讼实现公平正义'),
      ]),
    ]),
    // 选择性必修三：逻辑与思维
    TextbookSemester(id: '选必三', name: '选择性必修三（逻辑与思维）', label: '选必三', units: [
      TextbookUnit(id: 'u1', title: '第一课', label: '树立科学思维观念', lessons: [
        TextbookLesson(id: 'l1', title: '思维的含义与特征'),
        TextbookLesson(id: 'l2', title: '思维的类型'),
      ]),
      TextbookUnit(id: 'u2', title: '第二课', label: '遵循逻辑思维规则', lessons: [
        TextbookLesson(id: 'l3', title: '概念的概述'),
        TextbookLesson(id: 'l4', title: '概念的逻辑方法'),
        TextbookLesson(id: 'l5', title: '判断的概述'),
        TextbookLesson(id: 'l6', title: '性质判断和关系判断'),
        TextbookLesson(id: 'l7', title: '复合判断'),
      ]),
      TextbookUnit(id: 'u3', title: '第三课', label: '运用辩证思维方法', lessons: [
        TextbookLesson(id: 'l8', title: '辩证思维的含义与特征'),
        TextbookLesson(id: 'l9', title: '分析与综合及其辩证关系'),
        TextbookLesson(id: 'l10', title: '质量互变规律'),
      ]),
      TextbookUnit(id: 'u4', title: '第四课', label: '提高创新思维能力', lessons: [
        TextbookLesson(id: 'l11', title: '创新思维的含义与特征'),
        TextbookLesson(id: 'l12', title: '创新思维的技法'),
        TextbookLesson(id: 'l13', title: '创新思维的哲学基础'),
      ]),
    ]),
  ])];
}

// ============================================================
// 科学 — 教科版（小学）
// ============================================================

List<TextbookVersion> _getScienceTextbooks(Grade grade) {
  return [TextbookVersion(id: '教科版', name: '教科版', semesters: [
    // 一年级上册
    TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '植物', lessons: [
        TextbookLesson(id: 'l1', title: '我们知道的植物'),
        TextbookLesson(id: 'l2', title: '观察一棵植物'),
        TextbookLesson(id: 'l3', title: '植物的变化'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '比较与测量', lessons: [
        TextbookLesson(id: 'l4', title: '起点和终点'),
        TextbookLesson(id: 'l5', title: '用手来测量'),
        TextbookLesson(id: 'l6', title: '用不同的物体测量'),
        TextbookLesson(id: 'l7', title: '用尺子测量'),
      ]),
    ]),
    // 一年级下册
    TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '我们周围的物体', lessons: [
        TextbookLesson(id: 'l1', title: '物体的特征'),
        TextbookLesson(id: 'l2', title: '物体的分类'),
        TextbookLesson(id: 'l3', title: '比较物体的大小'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '动物', lessons: [
        TextbookLesson(id: 'l4', title: '我们知道的动物'),
        TextbookLesson(id: 'l5', title: '观察一种动物'),
        TextbookLesson(id: 'l6', title: '动物的特征'),
      ]),
    ]),
    // 二年级上册
    TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '我们的地球家园', lessons: [
        TextbookLesson(id: 'l1', title: '地球家园中有什么'),
        TextbookLesson(id: 'l2', title: '土壤——动植物的乐园'),
        TextbookLesson(id: 'l3', title: '太阳和月亮'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '材料', lessons: [
        TextbookLesson(id: 'l4', title: '我们生活的世界'),
        TextbookLesson(id: 'l5', title: '不同材料的餐具'),
        TextbookLesson(id: 'l6', title: '书的历史'),
      ]),
    ]),
    // 二年级下册
    TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '磁铁', lessons: [
        TextbookLesson(id: 'l1', title: '磁铁能吸引什么'),
        TextbookLesson(id: 'l2', title: '磁铁怎样吸引物体'),
        TextbookLesson(id: 'l3', title: '磁铁的两极'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '我们自己', lessons: [
        TextbookLesson(id: 'l4', title: '我们的身体'),
        TextbookLesson(id: 'l5', title: '身体的运动'),
        TextbookLesson(id: 'l6', title: '保护我们的身体'),
      ]),
    ]),
    // 三年级上册
    TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '水', lessons: [
        TextbookLesson(id: 'l1', title: '水到哪里去了'),
        TextbookLesson(id: 'l2', title: '水沸腾了'),
        TextbookLesson(id: 'l3', title: '水结冰了'),
        TextbookLesson(id: 'l4', title: '冰融化了'),
        TextbookLesson(id: 'l5', title: '水能溶解什么'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '空气', lessons: [
        TextbookLesson(id: 'l6', title: '感受空气'),
        TextbookLesson(id: 'l7', title: '空气能占据空间吗'),
        TextbookLesson(id: 'l8', title: '压缩空气'),
        TextbookLesson(id: 'l9', title: '空气有质量吗'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '植物', lessons: [
        TextbookLesson(id: 'l10', title: '植物的根'),
        TextbookLesson(id: 'l11', title: '植物的叶'),
        TextbookLesson(id: 'l12', title: '植物的生长变化'),
      ]),
    ]),
    // 三年级下册
    TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '物体的运动', lessons: [
        TextbookLesson(id: 'l1', title: '运动和位置'),
        TextbookLesson(id: 'l2', title: '各种各样的运动'),
        TextbookLesson(id: 'l3', title: '直线运动和曲线运动'),
        TextbookLesson(id: 'l4', title: '物体在斜面上运动'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '动物的一生', lessons: [
        TextbookLesson(id: 'l5', title: '迎接蚕宝宝的到来'),
        TextbookLesson(id: 'l6', title: '蚕的生长变化'),
        TextbookLesson(id: 'l7', title: '蚕的一生'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '太阳、地球和月球', lessons: [
        TextbookLesson(id: 'l8', title: '仰望天空'),
        TextbookLesson(id: 'l9', title: '阳光下物体的影子'),
        TextbookLesson(id: 'l10', title: '月相变化的规律'),
      ]),
    ]),
    // 四年级上册
    TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '声音', lessons: [
        TextbookLesson(id: 'l1', title: '听听声音'),
        TextbookLesson(id: 'l2', title: '声音是怎样产生的'),
        TextbookLesson(id: 'l3', title: '声音是怎样传播的'),
        TextbookLesson(id: 'l4', title: '声音的高低与强弱'),
        TextbookLesson(id: 'l5', title: '我们怎样听到声音'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '呼吸与消化', lessons: [
        TextbookLesson(id: 'l1', title: '感受我们的呼吸'),
        TextbookLesson(id: 'l2', title: '呼吸与健康生活'),
        TextbookLesson(id: 'l3', title: '食物中的营养'),
        TextbookLesson(id: 'l4', title: '食物在体内的旅行'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '运动和力', lessons: [
        TextbookLesson(id: 'l1', title: '让小车运动起来'),
        TextbookLesson(id: 'l2', title: '用气球驱动小车'),
        TextbookLesson(id: 'l3', title: '用橡皮筋驱动小车'),
        TextbookLesson(id: 'l4', title: '弹簧测力计'),
        TextbookLesson(id: 'l5', title: '运动与摩擦力'),
        TextbookLesson(id: 'l6', title: '运动的小车'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '天气', lessons: [
        TextbookLesson(id: 'l1', title: '我们关心的天气'),
        TextbookLesson(id: 'l2', title: '怎样观看天气'),
        TextbookLesson(id: 'l3', title: '温度和气温'),
        TextbookLesson(id: 'l4', title: '风向和风速'),
        TextbookLesson(id: 'l5', title: '降水量的多少'),
        TextbookLesson(id: 'l6', title: '云的观测'),
        TextbookLesson(id: 'l7', title: '总结我们的天气观察'),
      ]),
    ]),
    // 四年级下册
    TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '电', lessons: [
        TextbookLesson(id: 'l1', title: '生活中的静电现象'),
        TextbookLesson(id: 'l2', title: '点亮小灯泡'),
        TextbookLesson(id: 'l3', title: '简易电路'),
        TextbookLesson(id: 'l4', title: '电路出故障了'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '新的生命', lessons: [
        TextbookLesson(id: 'l5', title: '油菜花开了'),
        TextbookLesson(id: 'l6', title: '种子发芽了'),
        TextbookLesson(id: 'l7', title: '果实和种子'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '食物', lessons: [
        TextbookLesson(id: 'l8', title: '一天的食物'),
        TextbookLesson(id: 'l9', title: '食物中的营养'),
        TextbookLesson(id: 'l10', title: '营养要均衡'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '岩石和矿物', lessons: [
        TextbookLesson(id: 'l11', title: '各种各样的岩石'),
        TextbookLesson(id: 'l12', title: '认识几种常见的矿物'),
      ]),
    ]),
    // 五年级上册
    TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '光', lessons: [
        TextbookLesson(id: 'l1', title: '光和影'),
        TextbookLesson(id: 'l2', title: '阳光下的影子'),
        TextbookLesson(id: 'l3', title: '光是怎样传播的'),
        TextbookLesson(id: 'l4', title: '光的反射'),
        TextbookLesson(id: 'l5', title: '光与热'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '地球表面及其变化', lessons: [
        TextbookLesson(id: 'l6', title: '地球表面的地形'),
        TextbookLesson(id: 'l7', title: '地球内部运动引起的地形变化'),
        TextbookLesson(id: 'l8', title: '岩石会改变模样吗'),
        TextbookLesson(id: 'l9', title: '土壤中有什么'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '计量时间', lessons: [
        TextbookLesson(id: 'l10', title: '时间在流逝'),
        TextbookLesson(id: 'l11', title: '用水测量时间'),
        TextbookLesson(id: 'l12', title: '机械摆钟'),
      ]),
    ]),
    // 五年级下册
    TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '生物与环境', lessons: [
        TextbookLesson(id: 'l1', title: '种子发芽实验'),
        TextbookLesson(id: 'l2', title: '动物的生长'),
        TextbookLesson(id: 'l3', title: '食物链和食物网'),
        TextbookLesson(id: 'l4', title: '生态瓶'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '船的研究', lessons: [
        TextbookLesson(id: 'l5', title: '船的历史'),
        TextbookLesson(id: 'l6', title: '用浮的材料造船'),
        TextbookLesson(id: 'l7', title: '用沉的材料造船'),
        TextbookLesson(id: 'l8', title: '设计我们的小船'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '环境与我们', lessons: [
        TextbookLesson(id: 'l9', title: '地球——我们的家园'),
        TextbookLesson(id: 'l10', title: '解决垃圾问题'),
        TextbookLesson(id: 'l11', title: '绿水和我们的食物'),
      ]),
    ]),
    // 六年级上册
    TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '微小世界', lessons: [
        TextbookLesson(id: 'l1', title: '放大镜'),
        TextbookLesson(id: 'l2', title: '显微镜下的世界'),
        TextbookLesson(id: 'l3', title: '观察细胞'),
        TextbookLesson(id: 'l4', title: '微生物'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '物质的变化', lessons: [
        TextbookLesson(id: 'l5', title: '我们身边的物质'),
        TextbookLesson(id: 'l6', title: '物质发生了什么变化'),
        TextbookLesson(id: 'l7', title: '混合与分离'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '能量', lessons: [
        TextbookLesson(id: 'l8', title: '电和磁'),
        TextbookLesson(id: 'l9', title: '电磁铁'),
        TextbookLesson(id: 'l10', title: '能量的转换'),
      ]),
    ]),
    // 六年级下册
    TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: [
      TextbookUnit(id: 'u1', title: '第一单元', label: '小小工程师', lessons: [
        TextbookLesson(id: 'l1', title: '了解我们的住房'),
        TextbookLesson(id: 'l2', title: '设计我们的住房'),
        TextbookLesson(id: 'l3', title: '建造我们的住房'),
      ]),
      TextbookUnit(id: 'u2', title: '第二单元', label: '物质的变化', lessons: [
        TextbookLesson(id: 'l4', title: '化学变化伴随的现象'),
        TextbookLesson(id: 'l5', title: '生锈与防锈'),
        TextbookLesson(id: 'l6', title: '物质变化与我们'),
      ]),
      TextbookUnit(id: 'u3', title: '第三单元', label: '宇宙', lessons: [
        TextbookLesson(id: 'l7', title: '太阳系'),
        TextbookLesson(id: 'l8', title: '星空'),
        TextbookLesson(id: 'l9', title: '探索宇宙'),
      ]),
      TextbookUnit(id: 'u4', title: '第四单元', label: '环境和我们', lessons: [
        TextbookLesson(id: 'l10', title: '节约能源'),
        TextbookLesson(id: 'l11', title: '保护环境'),
      ]),
    ]),
  ])];
}

// ============================================================
// 兜底函数 — 未匹配学科时使用
// ============================================================

List<TextbookVersion> _getFallbackTextbooks(Grade grade, String subjectKey) {
  // 学科中文映射（用于显示名称）
  final subjectName = _subjectDisplayName(subjectKey);

  if (grade == Grade.primary) {
    // 小学：12个学期（一上~六下）
    return [TextbookVersion(id: '通用', name: '$subjectName（通用版）', semesters: [
      TextbookSemester(id: '一上', name: '一年级上册', label: '上册', units: _fallbackPrimaryUnits('一年级')),
      TextbookSemester(id: '一下', name: '一年级下册', label: '下册', units: _fallbackPrimaryUnits('一年级')),
      TextbookSemester(id: '二上', name: '二年级上册', label: '上册', units: _fallbackPrimaryUnits('二年级')),
      TextbookSemester(id: '二下', name: '二年级下册', label: '下册', units: _fallbackPrimaryUnits('二年级')),
      TextbookSemester(id: '三上', name: '三年级上册', label: '上册', units: _fallbackPrimaryUnits('三年级')),
      TextbookSemester(id: '三下', name: '三年级下册', label: '下册', units: _fallbackPrimaryUnits('三年级')),
      TextbookSemester(id: '四上', name: '四年级上册', label: '上册', units: _fallbackPrimaryUnits('四年级')),
      TextbookSemester(id: '四下', name: '四年级下册', label: '下册', units: _fallbackPrimaryUnits('四年级')),
      TextbookSemester(id: '五上', name: '五年级上册', label: '上册', units: _fallbackPrimaryUnits('五年级')),
      TextbookSemester(id: '五下', name: '五年级下册', label: '下册', units: _fallbackPrimaryUnits('五年级')),
      TextbookSemester(id: '六上', name: '六年级上册', label: '上册', units: _fallbackPrimaryUnits('六年级')),
      TextbookSemester(id: '六下', name: '六年级下册', label: '下册', units: _fallbackPrimaryUnits('六年级')),
    ])];
  }

  if (grade == Grade.junior) {
    // 初中：6个学期（七上~九下）
    return [TextbookVersion(id: '通用', name: '$subjectName（通用版）', semesters: [
      TextbookSemester(id: '七上', name: '七年级上册', label: '上册', units: _fallbackJuniorUnits()),
      TextbookSemester(id: '七下', name: '七年级下册', label: '下册', units: _fallbackJuniorUnits()),
      TextbookSemester(id: '八上', name: '八年级上册', label: '上册', units: _fallbackJuniorUnits()),
      TextbookSemester(id: '八下', name: '八年级下册', label: '下册', units: _fallbackJuniorUnits()),
      TextbookSemester(id: '九上', name: '九年级上册', label: '上册', units: _fallbackJuniorUnits()),
      TextbookSemester(id: '九下', name: '九年级下册', label: '下册', units: _fallbackJuniorUnits()),
    ])];
  }

  // 高中：6个学期（必修一~三 + 选必一~三），覆盖绝大多数学科
  return [TextbookVersion(id: '通用', name: '$subjectName（通用版）', semesters: [
    TextbookSemester(id: '必修一', name: '必修第一册', label: '必修一', units: _fallbackSeniorUnits()),
    TextbookSemester(id: '必修二', name: '必修第二册', label: '必修二', units: _fallbackSeniorUnits()),
    TextbookSemester(id: '必修三', name: '必修第三册', label: '必修三', units: _fallbackSeniorUnits()),
    TextbookSemester(id: '选必一', name: '选择性必修第一册', label: '选必一', units: _fallbackSeniorUnits()),
    TextbookSemester(id: '选必二', name: '选择性必修第二册', label: '选必二', units: _fallbackSeniorUnits()),
    TextbookSemester(id: '选必三', name: '选择性必修第三册', label: '选必三', units: _fallbackSeniorUnits()),
  ])];
}

/// 学科中文显示名称
String _subjectDisplayName(String key) {
  const map = {
    'chinese': '语文', 'math': '数学', 'english': '英语',
    'physics': '物理', 'chemistry': '化学', 'biology': '生物',
    'history': '历史', 'geography': '地理',
    'morality': '道德与法治', 'politics': '政治',
    'science': '科学', 'pe': '体育', 'art': '美术', 'music': '音乐',
    'information': '信息技术',
  };
  return map[key] ?? key;
}

/// 小学兜底单元（每学期4个单元）
List<TextbookUnit> _fallbackPrimaryUnits(String gradeName) {
  return [
    TextbookUnit(id: 'u1', title: '第一章', label: '核心概念', lessons: [
      TextbookLesson(id: 'l1', title: '认识基本概念'),
      TextbookLesson(id: 'l2', title: '概念的理解与运用'),
    ]),
    TextbookUnit(id: 'u2', title: '第二章', label: '重点知识', lessons: [
      TextbookLesson(id: 'l3', title: '基础知识精讲'),
      TextbookLesson(id: 'l4', title: '重点难点突破'),
    ]),
    TextbookUnit(id: 'u3', title: '第三章', label: '实践探究', lessons: [
      TextbookLesson(id: 'l5', title: '观察与发现'),
      TextbookLesson(id: 'l6', title: '动手做一做'),
    ]),
    TextbookUnit(id: 'u4', title: '第四章', label: '拓展提升', lessons: [
      TextbookLesson(id: 'l7', title: '综合应用'),
      TextbookLesson(id: 'l8', title: '思考与总结'),
    ]),
  ];
}

/// 初中兜底单元（每学期4个单元）
List<TextbookUnit> _fallbackJuniorUnits() {
  return [
    TextbookUnit(id: 'u1', title: '第一章', label: '核心概念', lessons: [
      TextbookLesson(id: 'l1', title: '基本概念与原理'),
      TextbookLesson(id: 'l2', title: '重要知识点梳理'),
      TextbookLesson(id: 'l3', title: '典型例题分析'),
    ]),
    TextbookUnit(id: 'u2', title: '第二章', label: '重点知识', lessons: [
      TextbookLesson(id: 'l4', title: '核心知识精讲'),
      TextbookLesson(id: 'l5', title: '重难点突破'),
      TextbookLesson(id: 'l6', title: '知识拓展与延伸'),
    ]),
    TextbookUnit(id: 'u3', title: '第三章', label: '综合应用', lessons: [
      TextbookLesson(id: 'l7', title: '知识点综合运用'),
      TextbookLesson(id: 'l8', title: '实验与探究'),
      TextbookLesson(id: 'l9', title: '案例分析'),
    ]),
    TextbookUnit(id: 'u4', title: '第四章', label: '拓展提升', lessons: [
      TextbookLesson(id: 'l10', title: '专题复习'),
      TextbookLesson(id: 'l11', title: '能力提升训练'),
      TextbookLesson(id: 'l12', title: '单元总结与反思'),
    ]),
  ];
}

/// 高中兜底单元（每学期4个单元）
List<TextbookUnit> _fallbackSeniorUnits() {
  return [
    TextbookUnit(id: 'u1', title: '第一章', label: '核心概念', lessons: [
      TextbookLesson(id: 'l1', title: '基本概念与基本原理'),
      TextbookLesson(id: 'l2', title: '重要定理与公式'),
      TextbookLesson(id: 'l3', title: '典型例题精讲'),
    ]),
    TextbookUnit(id: 'u2', title: '第二章', label: '重点知识', lessons: [
      TextbookLesson(id: 'l4', title: '核心知识体系构建'),
      TextbookLesson(id: 'l5', title: '重难点深度解析'),
      TextbookLesson(id: 'l6', title: '知识拓展与迁移'),
    ]),
    TextbookUnit(id: 'u3', title: '第三章', label: '综合应用', lessons: [
      TextbookLesson(id: 'l7', title: '综合题型训练'),
      TextbookLesson(id: 'l8', title: '实验设计与探究'),
      TextbookLesson(id: 'l9', title: '高考真题链接'),
    ]),
    TextbookUnit(id: 'u4', title: '第四章', label: '拓展提升', lessons: [
      TextbookLesson(id: 'l10', title: '专题突破'),
      TextbookLesson(id: 'l11', title: '创新思维训练'),
      TextbookLesson(id: 'l12', title: '章节总结与展望'),
    ]),
  ];
}
// ============================================================
