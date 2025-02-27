#import "@local/scripst:1.1.0": *

#show: scripst.with(
  template: "book",
  title: [Scripst 的使用方法],
  info: [book模板],
  author: ("AnZrew",),
  time: datetime.today().display(),
  abstract: [Scripst 是 Typst 语言的模板，用来生成简约的日常使用的文档，以满足文档、作业、笔记、论文等需求],
  keywords: (
    "Scripst",
    "Typst",
    "模板",
  ),
  preface: [
    Typst 是一种简单的文档生成语言，它的语法类似于 Markdown 的轻量级标记，利用合适的 `set` 和 `show` 指令，可以高自由度地定制文档的样式。

    Scripst 是本人编写的 Typst 模板，用来生成简约的日常使用的文档，以满足文档、作业、笔记、论文等需求。
  ],
  contents: true,
  content_depth: 3,
  matheq_depth: 2,
  lang: "zh",
)



= 使用 Scripst 排版 Typst 文档

== 使用 Typst

Typst 是使用起来比 LaTeX 更轻量的语言，一旦模板编写完成，就可以以类似 Markdown 的轻量标记完成文档的编写。

相比 LaTeX，Typst 的优势在于：
- 极快的编译速度
- 语法简单、轻量
- 代码可扩展性强
- 更简单的数学公式输入
- ...

所以，Typst 对于轻量级日常文档的编写是非常合适的。只需要花费撰写 Markdown 的时间成本，就能得到甚至好于 LaTeX 的排版效果。

可以通过下面的方式安装 Typst：

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

你也可以在#link("https://github.com/typst/typst")[Typst的GitHub仓库]中找到更多的信息。

== 使用 Scripst

在 Typst 的基础上，Scripst 提供了一些模板，用来生成简约的日常使用的文档。

可以在#link("https://github.com/An-314/scripst")[Scripst的GitHub仓库]找到并下载 Scripst 的模板。

可以选择 `<> code` $->$ `Download ZIP` 来下载 Scripst 的模板。在使用时，只需要将模板文件放在你的文档目录下，然后在文档的开头引入模板文件即可。

#caution[
  要考虑清楚项目的目录结构，以便正确引入模板文件。
  ```
  project/
  ├── src/
  │   ├── main.typ
  │   ├── ...
  │   └── components.typ
  ├── pic/
  │   ├── ...
  ├── main.typ
  ├── chap1.typ
  ├── chap2.typ
  ├── ...
  ```
  如果项目的目录结构如上所示，那么在 `main.typ` 中引入模板文件的方式应该是：
  ```typst
  #import "src/main.typ": *
  ```
]

这种方法的好处是，你可以随时调整模板中的部分参数。由于编者在编写模板时采用模块化的设计，你可以轻松找到并修改模板中你需要修改的部分。

*一个更好的方法是*，参考官方给出的#link("https://github.com/typst/packages?tab=readme-ov-file#local-packages")[本地的包管理文档]，将模板文件放在本地包管理的目录`{data-dir}/typst/packages/{namespace}/{name}/{version}`下，这样就可以在任何地方使用 Scripst 的模板了。

当然，无需担心不能修改模板文件，你可以直接在文档中使用`#set, #show`等指令来覆盖模板中的部分参数。

例如该模板的应该放在
```
~/.local/share/typst/packages/local/scripst/1.1.0  # in Linux
%APPDATA%\typst\packages\local\scripst\1.1.0       # in Windows
```
如果是这样的目录结构，那么在文档中引入模板文件的方式应该是：
```typst
#import "@local/scripst:1.1.0": *
```
这样的好处是你可以直接通过`typst init`来一键使用模板创建新的项目：
```bash
typst init @local/scripst:1.1.0 project_name
```
#newpara()

在引入模板后通过这样的方式创建一个`book`文件：

```typst
#show: scripst.with(
  template: "book",
  title: [Scripst 的使用方法],
  info: [这是文章的模板],
  author: ("作者1", "作者2", "作者3"),
  time: datetime.today().display(),
  abstract: [摘要],
  keywords: ("关键词1", "关键词2", "关键词3"),
  preface: [前言]
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
)
```

这些参数以及其含义见 @para 。

这样你就可以开始撰写你的文档了。

#pagebreak()

= 模板参数说明 <para>

Scripst 的模板提供了一些参数，用来定制文档的样式。

```typst
#let scripst(
  template: "book",  // str: ("article", "book", "report")
  title: "",            // str, content, none
  info: "",             // str, content, none
  author: (),           // list
  time: "",             // str, content, none
  abstract: none,       // str, content, none
  keywords: (),         // list
  preface: none,        // str, content, none
  font_size: 11pt,      // length
  contents: false,      // bool
  content_depth: 2,     // int
  matheq_depth: 2,      // int: (1, 2)
  lang: "zh",           // str: ("zh", "en", "fr", ...)
  body,
) = {
  ...
}
```

