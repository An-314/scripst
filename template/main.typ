#import "@local/scripst:1.1.0": *

#let abstract = [Scripst 是一款简约易用的 Typst 语言模板，适用于日常文档、作业、笔记、论文等多种场景]
#let preface =  [
    Typst 是一种简单的文档生成语言，它的语法类似于 Markdown 的轻量级标记，利用合适的 `set` 和 `show` 指令，可以高自由度地定制文档的样式。

    Scripst 是一款简约易用的 Typst 语言模板，适用于日常文档、作业、笔记、论文等多种场景。
  ]

#show: scripst.with(
  template: "report",
  title: [Scripst 的使用方法],
  info: [article样式],
  author: ("AnZrew",),
  time: datetime.today().display(),
  abstract: abstract,
  keywords: (
    "Scripst",
    "Typst",
    "模板",
  ),
  preface = preface,
  contents: true,
  content_depth: 3,
  matheq_depth: 2,
  lang: "zh",
)
