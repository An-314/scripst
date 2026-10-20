// Compile from the package root:
// typst compile --root . docs/beamer.typ
// typst compile --root . --input handout=true docs/beamer.typ
#import "../src/main.typ": *
#import slides: *

#let sans = ("Noto Sans", "Noto Sans CJK SC")
#let handout = sys.inputs.at("handout", default: "false") == "true"

#show: scripst.with(
  template: "beamer",
  title: [Scripst Beamer 使用手册],
  info: [字体、页面、动画与科学排版],
  author: ("Scripst",),
  time: [1.2.0],
  lang: "zh",
  font-size: 18pt,
  countblock-lang: "zh",
  matheq-depth: 1,
  counter-depth: 1,
  cb-counter-depth: 1,
  fonts: (
    body: sans, title: sans, heading: sans, strong: sans,
    author: sans, header: sans, countblock: sans,
    caption: sans, emph: sans, quote: sans,
    raw: ("DejaVu Sans Mono", "Noto Sans CJK SC"),
    math: "New Computer Modern Math",
  ),
  link-color: rgb("215B63"),
  beamer: (
    short-title: [Beamer 使用手册],
    institution: [基于 Touying 0.8.0 / Stargazer],
    section-slides: false,
    handout: handout,
    colors: (primary: rgb("215B63"), primary-dark: rgb("163F46")),
  ),
)

// All source examples remain editable fenced raw blocks.
#show raw.where(block: true): set text(size: 12pt)
#show raw.where(block: true): set par(leading: 0.45em, spacing: 0.5em)
#show table: set text(size: 14pt)
#show table: set par(leading: 0.45em, spacing: 0.4em)

#title-slide()
#outline-slide(title: [本手册的内容], numbered: false)

= 入门

#slide(title: [模板结构与安装])[
  Scripst 统一字体、数学工具和编号。Touying 负责幻灯片布局与逐步显示，
  本版本采用 Stargazer 主题。

  - 编译器：*Typst 0.15.0 或更新版本*。
  - 演示依赖：*Touying 0.8.0*，由 Scripst 自动导入。
  - 字体需在本机安装或上传到网页项目，包内不附带字体。

  ```typst
  #import "@preview/scripst:1.2.0": *
  #import slides: *
  ```

  `slides` 是独立命名空间。普通文章无需导入它。Beamer 模板会自动配置
  Stargazer，无需再添加主题 show 规则，也不兼容 LaTeX Beamer 源码。
]

#slide(title: [一个可以直接编译的最小文件])[
  ```typst
  #import "@preview/scripst:1.2.0": *
  #import slides: *

  #show: scripst.with(
    template: "beamer",
    title: [报告标题], author: ("作者",),
    beamer: (section-slides: false),
  )

  #title-slide()
  = 研究问题
  #slide(title: [第一张正文页])[
    - 说明研究对象。
    - 给出需要回答的问题。
  ]
  ```
  封面需要手动调用 `title-slide()`。本手册源码用相对路径导入仓库中的
  `src/main.typ`，已安装的包则使用上方 `@preview` 路径。
]

#slide(title: [共享参数：信息与语言])[
  #three-line-table[
    | 参数 | 默认值 | Beamer 中的用途 |
    | :--- | :--- | :--- |
    | `title` / `info` | `""` / `""` | 封面标题 / 副标题 |
    | `author` | `()` | 作者数组，也接受单个作者内容 |
    | `time` | `""` | 日期内容，也支持 `datetime` |
    | `lang` | `"zh"` | 正文语言 |
    | `countblock-lang` | `"en"` | 内置编号块的名称语言 |
  ]

  ```typst
  #show: scripst.with(
    template: "beamer",
    title: [报告标题], info: [副标题],
    author: ([甲], [乙]), time: datetime(year: 2026, month: 10, day: 19),
    lang: "zh", countblock-lang: "zh",
  )
  ```
  两个语言参数相互独立。中文正文仍可保留英文的 Definition、Theorem 块名。
]

