#pagebreak(weak: true)

== fonts：按用途配置字体 <font-settings>

从 Scripst 1.2.0 开始，可以通过主函数的 `fonts` 字典配置字体，无需修改包源码。
默认值是空字典 `(:)`：只覆盖传入的项，其余保留默认值。
`font-size` 仍用于设置字号，`fonts` 只负责字体族。

```typst
#import "@preview/scripst:1.2.0": *
#show: scripst.with(
  fonts: (
    body: ("Libertinus Serif", "Noto Serif CJK SC"),
    heading: ("Libertinus Sans", "Noto Sans CJK SC"),
    countblock: ("Libertinus Serif", "Noto Serif CJK SC"),
    raw: ("DejaVu Sans Mono", "Noto Sans CJK SC"),
    math: "New Computer Modern Math",
  ),
)
```

每项支持字体名称字符串、字体描述字典（如 `(name: "SimSun", covers: "latin-in-cjk")`），
或由这些值组成的非空数组。数组按照从前到后的顺序寻找包含所需字符的字体，
可以分别安排西文和中文字体。字体需在本地安装，或上传到 Typst 网页项目；Scripst 不附带字体文件。

下表用以下缩写表示默认字体列表：

- S：`("CMU Serif", "Linux Libertine", "SimSun")`
- H：`("CMU Serif", "Linux Libertine", "SIMHEI")`
- K：`("CMU Serif", "Linux Libertine", "KaiTi")`

#table(
  columns: (auto, 1fr, 1fr),
  table.header([字段], [用途], [默认值 / 继承关系]),
  [`body`], [正文、普通列表和页码], [S],
  [`title`], [文档标题 / 封面标题], [H],
  [`info`], [副标题], [article 跟随 `author`；book/report 跟随 `title`],
  [`author`], [作者], [K],
  [`time`], [日期], [跟随 `body`],
  [`abstract`], [摘要正文], [跟随 `body`],
  [`keywords`], [关键词内容], [跟随 `emph`],
  [`preface`], [前言标题和正文], [跟随 `body`],
  [`contents`], [目录条目基础字体], [跟随 `body`],
  [`heading`], [各级标题，包括目录标题], [H],
  [`countblock`], [定理等块的正文，以及 `blankblock`], [S],
  [`caption`], [图注及 figure 基础字体], [K],
  [`table`], [表格内容], [跟随 `body`],
  [`header`], [页眉], [`("Linux Libertine", "SimSun")`],
  [`strong`], [粗体文字，包括块标题和目录一级条目], [H],
  [`emph`], [强调文字，包括 proof/solution 标题], [K],
  [`quote`], [引用块（保留斜体效果）], [K],
  [`raw`], [行内代码和代码块], [`("Consolas", "SimSun")`],
  [`math`], [行内及独立公式], [`auto`：保留 Typst 的公式字体设置],
)

修改 `body` 不会同时替换标题、粗体、强调或 countblock 等具有独立默认值的项目。
表中标为“跟随”的项会使用相应项目解析后的字体；例如未指定 `table` 时，它会跟随新的 `body`。
显式指定这些项即可覆盖继承。`auto` 恢复对应默认值或继承关系。

块标题仍由 `strong` 控制，公式仍由 `math` 控制；因此在 countblock 内使用粗体或公式时，
这些更具体的规则优先。目录一级条目由 `strong` 控制，目录标题由 `heading` 控制。
要统一某些区域的字体，可以将相关项设成同一个列表。

`default-fonts` 导出了完整默认配置，原有 `font` 字典仍可使用：

```typst
#let family = ("Libertinus Serif", "Noto Serif CJK SC")
#let my-fonts = default-fonts + (
  body: family, heading: family, strong: family, emph: family,
  countblock: family,
)
#show: scripst.with(fonts: my-fonts)
```

数学字体应支持 OpenType MATH；不要为了统一字体而直接将普通中文字体填入 `math`。
`raw` 的数组会完整传递，显式覆盖后不会再附加默认的 SimSun。
未知字段、空列表和错误的值类型会报错，以免拼写错误被静默忽略。
