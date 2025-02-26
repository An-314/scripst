#import "@local/scripst:1.1.0": *

#show: scripst.with(
  title: [Scripst 的使用方法],
  info: [这是文章的模板],
  author: ("AnZrew", "AnZreww", "AnZrewww"),
  time: datetime.today().display(),
  abstract: [Scripst 是 Typst 语言的模板，用来生成简约的日常使用的文档，以满足文档、作业、笔记、论文等需求],
  keywords: (
    "Scripst",
    "Typst",
    "模板",
  ),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
)

Typst 是一种简单的文档生成语言，它的语法类似于 Markdown 的轻量级标记，利用合适的 `set` 和 `show` 指令，可以高自由度地定制文档的样式。

Scripst 是本人编写的 Typst 模板，用来生成简约的日常使用的文档，以满足文档、作业、笔记、论文等需求。

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
typst init -t @local/scripst:1.1.0 project
```
#newpara()

在引入模板后通过这样的方式创建一个`article`文件：

```typst
#show: scripst.with(
  title: [Scripst 的使用方法],
  info: [这是文章的模板],
  author: ("作者1", "作者2", "作者3"),
  time: datetime.today().display(),
  abstract: [摘要],
  keywords: ("关键词1", "关键词2", "关键词3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
)
```

这些参数以及其含义见 @para 。

这样你就可以开始撰写你的文档了。

= 模板参数 <para>

Scripst 的模板提供了一些参数，用来定制文档的样式。

```typst
#let scripst(
  template: "article",
  title: "",
  info: "",
  author: (),
  time: "",
  abstract: none,
  keywords: (),
  font_size: 11pt,
  contents: false,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
  body,
) = {
  ...
}
```