#slide(title: [共享参数：排版与编号])[
  #three-line-table[
    | 参数 | 默认值 | Beamer 中的实际效果 |
    | :--- | :--- | :--- |
    | `font-size` | `auto` | `20pt`，本手册显式设为 `18pt` |
    | `par-indent` | `auto` | `0em`，不做首行缩进 |
    | `par-leading` / `par-spacing` | `none` / `none` | `0.65em` / `0.7em` |
    | 三种 `*-depth` | `2` | 公式、figure、countblock 分别设置 |
    | `matheq-outline` / `counter-outline` | `"(1.1)"` / `"1.1"` | 公式 / 其他编号格式 |
    | `numbering-format` / `offset` | `none` / `0` | 标题编号 / Ratchet 章节起点偏移 |
  ]

  `link-color: blue` 仅改变外部 URL，主题导航保留原配色。
  `ref-color: red` 控制普通引用，Ratchet 的编号引用使用
  `matheq-color: red` 与 `counter-color: blue`。

  文章模板的自动字号仍为 `11pt`，首行缩进仍为 `2em`。
]

= 字体与主题

#slide(title: [字体配置与局部覆盖])[
  ```typst
  #let sans = ("Noto Sans", "Noto Sans CJK SC")
  #show: scripst.with(
    template: "beamer", font-size: 20pt,
    fonts: (
      body: sans, title: sans, heading: sans,
      strong: sans, author: sans, countblock: sans,
      raw: ("DejaVu Sans Mono", "Noto Sans CJK SC"),
      math: "New Computer Modern Math",
    ),
  )
  ```

  - `fonts` 只需填写需要覆盖的用途，其他用途保留默认字体。
  - 一个值可以是字体名、字体描述字典或它们组成的非空数组。
  - 数组按顺序回退。`auto` 恢复默认值或该用途的继承关系。
  - 未知用途名会报错。仅改变 `body` 不会改变独立配置的标题或块字体。
]

#slide(title: [字体角色与继承关系])[
  #three-line-table[
    | 用途 | 默认字体或继承 | Beamer 使用位置 |
    | :--- | :--- | :--- |
    | `body`, `countblock` | S | 正文与编号块正文 |
    | `title`, `heading`, `strong` | H | 封面、页标题与粗体 |
    | `author`, `caption`, `emph`, `quote` | K | 作者、图注、强调与引语 |
    | `info` | 跟随 `title` | 封面副标题 |
    | `time`, `table` | 跟随 `body` | 日期与表格 |
    | `header` | Linux Libertine / SimSun | 页脚的短标题 |
    | `raw` / `math` | Consolas + SimSun / `auto` | 代码 / Typst 默认数学字体 |
  ]

  #text(size: 14pt)[
    S = CMU Serif / Linux Libertine / SimSun，H 的中文回退为 SIMHEI，
    K 的中文回退为 KaiTi。`info` 在 article 中跟随 `author`，在 book/report/beamer 中跟随 `title`。
    `abstract`、`preface`、`contents` 跟随 `body`，`keywords` 跟随 `emph`，但这些文章区域不会自动出现在幻灯片里。
  ]
]

#slide(title: [代码字号跟随所在位置])[
  行内代码与代码块默认继承周围字号。先设置模板，再添加自己的代码样式。
  主函数 `font-size` 和页内 `set text(size: ...)` 都会生效。

  ```typst
  #show: scripst.with(template: "beamer", font-size: 20pt)
  // 只覆盖代码块，行内代码继续跟随正文。
  #show raw.where(block: true): set text(size: 12pt)

  #slide(title: [单页字号])[
    #set text(size: 18pt)
    正文与 `行内代码` 使用 18pt。
  ]
  ```

  `#show raw: set text(size: 12pt)` 会同时覆盖行内与块级代码。
  `fonts.raw` 只选择字体家族，不控制字号。

  本手册明确将代码块设为 `12pt`，正文设为 `18pt`，表格设为 `14pt`。
]

