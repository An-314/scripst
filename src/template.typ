#import "env.typ": *
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

#let mkbook(title, info, author, time, abstract, keywords, contents, content_depth, body) = {
  if title != none and title != "" { (article.mktitle)(title) }
  if info != none and info != "" { (article.mkinfo)(info) }
  if author != none and author != () { (article.mkauthor)(author) }
  if time != none and time != "" { (article.mktime)(time) }
  if abstract != none and abstract != "" { (article.mkabstruct)(abstract, keywords) }
  show: stynumbering.with(numbering: "I")
  if contents != false { (article.mkcontent)(contents) }
  body
}
