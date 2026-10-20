# Beamer：用 Scripst 编写学术幻灯片

Scripst 1.2.0 的 `template: "beamer"` 基于 **Touying 0.8.0 / Stargazer**，
要求 **Typst 0.15.0 或更新版本**。这里的 beamer 指演示文稿模板，不是 LaTeX
Beamer 源码的兼容层。Scripst 复用现有字体、Physica 数学记号、countblock 与
Ratchet 编号；页面、分栏、目录和逐步显示由 Touying 负责。

## 快速开始

```typst
#import "@preview/scripst:1.2.0": *
#import slides: *

#show: scripst.with(
  template: "beamer",
  title: [报告标题],
  info: [报告副标题],
  author: ("作者",),
  time: [2026 年 10 月],
  lang: "zh",
  countblock-lang: "zh",
  matheq-depth: 1,
  counter-depth: 1,
  cb-counter-depth: 1,
  beamer: (
    institution: [你的单位],
    short-title: [报告简称],
  ),
)

#title-slide()

= 研究问题

#slide(title: [研究对象])[
  #definition[在正交归一基下，$ket(psi) = alpha ket(0) + beta ket(1)$。]
]

#slide(title: [逐步展示])[
  - 先写出量子态。
  #pause
  - 再计算观测量。
]
```

`slides` 是 Scripst 导出的独立命名空间，普通文章不必导入它。若不希望引入
额外短名称，也可以只导入所需函数，例如 `#import slides: slide, title-slide, pause`。
不需要再次导入 Touying，也不要同时安装另一条 `#show: stargazer-theme`。

## 主函数参数

通用设置仍写在 `scripst.with(...)` 中，演示专用设置集中在 `beamer: (...)`。

| 主函数参数 | Beamer 中的含义或默认值 |
| --- | --- |
| `title` / `info` | 封面主标题 / 副标题 |
| `author` / `time` | 作者与日期；作者支持数组，日期也可使用 `datetime` |
| `fonts` | 沿用按用途分配字体的接口，包括 `body`、`heading`、`countblock`、`math` 等 |
| `font-size: auto` | beamer 解析为 `20pt`；article/book/report 仍为 `11pt` |
| `par-indent: auto` | beamer 解析为 `0em`；article/book/report 仍为 `2em` |
| `par-leading: none` | beamer 使用 `0.65em` |
| `par-spacing: none` | beamer 使用 `0.7em` |
| `lang` | 正文语言；默认仍为 `"zh"` |
| `countblock-lang` | 块名语言；默认仍为 `"en"`，与正文语言独立 |
| `matheq-depth` / `counter-depth` / `cb-counter-depth` | 仍默认 `2`；短报告可显式设 `1`，使用全局编号 |
| `matheq-outline` / `counter-outline` | 公式和 figure/countblock 的编号格式 |
| `numbering-format` / `offset` | 标题显示的编号格式 / Ratchet 章节编号起点偏移 |
| `link-color` / `ref-color` | 外部链接与普通引用颜色；主题内部导航保留主题配色 |
| `matheq-color` / `counter-color` | Ratchet 公式和 figure 编号引用颜色 |

字体不会随包分发。示例选择 Noto Sans、Noto Sans CJK SC、New Computer
Modern Math；可安装这些字体，也可通过 `fonts` 替换。只设 `fonts.body` 不会覆盖
独立配置的标题、粗体或 countblock 字体，详见[字体说明](./fonts.typ)。

行内代码和代码块默认跟随所在位置的字号，主函数的 `font-size` 和页内的
`set text(size: ...)` 均会生效。需单独指定代码字号时，在模板 show 规则之后
使用 `#show raw: set text(size: 10pt)`；只调整代码块可选择 `raw.where(block: true)`。

文章的 `header`、`contents`、`content-depth`、`abstract`、`keywords`、`preface`、
`chapter-numbering-format` 不参与 beamer 的页面生成。封面和目录需要显式调用
`title-slide()`、`outline-slide()`；不会自动插入文章封面或页眉。

## `beamer` 字典

只写需要调整的项即可，未指定的项采用以下默认值；未知键会报错。

| 键 | 默认值 | 用途 |
| --- | --- | --- |
| `aspect-ratio` | `"16-9"` | 页面宽高比；也可使用 `"4-3"`、`"16-10"` |
| `institution` | `none` | 封面的单位信息，支持富文本 |
| `logo` | `none` | 交给 Stargazer 的 logo 内容，例如 `image("logo.svg", width: 2cm)` |
| `short-title` | `auto` | 页脚标题；`auto` 表示使用完整 `title` |
| `colors` | `(:)` | Touying 配色字典；不传时使用 Stargazer 默认配色 |
| `progress-bar` | `false` | 是否显示底部进度条 |
| `handout` | `false` | 讲义模式；默认每个逻辑页只保留最后一个逐步显示状态 |
| `section-slides` | `true` | 一级标题是否自动产生章节过渡页 |
| `align` | `top` | 幻灯片内容的垂直对齐，可改为 `horizon` |
| `config` | `()` | 额外 Touying 配置字典的数组，见下文 |