#slide(title: [Beamer 字典：页面与运行模式])[
  这五项与下一页五项组成全部 *10 个配置键*。未填写的项使用默认值，未知键报错。

  #three-line-table[
    | 键 | 默认值 | 作用 |
    | :--- | :--- | :--- |
    | `aspect-ratio` | `"16-9"` | 也可选 `"4-3"`、`"16-10"` |
    | `align` | `top` | 内容从上方开始，也可选 `horizon` |
    | `progress-bar` | `false` | 页脚底部显示进度条 |
    | `handout` | `false` | 开启后保留每个逻辑页的最后状态 |
    | `section-slides` | `true` | 一级标题自动产生章节过渡页 |
  ]

  ```typst
  #show: scripst.with(
    template: "beamer",
    beamer: (aspect-ratio: "16-9", align: top,
      section-slides: false, progress-bar: true, handout: false),
  )
  ```
]

#slide(title: [Beamer 字典：身份、配色与扩展])[
  #three-line-table[
    | 键 | 默认值 | 作用 |
    | :--- | :--- | :--- |
    | `institution` | `none` | 封面的单位，接受富文本 |
    | `logo` | `none` | logo 内容，例如 `image(...)` |
    | `short-title` | `auto` | 页脚短标题，自动时使用完整 `title` |
    | `colors` | `(:)` | Touying 颜色字典，不填则使用 Stargazer 默认配色 |
    | `config` | `()` | 额外 Touying 配置字典的数组 |
  ]

  ```typst
  beamer: (
    institution: [单位名称], short-title: [报告简称],
    logo: image("logo.svg", width: 1.5cm),
    colors: (primary: rgb("215B63"), primary-dark: rgb("163F46")),
  ),
  ```
  将以上片段放入主函数参数列表。使用 `logo` 时需准备自己的图片文件。
]

= 页面与动画

#slide(title: [slide 接口与逐页设置])[
  #three-line-table[
    | 参数 | 默认值 | 用法 |
    | :--- | :--- | :--- |
    | `title` | `auto` | 自动取当前标题，也可给内容或 `none` |
    | `header` / `footer` / `align` | `auto` | 逐页覆盖主题的页眉、页脚、对齐 |
    | `config` | `(:)` | 本页 Touying 配置字典 |
    | `repeat` | `auto` | 自动计算状态数，可显式指定 |
    | `setting` | 恒等函数 | 仅作用于此页的 set/show 包装 |
    | `composer` | `auto` | 栏宽数组、栏数或自定义排版函数 |
  ]

  ```typst
  #slide(title: [局部设置], align: horizon,
    setting: body => { set text(size: 18pt); body },
  )[
    这一页垂直居中，正文使用 18pt。
  ]
  ```
]

#slide(title: [两栏布局：每个内容参数是一栏], composer: (3fr, 2fr))[
  ```typst
  #slide(title: [模型与测量],
    composer: (3fr, 2fr),
  )[
    $ ket(psi) = alpha ket(0)
      + beta ket(1) $
  ][
    - $P(0) = abs(alpha)^2$
    - $P(1) = abs(beta)^2$
  ]
  ```
  栏宽比例为 3:2。`composer: 2` 则建立两个等宽栏。
][
  *本页也是实际两栏*

  左栏保留可编辑的完整代码，右栏可以放解释、图片或表格。

  - 每个 `[...]` 对应一栏。
  - 各栏可独立 `set text`。
  - 多栏内容过高时应拆页。
]

#slide(title: [标题自动分页与目录])[
  ```typst
  #title-slide()
  #outline-slide(title: [目录], numbered: false)

  = 研究背景
  == 模型
  这一段自动成为“模型”页的正文。

  == 测量
  这里进入下一张幻灯片。
  ```

  默认一级标题组织章节，二级标题开启正文页。
  `section-slides: true` 还会为一级标题生成过渡页。

  `outline-slide()` 根据标题结构建立目录。显式 `slide(title: [...])`
  的标题本身不会自动成为目录项。本手册用一级标题组织导航，正文页采用显式 `slide`。
]

