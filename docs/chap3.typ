#import "@local/scripst:1.1.0": *

= 模板效果展示

== 文档开头

文档的开头会显示标题、信息、作者、时间、摘要、关键词等信息。，如该文档的开头所示。

== 目录

如果`contents`参数为`true`，则会生成目录亦如该文档的目录所示。

== 字体与环境

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
  image("pic/pic.jpg", width: 50%),
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

区别于官方提供的 `#parbreak()` 函数，`#newpara()` 函数会在段落之间插入一个空行，这样无论在什么场景下，都会开启新的自然段。

只要你觉得需要换行，就可以使用`#newpara()`函数。

== countblock

countblock 是 Scripst 提供的一个计数器模块，用来对文档中的某些可以计数的内容进行计数。

全局变量 `cb` 记录着所有可以使用的计数器，你可以通过 `add_countblock` 函数来添加一个计数器。

默认的countblock有
```typst
#let cb = (
  "thm": ("Theorem", rgb("#817ffaa5")),
  "def": ("Definition", rgb("#72ab68ab")),
  "prob": ("Problem", rgb("#ac2df653")),
  "prop": ("Proposition", rgb("#6f68abab")),
  "note": ("Note", rgb("#464040ad")),
  "cau": ("⚠️", rgb("#f62d2d53")),
)
```
这些计数器已经初始化，你可以直接使用。

#note(count: false)[
  由于 typst 语言的函数不存在指针或引用，传入的变量不能修改，我们只能通过显示的返回值来修改变量。并且将其传入下一个函数。目前作者没有找到更好的方法。
]

#newpara()

=== countblock 的新建与注册

同时，你可以通过 `add_countblock` 函数来添加（或重载）一个计数器，再通过 `register_countblock` 函数来注册这个计数器。
```typst
#let cb = add_countblock("test", "This is a test", teal)
#show: register_countblock.with("test")
```
此后你就可以使用 `countblock` 函数来对这个计数器进行计数。

#let cb = add_countblock("test", "This is a test", teal)
#show: register_countblock.with("test")

=== countblock 的使用

采用 `countblock` 函数来创建一个块：
```typst
#countblock(
  name,
  subname,
  count: true,
  cb: cb,
)[
  ...
]
```
其中 `name` 是计数器的名称，`subname` 是创建该条目的名称，`count` 是是否计数，`cb` 是计数器的列表。例如
```typst
#countblock("thm", subname: "Fermat's Little Theorem", cb)[

  If $p$ is a prime number, then for any integer $a$, the number $a^p - a$ is an integer multiple of $p$.
  $
    a^p eq.triple a mod p
  $
]
#proof[略。]
```
就会创建一个定理块，并且计数：
#countblock("thm", subname: [_Fermat's Little Theorem_], cb)[

  If $p$ is a prime number, then for any integer $a$, the number $a^p - a$ is an integer multiple of $p$.
  $
    a^p eq.triple a (mod p)
  $
]
#proof[略。]
其中`subname`如传入，是需要指定的。

你也可以将其封装成另一个函数：
```typst
#let test = countblock.with("test", cb)
```
对于刚才创建的`test`计数器，你可以使用`countblock`函数来计数：

```typst
#countblock("test", cb)[
  1 + 1 = 2
]

#test[
  1 + 2 = 3
]
```
#let test = countblock.with("test", cb)
#countblock("test", cb)[
  1 + 1 = 2
]
#test[
  1 + 2 = 3
]

其余默认给定的计数器也可以使用，直接封装好的函数：
```typst
#definition(subname: [...])[]
#theorem(subname: [...])[]
#proposition(subname: [...])[]
#problem(subname: [...])[]
#note(count: false)[]
#caution(count: false)[]
```
#definition[

  这是一个定义，请你理解它。
]

#theorem[

  这是一个定理，请你证明它。
]

#problem[

  这是一个问题，请你解决它。
]

#proposition[

  这是一个命题，请你证明它。
]

#note(count: false)[

  这是一个注记，请你注意它。
]

#caution(count: false)[
  这是一个提醒，请你谨慎它。
]

#newpara()

这些计数器编号的逻辑是：
- 如果没有章节，那么只有一个计数器编号
- 如果有章节，那么计数器编号是*章节号.本章节内截至此块出现过的该种块的数量*

*如此，你可以注册和使用任意数量的计数器。*