#newpara()

== tempalate

#figure(
  three-line-table[
    | 参数 | 类型 | 可选值 | 默认值 | 说明 |
    | --- | --- | --- | --- | --- |
    | template | `str` | `("article", "book", "report")` | `"article"` | 模板类型 |
  ],
  numbering: none,
)

#newpara()

目前 Scripst 提供了三种模板，分别是 article 、book 和 report 。

本模板采用 book 模板。

- article：适用于日常文档、作业、小型笔记、小型论文等
- book：适用于书籍、课程笔记等
- report：适用于实验报告、论文等

此外的字符串传入会导致`panic`：`"Unknown template!"`。


== title

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | title | `content`, `str`, `none`| `""` | 文档标题 |
  ],
  numbering: none,
)

#newpara()

文档的标题。（不为空时）会出现在文档的封面和页眉中。

== info

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | info | `content`, `str`, `none`| `""` | 文档信息 |
  ],
  numbering: none,
)

#newpara()

文档的信息。（不为空时）会出现在文档的封面和页眉中。可以作为文章的副标题或者补充信息。

== author

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | author | `list`| `()` | 文档作者 |
  ],
  numbering: none,
)

#newpara()

文档的作者。要传入`str`或者`content`的列表。

#caution[注意，如果是一个作者的情况，请不要传入`str`或者`content`，而是传入一个`str`或者`content`的列表，例如：`author: ("作者",)`]

#newpara()

会在文章的开头以 $min(\#"authors", 3)$ 个作为一行显示。

== time

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | time | `content`, `str`, `none`| `""` | 文档时间 |
  ],
  numbering: none,
)

#newpara()

文档的时间。会出现在文档的封面和页眉中。

你可以选择用 typst 提供的 `datetime` 来获取或者格式化时间，例如今天的时间：

```typst
datetime.today().display()
```
#newpara()

== abstract

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | abstract | `content`, `str`, `none`| `none` | 文档摘要 |
  ],
  numbering: none,
)

#newpara()

文档的摘要。（不为空时）会出现在文档的摘要页。

建议在使用摘要前，实现定义一个`content`，例如：

```typst
#let abstract = [
  这是一个简单的文档模板，用来生成简约的日常使用的文档，以满足文档、作业、笔记、论文等需求。
]

#show: scripst.with(
  ...
  abstract: abstract,
  ...
)
```
然后将其传入`abstract`参数。

== keywords

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | keywords | `list`| `()` | 文档关键词 |
  ],
  numbering: none,
)

#newpara()

文档的关键词。要传入`str`或者`content`的列表。

和`author`一样，参数是一个列表，而不能是一个字符串。

只有在`abstract`不为空时，关键词才会出现在文档的摘要页。

== preface

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | preface | `content`, `str`, `none`| `none` | 文档前言 |
  ],
  numbering: none,
)

#newpara()

文档的前言。（不为空时）会出现在文档的前言页。

== font_size

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | font_size | `length`| `11pt` | 文档字体大小 |
  ],
  numbering: none,
)

#newpara()

文档的字体大小。默认为`11pt`。

参考`length`类型的值，可以传入`pt`、`mm`、`cm`、`in`、`em`等单位。

== contents

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | contents | `bool`| `false` | 是否生成目录 |
  ],
  numbering: none,
)

#newpara()

是否生成目录。默认为`false`。

== content_depth

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | content_depth | `int`| `2` | 目录的深度 |
  ],
  numbering: none,
)

#newpara()

目录的深度。默认为`2`。

== matheq_depth

#figure(
  three-line-table[
    | 参数 | 类型 | 可选值 | 默认值 | 说明 |
    | --- | --- | --- | --- | --- |
    | matheq_depth | `int`| `1`, `2` | `2` | 数学公式的深度 |
  ],
  numbering: none,
)

#newpara()

数学公式编号的深度。默认为`2`。

一般会在不分章节的情况下使用`1`，分章节的情况下使用`2`。

== lang

#figure(
  three-line-table[
    | 参数 | 类型 | 默认值 | 说明 |
    | --- | --- | --- | --- |
    | lang | `str`| `"zh"` | 文档语言 |
  ],
  numbering: none,
)

#newpara()

文档的语言。默认为`"zh"`。

可以传入`"zh"`、`"en"`、`"fr"`等语言。

== body

在使用 `#show: scripst.with(...)` 时，`body` 参数是不用手动传入的，typst 会自动将剩余的文档内容传入 `body` 参数。

#pagebreak()

= 模板效果展示

== 文档开头

文档的开头会显示标题、信息、作者、时间、摘要、关键词等信息。，如该文档的开头所示。

标题、信息、作者、时间内容全部在封面页，封面页不显示页码。

摘要、关键词在摘要页，摘要页不显示页码。

== 前言