#slide(title: [pause：一个逻辑页的两个状态])[
  ```typst
  #slide(title: [分步推导])[
    先给出归一化条件。
    #pause
    再说明两种测量结果的概率之和为 1。
  ]
  ```

  *状态 1*　归一化条件：$abs(alpha)^2 + abs(beta)^2 = 1$。

  #pause

  *状态 2*　测量概率为 $P(0) = abs(alpha)^2$、$P(1) = abs(beta)^2$，
  所以 $P(0) + P(1) = 1$。

  `pause` 位于完整内容之间。PDF 增加一页，但页脚的逻辑页编号保持不变。
]

#slide(title: [only 与 uncover：隐藏时是否保留空间])[
  ```typst
  #slide(title: [显示范围], repeat: 3)[
    #only(1)[仅在第 1 步显示，隐藏时不占空间。]
    #uncover("2-")[从第 2 步起显示，隐藏时保留空间。]
    #uncover(3)[仅在第 3 步显示。]
  ]
  ```

  - `only` 移除不可见内容，适合在同一位置切换说明。
  - `uncover` 保留布局空间，适合推导过程保持位置稳定。
  - 范围可写整数、数组 `(1, 3)` 或字符串 `"2-"`、`"1, 3-5"`。
  - 回调式动画无法自动推断所有状态时，显式给出 `repeat`。

  `meanwhile` 可从当前逻辑页的第一步重新安排后续显示。复杂动画以 Touying 文档为准。
]

#slide(title: [讲义模式与其他页面工具])[
  ```typst
  #let handout = sys.inputs.at("handout", default: "false") == "true"
  #show: scripst.with(
    template: "beamer", beamer: (handout: handout),
  )
  ```

  开启 `handout: true` 后，默认只保留各逻辑页的最后状态。它不会把多页缩略图拼到一张纸上。
  本手册支持编译参数 `--input handout=true`。

  #three-line-table[
    | 工具 | 用途 |
    | :--- | :--- |
    | `tblock(title: [...])[...]` | Stargazer 展示块，没有 Scripst 编号 |
    | `focus-slide[...]` / `ending-slide[...]` | 强调页 / 结束页 |
    | `speaker-note[...]` | 按 Touying 规则附着于前面的幻灯片 |
    | `#show: appendix` | 将后续内容设为附录 |
  ]
]

= 编号与科学排版

#slide(title: [Countblock 与单次 breakable])[
  ```typst
  #definition(subname: [归一化态], lab: "state",
    breakable: false,
  )[
    $ ket(psi) = alpha ket(0) + beta ket(1) $
  ]
  由 @state 可继续计算期望值。
  #note(count: false)[这是一条不编号的注记。]
  ```

  #three-line-table[
    | 参数 | 默认值 | 说明 |
    | :--- | :--- | :--- |
    | `subname` | `""` | 附加标题，支持字符串或内容 |
    | `count` | `true` | 是否计数，`note` / `caution` 默认 `false` |
    | `lab` | `none` | 字符串标签，用于 `@label` 引用 |
    | `breakable` | `true` | 仅控制本次调用的可见块是否允许分页 |
  ]
  演示页空间固定。`breakable: true` 不会自动缩小内容，也不会替你设计下一页。
]

#slide(title: [内置块、语言与共享计数器])[
  #three-line-table[
    | 调用函数 | 中文名称 | 注册键 / 计数器 |
    | :--- | :--- | :--- |
    | `definition` / `theorem` | 定义 / 定理 | `def` / `thm` |
    | `proposition` / `lemma` / `corollary` | 命题 / 引理 / 推论 | `prop`, `lem`, `cor` 共用 `prop` |
    | `remark` / `claim` | 注 / 断言 | `rmk`, `clm` 也共用 `prop` |
    | `exercise` / `problem` / `example` | 练习 / 问题 / 例 | `ex` / `prob` / `eg` |
    | `note` / `caution` | 注记 / 警告符号 | `note` / `cau`，默认不计数 |
  ]

  `countblock-lang` 默认 `"en"`，支持中文、法文、德文、日文等内置语言。
  全部语言名单见文章手册的同名参数。

  同一个计数器的块共享编号与重置深度，名称和颜色仍然独立。
  预设块的深度默认跟随 `cb-counter-depth`，它的默认值是 `2`。
]

