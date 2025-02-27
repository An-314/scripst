#import "font.typ": *
#import "styling.typ": *
#import "components.typ": *

#let mkarticle(title, info, author, time, abstract, keywords, contents, content_depth, body) = {
  show: stynumbering.with(numbering: "1")
  if title != none and title != "" { (article.mktitle)(title) }
  if info != none and info != "" { (article.mkinfo)(info) }
  if author != none and author != () { (article.mkauthor)(author) }
  if time != none and time != "" { (article.mktime)(time) }
  if abstract != none and abstract != "" { (article.mkabstruct)(abstract, keywords) }
  if contents != false { (article.mkcontent)(content_depth) }
  body
}

#let mkbook(title, info, author, time, abstract, keywords, preface, contents, content_depth, body) = {
  if title != none and title != "" { (book.mktitle)(title) }
  if info != none and info != "" { (book.mkinfo)(info) }
  if author != none and author != () { (book.mkauthor)(author) }
  if time != none and time != "" { (book.mktime)(time) }
  pagebreak()
  if abstract != none and abstract != "" {
    newpara()
    (book.mkabstruct)(abstract, keywords)
    pagebreak()
  }
  show: stynumbering.with(numbering: "a")
  counter(page).update(1)
  if preface != none and preface != "" {
    newpara()
    (book.mkpreface)(preface)
    pagebreak()
  }
  show: stynumbering.with(numbering: "I")
  counter(page).update(1)
  if contents != false {
    newpara()
    (book.mkcontent)(content_depth)
    pagebreak()
  }
  show: stynumbering.with(numbering: "1")
  counter(page).update(1)
  newpara()
  body
}

#let mkreport(title, info, author, time, abstract, keywords, preface, contents, content_depth, body) = {
  if title != none and title != "" { (report.mktitle)(title) }
  if info != none and info != "" { (report.mkinfo)(info) }
  if author != none and author != () { (report.mkauthor)(author) }
  if time != none and time != "" { (report.mktime)(time) }
  pagebreak()
  show: stynumbering.with(numbering: "I")
  counter(page).update(1)
  if abstract != none and abstract != "" {
    newpara()
    (article.mkabstruct)(abstract, keywords)
  }
  if contents != false {
    newpara()
    (article.mkcontent)(content_depth)
    pagebreak()
  }
  show: stynumbering.with(numbering: "1")
  counter(page).update(1)
  if preface != none and preface != "" {
    newpara()
    (report.mkpreface)(preface)
  }
  newpara()
  body
}
