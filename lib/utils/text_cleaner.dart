/// 文本清洗工具 — 移除 Markdown/LaTeX/特殊符号，输出纯中文自然语言
///
/// 两个清洗级别：
/// - cleanForDisplay(): 去掉格式符号但保留 emoji（聊天气泡显示用）
/// - cleanForTts():     去掉一切符号包括 emoji（TTS 语音播报用）
library;

class TextCleaner {
  TextCleaner._();

  // ==================== 公共入口 ====================

  /// 清洗文本用于聊天气泡显示 — 去掉 Markdown/LaTeX 格式但保留教学 emoji
  static String cleanForDisplay(String text) {
    return _cleanCore(text, keepEmoji: true);
  }

  /// 清洗文本用于 TTS 播报 — 去掉一切特殊符号包括 emoji
  static String cleanForTts(String text) {
    return _cleanCore(text, keepEmoji: false);
  }

  // ==================== 核心清洗流水线 ====================

  static String _cleanCore(String text, {required bool keepEmoji}) {
    var cleaned = text;

    // ── 第零轮：$数字 题号标记 → 转为可读格式（在一切清洗之前） ──
    // 处理 AI 可能用的 $1、$2、$1.、$2、 等题号写法
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'\$(\d+)[.、]?\s*'),
      (m) => '\n\n【第${m.group(1)}题】\n',
    );

    // ── 第零·一轮：LaTeX 数学公式清理 ──
    // 块级数学公式 $$...$$ → 替换为中文描述
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'\$\$([\s\S]*?)\$\$'),
      (m) {
        var inner = m.group(1) ?? '';
        inner = _translateLatex(inner);
        return '【数学公式：$inner】';
      },
    );
    // 行内数学公式 $...$ → 保留清洗后内容（行限定，防止跨行误匹配）
    cleaned = cleaned.replaceAllMapped(
      RegExp(r'\$([^\$\n]{1,300}?)\$'),
      (m) {
        var inner = m.group(1) ?? '';
        return _translateLatex(inner);
      },
    );
    // 去除所有残留 $ 符号（防止读成"美元"或留下孤立数字）
    cleaned = cleaned.replaceAll('\$', '');

    // ── 第零·五轮：清除反引号代码、尖括号标签等 ──
    cleaned = cleaned
        .replaceAll('\\', '')  // 去除所有残留反斜杠
        .replaceAll('```', '') // 代码块标记
        .replaceAll('`', '')   // 行内代码标记
        .replaceAll('{', '')   // LaTeX 花括号（已在上面处理完）
        .replaceAll('}', '')
        .replaceAll('<', '')   // HTML 标签
        .replaceAll('>', '');

    // ── 第一轮：Markdown 标题 & 引用 & 列表（去符号留内容） ──
    // ## 标题 → 移除 # 号
    cleaned = cleaned.replaceAll(RegExp(r'^#{1,6}\s+', multiLine: true), '');
    // > 引用 → 移除 > 号
    cleaned = cleaned.replaceAll(RegExp(r'^>\s+', multiLine: true), '');
    // - 或 * 无序列表 → 移除标记
    cleaned = cleaned.replaceAll(RegExp(r'^[\s]*[-\*]\s+', multiLine: true), '');
    // 1. 2) 编号列表 → 移除数字标记
    cleaned = cleaned.replaceAll(RegExp(r'^[\s]*\d+[.)]\s*', multiLine: true), '');
    // --- 分隔线
    cleaned = cleaned.replaceAll(RegExp(r'^[-*_]{3,}\s*$', multiLine: true), '');

    // ── 第二轮：Markdown 内联格式（去标记留内容） ──
    // **粗体** → 内容
    cleaned = cleaned.replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'$1');
    // *斜体*（单独的单个星号，不在行首）
    cleaned = cleaned.replaceAll(RegExp(r'(?<!\*)\*([^*\n]+)\*(?!\*)'), r'$1');
    // _下划线_
    cleaned = cleaned.replaceAll(RegExp(r'_([^_\n]+)_'), r'$1');
    // ~~删除线~~
    cleaned = cleaned.replaceAll(RegExp(r'~~([^~]+)~~'), r'$1');

    // ── 第二轮·五：残留 LaTeX 命令（在 $ 块之外的独立命令） ──
    cleaned = _translateLatex(cleaned);

    // ── 第三轮：按是否需要保留 emoji 分流处理 ──
    if (keepEmoji) {
      // 显示模式：只去掉技术符号，保留教学 emoji
      cleaned = cleaned
          // 去掉残留的 * # - 等格式化符号
          .replaceAll(RegExp(r'[#*\-|~`]'), ' ')
          // 去掉不可见字符
          .replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), '')
          // 去掉 LaTeX 专用符号
          .replaceAll('&', '')
          .replaceAll('^', ' ')
          .replaceAll('_', ' ')
          .replaceAll(RegExp(r'[\{\}\[\]\\]'), ' ');
    } else {
      // TTS 模式：去掉一切特殊符号
      cleaned = cleaned
          .replaceAll(RegExp(r'[#\$*\-|~>`]'), ' ')
          .replaceAll('&', '')
          .replaceAll('^', ' ')
          .replaceAll('_', ' ')
          .replaceAll(RegExp(r'[\{\}\[\]\\]'), ' ')
          .replaceAll(RegExp(r'─+'), ' ')
          // 去掉教学 emoji
          .replaceAll(RegExp(r'[\u2600-\u27BF]'), ' ')
          .replaceAll(RegExp(r'[\uD83C-\uDBFF\uDC00-\uDFFF]+'), ' ')
          .replaceAll(RegExp(r'[\u2000-\u2BFF]'), ' ')
          .replaceAll(RegExp(r'[\uFE0F]'), '')
          .replaceAll(RegExp(r'[\u00A9\u00AE]'), ' ');
    }

    // ── 第四轮：规范化空白 ──
    cleaned = cleaned
        .replaceAll(RegExp(r'[ \t]{2,}'), ' ')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();

    return cleaned;
  }

  // ==================== LaTeX 命令翻译引擎 ====================

  /// 将 LaTeX 数学命令翻译为中文自然语言
  static String _translateLatex(String text) {
    // —— 结构命令（需要正则替换） ——
    // 分数: \frac{a}{b} → a分之b
    text = text.replaceAllMapped(
      RegExp(r'\\frac\{([^}]+)\}\{([^}]+)\}'),
      (m) => '${m.group(1)}分之${m.group(2)}',
    );
    // 根号: \sqrt{n} → 根号n, \sqrt[n]{x} → n次根号x
    text = text.replaceAllMapped(
      RegExp(r'\\sqrt(?:\[([^\]]+)\])?\{([^}]+)\}'),
      (m) => m.group(1) != null
          ? '${m.group(1)}次根号${m.group(2)}'
          : '根号${m.group(2)}',
    );
    // 上标: a^{b} → a的b次方
    text = text.replaceAllMapped(
      RegExp(r'(\w+)\^\{([^}]+)\}'),
      (m) => '${m.group(1)}的${m.group(2)}次方',
    );
    // 下标: a_{b} → a下标b
    text = text.replaceAllMapped(
      RegExp(r'(\w+)_\{([^}]+)\}'),
      (m) => '${m.group(1)}下标${m.group(2)}',
    );
    // \text{...} → 直接内容
    text = text.replaceAllMapped(
      RegExp(r'\\text\{([^}]+)\}'),
      (m) => '${m.group(1)}',
    );

    // —— 字典命令（直接替换） ——
    const cmds = <String, String>{
      // 箭头
      r'\rightarrow': '→', r'\leftarrow': '←',
      r'\Rightarrow': '⇒', r'\Leftarrow': '⇐',
      r'\leftrightarrow': '↔', r'\uparrow': '↑', r'\downarrow': '↓',
      r'\to': '→', r'\mapsto': '↦',
      // 集合与逻辑
      r'\mid': '满足', r'\cap': '交', r'\cup': '并',
      r'\subset': '包含于', r'\supset': '包含',
      r'\subseteq': '⊆', r'\supseteq': '⊇',
      r'\in': '∈', r'\notin': '∉', r'\emptyset': '∅',
      r'\forall': '∀', r'\exists': '∃',
      r'\therefore': '∴', r'\because': '∵',
      // 几何
      r'\angle': '∠', r'\triangle': '△',
      r'\parallel': '∥', r'\perp': '⊥',
      r'\sim': '∼', r'\cong': '≅',
      r'\circ': '°', r'\degree': '°',
      // 运算符
      r'\pm': '±', r'\mp': '∓',
      r'\times': '×', r'\div': '÷', r'\cdot': '·',
      r'\equiv': '≡', r'\approx': '≈',
      r'\neq': '≠', r'\leq': '≤', r'\geq': '≥',
      r'\ll': '≪', r'\gg': '≫',
      r'\propto': '∝', r'\infty': '∞',
      r'\partial': '∂', r'\nabla': '∇',
      // 微积分
      r'\sum': 'Σ', r'\int': '∫', r'\prod': '∏',
      r'\lim': 'lim', r'\limsup': 'limsup', r'\liminf': 'liminf',
      // 省略号
      r'\ldots': '...', r'\cdots': '...',
      r'\vdots': '⋮', r'\ddots': '⋱',
      // 希腊字母
      r'\alpha': 'α', r'\beta': 'β', r'\gamma': 'γ',
      r'\delta': 'δ', r'\theta': 'θ', r'\pi': 'π',
      r'\sigma': 'σ', r'\lambda': 'λ', r'\mu': 'μ',
      r'\omega': 'ω', r'\phi': 'φ', r'\epsilon': 'ε',
      r'\rho': 'ρ', r'\eta': 'η', r'\tau': 'τ',
      r'\zeta': 'ζ', r'\kappa': 'κ', r'\xi': 'ξ',
      r'\Gamma': 'Γ', r'\Delta': 'Δ', r'\Theta': 'Θ',
      r'\Lambda': 'Λ', r'\Sigma': 'Σ', r'\Omega': 'Ω',
      // 三角函数 & 对数
      r'\sin': 'sin', r'\cos': 'cos', r'\tan': 'tan',
      r'\cot': 'cot', r'\sec': 'sec', r'\csc': 'csc',
      r'\arcsin': 'arcsin', r'\arccos': 'arccos', r'\arctan': 'arctan',
      r'\log': 'log', r'\ln': 'ln', r'\lg': 'lg',
      // 空格等
      r'\quad': '  ', r'\qquad': '    ',
      r'\ ': ' ', r'\;': ' ', r'\,': ' ', r'\!': '',
      // 括号变大
      r'\left': '', r'\right': '', r'\big': '', r'\Big': '',
      r'\bigl': '', r'\bigr': '', r'\Bigl': '', r'\Bigr': '',
      // 向量/装饰 → 去掉
      r'\vec': '', r'\hat': '', r'\bar': '', r'\tilde': '',
      r'\widehat': '', r'\overline': '', r'\underline': '',
      r'\dot': '', r'\ddot': '', r'\check': '', r'\breve': '',
      // 矩阵
      r'\begin': '', r'\end': '', r'\matrix': '', r'\pmatrix': '',
      r'\bmatrix': '', r'\vmatrix': '',
      // 其他常见
      r'\mathbb': '', r'\mathcal': '', r'\mathbf': '', r'\mathrm': '',
      r'\mathit': '', r'\mathsf': '', r'\mathtt': '',
      r'\boxed': '', r'\displaystyle': '', r'\textstyle': '',
    };

    // 按长度降序替换，防止短命令误匹配长命令
    // 例如 \rightarrow 必须在 \to 之前替换
    final sortedKeys = cmds.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    for (final cmd in sortedKeys) {
      text = text.replaceAll(cmd, cmds[cmd]!);
    }

    // —— 清理残留 ——
    text = text.replaceAll('\\', '');
    text = text.replaceAll(RegExp(r'\s{2,}'), ' ');

    return text.trim();
  }
}