#slide(title: [自定义块与本地化名称])[
  ```typst
  #let custom-cb = add-countblock(
    cb, "assumption", (en: "Assumption", zh: "假设"),
    rgb("215B63"), depth: 1,
  )
  #let assumption = countblock.with("assumption", custom-cb)

  #show: scripst.with(
    template: "beamer", countblocks: custom-cb,
    countblock-lang: "zh", beamer: (section-slides: false),
  )
  #slide(title: [模型假设])[
    #assumption(breakable: false)[系统只包含两个能级。]
  ]
  ```

  注册和调用都要使用更新后的字典。名称也可直接传字符串或内容。
  本地化字典缺少所选语言时回退到 `en`。`depth: none` 表示跟随主函数的块深度。
]

#slide(title: [编号深度、缺失标题与局部调整])[
  #three-line-table[
    | 深度 | 编号形式 | 重置条件 |
    | :--- | :--- | :--- |
    | `1` | `1`, `2`, `3` | 全局计数 |
    | `2` | `1.1`, `1.2` | 随一级标题重置 |
    | `3` | `1.1.1`, `1.1.2` | 随一级和二级标题重置 |
  ]

  ```typst
  #let custom-cb = set-countblock-depth(cb, "thm", 1)
  #let custom-cb = set-countblock-depth(custom-cb, "lem", 2, detach: true)
  #let theorem = countblock.with("thm", custom-cb)
  #let lemma = countblock.with("lem", custom-cb)
  // 在主函数中传入 countblocks: custom-cb。
  ```

  `detach: false` 默认一起调整共享计数器的块，`true` 为该块分离计数器。
  深度仅支持 `1`、`2`、`3`。缺少标题层级时保留 `0`，不会自动降深度，
  如 `0.1`、`1.0.1`。短报告通常将三种 `*-depth` 都设为 `1`。
]

#slide(title: [Physica 数学记号与三线表])[
  ```typst
  #definition(subname: [归一化态], breakable: false)[
    $ ket(psi) = alpha ket(0) + beta ket(1) $
    且 $abs(alpha)^2 + abs(beta)^2 = 1$。
  ]
  $ bra(psi) hat(H) ket(psi) = sum_(n=0)^1 E_n abs(c_n)^2 $
  $ integral_(-infinity)^infinity abs(psi(x))^2 dif x = 1 $
  #three-line-table[
    | 结果 | 概率 |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
    | $1$ | $abs(beta)^2$ |
  ]
  ```

  `ket`、`bra` 来自导出的 Physica 工具。积分中的 `dif` 为直立微分符号。
  三线表使用 Scripst 的 `three-line-table`，下一页展示实际排版。
]

#slide(title: [实际排版：量子态与测量], composer: (3fr, 2fr))[
  #definition(subname: [归一化态], lab: "manual-state", breakable: false)[
    $ ket(psi) = alpha ket(0) + beta ket(1) $
    且 $abs(alpha)^2 + abs(beta)^2 = 1$。
  ]

  能量期望值与连续波函数归一化：
  $ bra(psi) hat(H) ket(psi) = sum_(n=0)^1 E_n abs(c_n)^2 $
  $ integral_(-infinity)^infinity abs(psi(x))^2 dif x = 1 $
][
  *测量结果与概率*

  #three-line-table[
    | 结果 | 概率 |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
    | $1$ | $abs(beta)^2$ |
  ]

  由 @manual-state，总概率为 $1$。

  本页实际使用两栏、编号块、公式与三线表，所有内容都保留为 Typst 源码。
]

= 进阶与发布

