#import "env.typ": *
#import "styling.typ": *
#import "components.typ": *
#import "template.typ": *

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
  show: stydoc.with(title, author)
  show: stypar
  show: stytext.with(lang: lang, size: font_size)
  show: stystrong
  show: styemph
  show: styheading.with(lang: lang)
  show: styfigure
  show: styimage
  show: stytable
  show: styenum
  show: stylist
  show: styquote
  show: styraw
  show: stylink
  show: stymatheq.with(eq_depth: matheq_depth)
  show: styheader.with(title, info)
  if template == "article" {
    mkarticle(title, info, author, time, abstract, keywords, contents, content_depth, body)
  } else if template == "book" {
    mkbook(title, info, author, time, abstract, keywords, contents, content_depth, body)
  } else if template == "report" {
    mkreport(title, info, author, time, abstract, keywords, contents, content_depth, body)
  } else {
    panic("Unknown template!")
  }
}