例如：

```typst
#show: scripst.with(
  template: "beamer",
  title: [报告标题],
  beamer: (
    aspect-ratio: "16-9",
    short-title: [短标题],
    colors: (
      primary: rgb("215B63"),
      primary-dark: rgb("163F46"),
    ),
    section-slides: false,
    progress-bar: true,
  ),
)
```

颜色键沿用 [Touying 配色接口](https://touying-typ.github.io/docs/tutorials/settings)，
可用 `primary`、`primary-dark`、`secondary`、`tertiary`、`neutral-lightest`、
`neutral-darkest` 等。尽量用少量主色，图片与公式保留足够的对比度。

## 组织页面与分栏

常用函数来自 `#import slides: *`：

| 函数 / 标记 | 用途 |
| --- | --- |
| `title-slide()` | 显式生成封面 |
| `outline-slide()` | 显式生成基于文档标题的目录 |
| `slide(title: [...])[...]` | 一张常规幻灯片 |
| `slide(composer: (...))[...][...]` | 多栏幻灯片，每个内容参数对应一栏 |
| `tblock(title: [...])[...]` | Stargazer 风格的展示块；不是 Scripst 的编号块 |
| `pause` / `meanwhile` | 后续内容延迟显示 / 从当前逻辑页第一步重新安排显示 |
| `only(...)` / `uncover(...)` | 按步骤显示；分别不保留 / 保留隐藏内容所占空间 |
| `speaker-note[...]` | 讲者备注，按 Touying 规则附着于前面的幻灯片 |
| `#show: appendix` | 将后续内容设为附录 |

分栏示例：

```typst
#slide(title: [模型与测量], composer: (3fr, 2fr))[
  $ ket(psi) = alpha ket(0) + beta ket(1) $
][
  - $P(0) = abs(alpha)^2$
  - $P(1) = abs(beta)^2$
]
```

也支持 Touying 的标题式写法：一级标题用于章节、二级标题用于正文幻灯片。
例如 `= 研究背景` 后写 `== 模型` 及其正文。如果只使用 `slide(title: ...)`，
不要假设每个显式页标题都会成为目录项；需要目录时，请写出章节/标题结构。

## 编号、动画与长内容

保留 Scripst 的 `definition`、`theorem`、`note` 等调用方式；单次调用仍可设置
`breakable: false`。编号由 Ratchet 管理，Scripst 会将其章节、公式及 countblock
计数器加入 Touying 的动画计数保护，让同一逻辑页的逐步显示不会重复编号。

```typst
#slide(title: [两条结论])[
  #theorem(lab: "result", breakable: false)[第一条结论。]
  #pause
  #note[第二步展示整个注记块；可以引用 @result。]
]
```

请将 `pause` 放在完整 Scripst 块之间。**本接口不承诺解析 countblock 内部的动画**：
例如 `#theorem[前半句 #pause 后半句]` 不属于支持写法。为支持 beamer，并未改写
countblock 原有的 content、context 或引用锚点结构。

不要混淆两种跨页控制：`theorem(breakable: ...)` 控制单个块，
Touying 的 `config-common(breakable: ...)` 控制整个逻辑页溢出。过多内容建议
主动拆成两张 `slide`，而不是依赖缩小字号或裁切。`breakable: false` 也不会使
超高的块自动缩放到页内。

## 高级 Touying 配置

`beamer.config` 是配置字典的数组，不是单个字典。例如设置页面边距或额外的
自定义计数器：

```typst
#show: scripst.with(
  template: "beamer",
  beamer: (
    config: (
      config-page(margin: (left: 1.2em, right: 1.2em)),
      config-common(frozen-counters: (counter("my-counter"),)),
    ),
  ),
)
```

配置按数组顺序合并。Scripst 自己的初始化和编号保护仍由包管理；额外
`frozen-counters` 会加入所需计数器集合，而非取代它。`handout`、章节过渡页、
字体与核心初始化请使用 Scripst 的对应接口，不要通过 `config` 替换这些设置。
修改页面时用 `config-page`，不要另写 `set page` 与 Touying 竞争页面管理。

讲义模式直接设置 `beamer: (handout: true)`。这会减少逐步显示生成的 PDF 页数，
不等同于文章模板，也不是在一张纸上排多张缩略图。

## 复现原 Stargazer 紫色演示风格

原来的演示使用 Touying 0.6.1 的 Stargazer；现在仍是同一主题，不需要再套
另一条主题 show rule。下面将原来的紫色配色、MiSans 正文、垂直居中和页边距
迁移到 Scripst 的接口，标题、作者和单位换成自己的内容即可：

```typst
#import "@preview/scripst:1.2.0": *
#import slides: *

#let hei = ("CMU Serif", "Linux Libertine", "SimHei")
#let kai = ("CMU Serif", "Linux Libertine", "KaiTi")

#show: scripst.with(
  template: "beamer",
  title: [报告标题],
  info: [报告副标题],
  author: ([作者],),
  time: [2026/10/01],
  font-size: 20pt,
  fonts: (
    body: "MiSans",
    title: hei,
    heading: hei,
    author: kai,
    emph: kai,
    strong: hei,
    caption: kai,
    raw: "Consolas",
  ),
  numbering-format: "1.1",
  matheq-depth: 1,
  link-color: rgb("660099"),
  beamer: (
    aspect-ratio: "16-9",
    align: horizon,
    institution: [你的单位],
    // logo: image("logo.svg", width: 4cm),
    progress-bar: false,
    colors: (
      primary: rgb("660099"),
      primary-dark: rgb("330066"),
      secondary: rgb("9933CC"),
      tertiary: rgb("CC99FF"),
      neutral-lightest: rgb("FAFAFF"),
      neutral-darkest: rgb("1E002D"),
    ),
    config: (
      config-page(margin: (top: 3.5em, bottom: 2.5em, x: 2.5em)),
    ),
  ),
)

#title-slide()

= 研究背景

#slide(title: [研究问题], composer: (3fr, 2fr))[
  #set text(size: 16pt)
  #tblock(title: [问题])[
    - 第一项：描述研究对象。
    - 第二项：给出需要回答的问题。
  ]
][
  $ ket(psi) = alpha ket(0) + beta ket(1) $
]
```

这些字体需要在编译环境中安装；也可以替换成自己已有的字体。`align: horizon`
恢复旧例的垂直居中；若希望内容从页顶开始，就保留 Scripst 默认的 `top`。
示例显式使用旧版正文页边距，而 Touying 0.8.0 的主题默认值是
`(top: 4em, bottom: 2em, x: 2.5em)`。不同内容密度下可以自行选择。
0.6.1 到 0.8.0 的封面作者布局、章节过渡页等也有上游调整，因此这是同款风格的
迁移配置，**不保证与旧版逐像素一致**。

默认页脚依次为作者、日期、报告标题和页码；前三项分别由 `author`、`time`、
`beamer.short-title` 控制。需要修改列宽或独立内容时，可以在上面的 `config`
数组中再加入一项：

```typst
config-store(
  footer-columns: (20%, 20%, 1fr, 5em),
  footer-a: [自定义作者区],
  footer-c: [报告简称],
),
```

这会保留默认日期和页码，只覆盖指定的两格。若只是缩短页脚标题，直接设置
`short-title: [报告简称]` 更简单。页脚配置与上面的紫色主题示例均已使用
Touying 0.8.0 编译验证。

原例各页的局部字号设置仍可照用；例如下面只改变一张幻灯片的正文和代码块，
不会影响其他页。`10pt` 是显式选择，不是包额外缩小代码字体：

````typst
#slide(title: [单页字号设置])[
  #set text(size: 16pt)
  #show raw.where(block: true): set text(size: 10pt)

  这一页的正文使用 16pt，下面的代码块显式使用 10pt。

  ```typst
  #let probability(alpha) = calc.pow(calc.abs(alpha), 2)
  ```
]
````