#slide(title: [Stargazer 紫色参考配置])[
  ```typst
  #show: scripst.with(
    template: "beamer", title: [报告标题],
    beamer: (
      align: horizon, short-title: [报告简称],
      colors: (
        primary: rgb("660099"), primary-dark: rgb("330066"),
        secondary: rgb("9933CC"), tertiary: rgb("CC99FF"),
        neutral-lightest: rgb("FAFAFF"), neutral-darkest: rgb("1E002D"),
      ),
      config: (
        config-page(margin: (top: 3.5em, bottom: 2.5em, x: 2.5em)),
      ),
    ),
  )
  ```

  保留同一 Stargazer 主题，仅替换配色、对齐和边距。
  如需 MiSans 等字体，用主函数 `fonts` 配置并先在环境中安装。
  Touying 0.6.1 与 0.8.0 的封面和过渡页有差异，不保证旧稿逐像素一致。
]

#slide(title: [页脚与页面边距])[
  默认页脚显示作者、日期、报告标题与页码。前三项对应
  `author`、`time`、`beamer.short-title`。

  ```typst
  beamer: (
    short-title: [报告简称],
    config: (
      config-page(margin: (top: 4em, bottom: 2em, x: 2.5em)),
      config-store(
        footer-columns: (20%, 20%, 1fr, 5em),
        footer-a: [作者 / 单位], footer-c: [短标题],
      ),
    ),
  ),
  ```

  上面的边距是 Touying 0.8.0 的 Stargazer 默认值。`config-store` 仅覆盖
  指定的页脚格子，示例保留默认日期与页码。
  自定义页眉、页脚时应为内容留出相应边距，页面设置使用 `config-page`。
]

#slide(title: [高级 config 与编号保护])[
  ```typst
  beamer: (
    config: (
      config-page(margin: (left: 1.2em, right: 1.2em)),
      config-common(frozen-counters: (counter("my-counter"),)),
    ),
  ),
  ```

  - `config` 是配置字典的*数组*，依次合并，单项也要保留末尾逗号。
  - 自定义 `frozen-counters` 会加入 Scripst 所需集合，不会取代它。
  - Scripst 保护章节、公式和 countblock 计数，避免逐步显示重复递增。
  - 字体、讲义模式、章节过渡页使用对应接口，核心初始化由 Scripst 管理。

  不要关闭 Touying 的状态与计数器冻结，也不要用另一条主题 show 规则
  替换初始化。低层配置可能影响布局或编号，改动后应检查普通和讲义两种输出。
]

#slide(title: [文章参数与当前限制])[
  以下文章参数不参与幻灯片生成：

  `header`、`contents`、`content-depth`、`abstract`、`keywords`、
  `preface`、`chapter-numbering-format`。

  封面与目录分别调用 `title-slide()`、`outline-slide()`。

  - *块内动画*：countblock 内部的 `pause` 不受支持，放在两个完整块之间。
  - *长内容*：固定画布不自动容纳超高块，应拆分为多张幻灯片。
  - *引用锚点*：沿用原 countblock 锚点设计。文章分页时，禁止断开的块若整体移到下一页，锚点可能仍在前一页。
  - *版本兼容*：本模板要求 Typst 0.15.0，不能直接用于旧编译器。
]

#slide(title: [构建、示例与进一步阅读])[
  在仓库根目录运行：

  `typst compile --root . docs/beamer.typ`

  `typst compile --root . --input handout=true docs/beamer.typ`

  本手册为 *28 个逻辑页*，其中一页包含 `pause`。普通模式输出 29 页，
  讲义模式输出 28 页。简短可运行示例另见 `docs/examples/beamer.typ`。

  - #link("https://github.com/An-314/scripst/blob/main/docs/beamer.md")[Scripst Beamer 配置说明] 与 `docs/article.typ` 中的完整公共接口。
  - #link("https://touying-typ.github.io/docs/themes/stargazer")[Touying Stargazer 主题]、#link("https://touying-typ.github.io/docs/tutorials/layout")[布局与分栏]。
  - #link("https://touying-typ.github.io/docs/tutorials/dynamic")[逐步显示]、#link("https://touying-typ.github.io/docs/tutorials/settings")[高级配置]。

  本手册源文件可直接修改。英文手册位于 `docs/locale/beamer-en.typ`。
]
