#import ("@preview/scripst:" + sys.inputs.at("version", default: "1.2.0")): *

#show: scripst.with(
  template: sys.inputs.at("template", default: "article"),
  title: [默认字体 Default fonts],
  author: ("Author",),
  info: [Subtitle],
  time: [Date],
  abstract: [摘要 Abstract.],
  keywords: ("Keyword",),
  preface: [前言 Preface.],
  contents: true,
)

= 第一章 First

正文 Body. *粗体 Strong.* _强调 Emphasis._
#quote(block: true)[引用 Quotation.]
`代码 Code`
#figure(table(columns: 2, [A], [B]), caption: [图注 Caption])
$ integral_0^1 x^2 dif x = 1/3 $
#theorem(lab: "thm")[定理 Theorem.]
#note[注记 Note.]
#blankblock[空白块 Blank block.]
Reference: @thm.

#pagebreak()
Continuation page for headers.