## 手册、短示例与构建

- 完整幻灯片手册：[中文 PDF](./builds/beamer.pdf)（[源码](./beamer.typ)）、[英文 PDF](./locale/builds/beamer-en.pdf)（[源码](./locale/beamer-en.typ)）。
- 独立量子力学短示例：[中文](./examples/beamer.typ)、[英文](./examples/beamer-en.typ)。

正式手册与 article、book、report 一同维护，覆盖参数默认值、字体、页面组织、
分栏、动画、编号与主题配置；短示例适合直接复制修改。
这些源码通过相对路径引用当前 `src/main.typ`。在仓库根目录运行：

```sh
make doc       # 全部中英文手册
make demo      # 独立短示例
make preview thumbnail

# 也可单独构建讲义模式（每个逻辑页保留最终状态）
typst compile --root . --input handout=true docs/beamer.typ /tmp/beamer-handout.pdf
```

构建工具需要 Python 3.11+、Typst 0.15.0+；预览图缩放还需要 ImageMagick。
`make` 会使用临时包路径将当前检出的 Scripst 注册为清单中的版本，
同时保留用户安装的其他包，不会改写已有安装。
这套构建流程已在 Linux 验证。构建脚本使用符号链接，Windows 需要开发者模式或相应权限；Windows 构建尚未实测。
两份短示例各包含五个逻辑页，其中一页逐步显示一次，因此普通模式输出六页 PDF。

## 上游文档

- [Touying 0.8.0 on Typst Universe](https://typst.app/universe/package/touying/)
- [Stargazer theme](https://touying-typ.github.io/docs/themes/stargazer)
- [Page layout and columns](https://touying-typ.github.io/docs/tutorials/layout)
- [Settings and frozen counters](https://touying-typ.github.io/docs/tutorials/settings)
- [Simple animations](https://touying-typ.github.io/docs/tutorials/dynamic/simple)
- [Touying changelog and migration guide](https://github.com/touying-typ/touying/blob/main/changelog.md)

在线文档可能随上游更新；遇到差异时，以本包固定的 Touying 0.8.0 API 为准。
