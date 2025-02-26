#import "env.typ": *
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
  (it, lang: "zh") => align(center)[
    #v(vup)
    #text(font: font, size: size)[
      #{
        if lang == "zh" { [*前言*] } else if lang == "fr" { [*Préface*] } else { [*Preface*] }
      }#it
    ]
    #v(1em)
    #set par(first-line-indent: 2em, leading: 1.1em)
    #v(2pt)
    #preface
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
  mkabstruct: mkabstruct(font.body, 1em, 0em, 10pt),
  mkcontent: mkcontent(0em, 0em),
)

#let book = (
  mktitle: mkblock(font.title, 700, 2.3em, 20em, 50em),
  mkinfo: mkblock(font.title, 700, 1.5em, 0em, 10em),
  mkauthor: mkauthor(font.author, 1.1em, 0em, 0em),
  mktime: mkblock(font.body, 500, 1.3em, 10em, 0em),
  mkabstruct: mkabstruct(font.body, 1em, 0em, 10pt),
  mkpreface: mkpreface(font.body, 1.1em, 0em, 10pt),
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

#let theorem-counter = counter("theorem")

#show heading.where(level: 1): it => {
  theorem-counter.set(0)
  it
}

#let theorem(body, name: none) = {
  theorem-counter.step()

  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*Theorem [#context counter(heading.where(level:1)).display().#context theorem-counter.display()]* #if(name!=none){emph(name)} #h(0.75em) #body]
  // 这里选择这样的方式而非使用二级计数器是出于与章节名的严格对应
}

#let note(body) = {
  block(
    fill: rgb("#72ab68ab"),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*Note.* #h(0.75em) #body]
}

#let caution(body) = {
  block(
    fill: rgb("#ca9187ab"),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*⚠️* #h(0.75em) #body]
}

#let proof(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[_Proof._ #h(0.75em) #body
    #align(right)[$qed$]
  ]
}

#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[*解答.* #h(0.75em) #body]
}
