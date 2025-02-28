#import "configs.typ": *
#import "styling.typ": *

#let mkblock(font, weight, size, vup, vdown) = {
  it => align(center)[
    #v(vup)
    #block(text(font: font, weight: weight, size: size, it))
    #v(vdown)
  ]
}

#let mkauthor(font, size, vup, vdown) = {
  list => align(center)[
    #v(vup)
    #pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, list.len()),
        gutter: 1em,
        ..list.map(list => align(center, text(font: font, size: size, list))),
      ),
    )
    #v(vdown)
  ]
}

#let mkabstruct(font, size, vup, vdown) = {
  (abstract, keywords, lang: "zh") => [
    #v(vup)
    #set par(first-line-indent: 0em, leading: 1.1em)
    #v(2pt)
    #{
      if lang == "zh" { [*摘要：*] } else if lang == "fr" { [*Résumé :*] } else { [*Abstract:*] }
    }#abstract
    #v(1pt)
    #if keywords != () [
      #{
        if lang == "zh" { [*关键词：* #text(font: kai, keywords.join("；"))] } else if lang == "f#" {
          [*Mots-clés :* #text(font: kai, keywords.join(", "))]
        } else { [*Keywords:* #text(font: kai, keywords.join(", "))] }
      }
    ]
    #v(vdown)
  ]
}

#let mkpreface(font, size, vup, vdown) = {
  (it, lang: "zh") => [
    #v(vup)
    #text(font: font, size: size)[#align(center)[
        #if lang == "zh" { [*前言*] } else if lang == "fr" { [*Préface*] } else { [*Preface*] }
      ]
    ]
    #set par(first-line-indent: 2em, leading: 1.1em)
    #v(2pt)
    #it
    #v(vdown)
  ]
}

#let mkcontent(vup, vdown) = content_depth => {
  set par(first-line-indent: 2em, leading: 1em)
  show outline.entry.where(level: 1): it => {
    v(0.5em)
    set text(15pt)
    strong(it)
  }
  set outline.entry(fill: repeat("  ·"))
  outline(indent: auto, depth: content_depth)
  v(15pt)
  newpara()
}

#let article = (
  mktitle: mkblock(font.title, 700, 2.3em, 0em, 0em),
  mkinfo: mkblock(font.author, 500, 1.5em, 0.5em, 0em),
  mkauthor: mkauthor(font.author, 1.1em, 0em, 0em),
  mktime: mkblock(font.body, 500, 1em, -0.3em, 0em),
  mkabstruct: mkabstruct(font.body, 1em, 10pt, 10pt),
  mkcontent: mkcontent(0em, 0em),
)

#let book = (
  mktitle: mkblock(font.title, 700, 2.3em, 10em, 10em),
  mkinfo: mkblock(font.title, 700, 1.5em, 0em, 10em),
  mkauthor: mkauthor(font.author, 1.1em, 0em, 0em),
  mktime: mkblock(font.body, 500, 1.3em, 10em, 0em),
  mkabstruct: mkabstruct(font.body, 1em, 0em, 10pt),
  mkpreface: mkpreface(font.body, 2em, 0em, 10pt),
  mkcontent: mkcontent(0em, 0em),
)

#let report = (
  mktitle: mkblock(font.title, 700, 2.2em, 10em, 5em),
  mkinfo: mkblock(font.title, 700, 2.5em, 0em, 15em),
  mkauthor: mkauthor(font.author, 1.3em, 0em, 0em),
  mktime: mkblock(font.body, 500, 1.3em, 10em, 0em),
  mkabstruct: mkabstruct(font.body, 1em, 0em, 10pt),
  mkpreface: mkpreface(font.body, 1.1em, 0em, 10pt),
  mkcontent: mkcontent(0em, 0em),
)

#let cb = (
  "thm": ("Theorem", color.blue),
  "def": ("Definition", color.green),
  "prob": ("Problem", color.purple),
  "prop": ("Proposition", color.purple-grey),
  "ex": ("Example", color.green-blue),
  "note": ("Note", color.grey),
  "cau": ("⚠️", color.red),
)

#let add_countblock(cb: cb, name, info, color) = {
  cb.insert(name, (info, color))
  return cb
}

#let register_countblock(name, body) = {
  show heading.where(level: 1): it => {
    counter(name).update(0)
    it
  }
  body
}

#let countblock(name, subname: "", cb, count: true, body) = {
  if count { counter(name).step() }
  if cb.at(name) == none { panic("countblock: block not registered") }
  let color = cb.at(name).at(1)
  block(
    fill: color.transparentize(60%),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
    stroke: (left: (thickness: 4pt, paint: cb.at(name).at(1))),
    {
      let num = ""
      let info = cb.at(name).at(0)
      if count {
        num = context {
          if query(heading.where(level: 1)).len() != 0 {
            " " + context counter(heading.where(level: 1)).display() + "." + context counter(name).display()
          } else { " " + context counter(name).display() }
        }
      }
      let title = info + num + " " + subname
      [*#title* #h(0.75em) #body]
    },
  )
}

#let definition = countblock.with("def", cb)
#let theorem = countblock.with("thm", cb)
#let proposition = countblock.with("prop", cb)
#let problem = countblock.with("prob", cb)
#let example = countblock.with("ex", cb)
#let note = countblock.with("note", cb)
#let caution = countblock.with("cau", cb)

#let proof(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[_Proof._ #h(0.75em) #body
    #align(right)[$qed$]
  ]
}