前言会显示在摘要页之后，如该文档的前言所示。

前言的页码编号是小写的英文字母。

== 目录

如果`contents`参数为`true`，则会生成目录亦如该文档的目录所示。

从目录页开始，页码计数器会重置，并且以罗马数字编号。

== 字体与环境

从正文开始，页码计数器会重置，并且以阿拉伯数字编号。

Scripst 提供了一些常用的字体和环境，如粗体、斜体、标题、图片、表格、列表、引用、链接、数学公式等。

=== 字体

这是正常的文本。 This is normal text.

*这是粗体的文本。* *This is bold text.*

_这是斜体的文本。_ _This is italic text._

安装 CMU Serif 字体以获得更好（类似LaTeX）的显示效果。

=== 环境

==== 标题

一级标题采用中文/罗马数字编号（取决于文档语言），其余级别标题采用阿拉伯数字编号。

==== 图片

图片环境会自动编号，如下所示：

#figure(
  image("../pic/散宝.jpg", width: 70%),
  caption: "散宝",
)

==== 表格

得益于 `tablem` 包，可以用 Markdown 的方式编写表格，如下所示：

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #figure(
    three-line-table[
      | 姓名 | 年龄 | 性别 |
      | --- | --- | --- |
      | 张三 | 18 | 男 |
      | 李四 | 19 | 女 |
    ],
    caption: [`three-line-table`表格示例],
  )
  ```
][
  #figure(
    three-line-table[
      | 姓名 | 年龄 | 性别 |
      | --- | --- | --- |
      | 张三 | 18 | 男 |
      | 李四 | 19 | 女 |
    ],
    caption: [`three-line-table`表格示例],
  )
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #figure(
    tablem[
      | 姓名 | 年龄 | 性别 |
      | --- | --- | --- |
      | 张三 | 18 | 男 |
      | 李四 | 19 | 女 |
    ],
    caption: [`tablem`表格示例],
  )
  ```
][
  #figure(
    tablem[
      | 姓名 | 年龄 | 性别 |
      | --- | --- | --- |
      | 张三 | 18 | 男 |
      | 李四 | 19 | 女 |
    ],
    caption: [`tablem`表格示例],
  )
]

可以选择`numbering: none,`使得表格不编号，就像前面章节的表格并没有进入全文的表格计数器一样。

==== 数学公式

数学公式有行内和行间两种模式。

行内公式：$a^2 + b^2 = c^2$。

行间公式：
$
  a^2 + b^2 = c^2 \
  1 / 2 + 1 / 3 = 5 / 6
$
是拥有编号的。

得益于 `physica` 包，typst本身简单的数学输入方式得到了极大的扩展，并且仍然保留简介的特性：
$
  &div vb(E) &=& rho / epsilon_0 \
  &div vb(B) &=& 0 \
  &curl vb(E) &=& -pdv(vb(B),t) \
  &curl vb(B) &=& mu_0 (vb(J) + epsilon_0 pdv(vb(E),t))
$

#newpara()

=== 列举

typst 为列举提供了简单的环境，如所示：

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  - 第一项
  - 第二项
  - 第三项
  ```
][
  - 第一项
  - 第二项
  - 第三项
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  +  第一项
  3. 第二项
  +  第三项
  ```
][
  + 第一项
  3. 第二项
  + 第三项
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  / 第一项: 1
  / 第二项: 2
  / 第三项: 23
  ```
][
  / 第一项: 1
  / 第二项: 2
  / 第三项: 3
]

#newpara()

=== 引用

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #quote(attribution: "爱因斯坦", block: true)[
    God does not play dice with the universe.
  ]
  ```
][
  #quote(attribution: "爱因斯坦", block: true)[
    God does not play dice with the universe.
  ]
]

#newpara()

=== 链接

#grid(columns: (1fr, 1fr), align: (horizon, horizon + center))[
  ```typst
  #link("https://www.google.com/")[Google]
  ```
][
  #link("https://www.google.com/")[Google]
]

#newpara()

=== 超链接与文献引用

利用`<lable>`和`@lable`可以实现超链接和文献引用。

== `#newpara()`函数

由于设计的时候，有些模块不会自动换行。这是有必要的，例如数学公式后面如果不换行就表示对上面的数学公式的解释。

但有时候我们需要换行，这时候就可以使用`#newpara()`函数。

区别于官方提供的 `#parabreak()` 函数，`#newpara()` 函数会在段落之间插入一个空行，这样无论在什么场景下，都会开启新的自然段。

只要你觉得需要换行，就可以使用`#newpara()`函数。

#pagebreak()

= 结语

上面展示了 Scripst 的使用方法，以及模板的参数说明和效果展示。

希望这篇文章能够帮助你更好地使用 typst 和 Scripst。

也欢迎你为 Scripst 提出建议和改进建议，甚至贡献代码。

感谢您对 typst 和 Scripst 的支持！
