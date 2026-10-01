#import "configs.typ": *
#import "styling.typ": *
#import "locale.typ": *
#import "fonts.typ": resolve-fonts, countblock-font

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
      if type(list) == array {
        grid(
          columns: (1fr,) * calc.min(3, list.len()),
          gutter: 1em,
          ..list.map(list => align(center, text(font: font, size: size, list))),
        )
      } else {
        align(center, text(font: font, size: size, list))
      },
    )
    #v(vdown)
  ]
}

#let mkabstract(font, size, vup, vdown, keywords-font: kai) = {
  (abstract, keywords, lang: "zh") => [
    #v(vup)
    #set text(font: font)
    #set par(first-line-indent: 0em, leading: 1.1em)
    #v(2pt)
    *#localize("abstract", lang: lang): *#abstract
    #v(1pt)
    #if keywords != () [
      *#localize("keywords", lang: lang): * #text(font: keywords-font, keywords.join(localize("keywords-separator", lang: lang) + " "))
    ]
    #v(vdown)
  ]
}

#let mkpreface(font, size, vup, vdown) = {
  (it, lang: "zh") => [
    #set text(font: font)
    #v(vup)
    #text(font: font, size: size)[#align(center)[#localize("preface", lang: lang)]
    ]
    #set par(first-line-indent: 2em, leading: 1.1em)
    #v(2pt)
    #it
    #v(vdown)
  ]
}

#let mkcontent(vup, vdown, font: font.body) = content-depth => {
  set text(font: font)
  set par(first-line-indent: 2em, leading: 1em)
  show outline.entry.where(level: 1): it => {
    v(0.5em)
    set text(15pt)
    strong(it)
  }
  set outline.entry(fill: repeat("  ·"))
  outline(indent: auto, depth: content-depth)
  v(15pt)
  newpara()
}

#let article-components(font) = (
  mktitle: mkblock(font.title, 700, 2.3em, 0em, 0em),
  mkinfo: mkblock(font.info, 500, 1.5em, 0.5em, 0em),
  mkauthor: mkauthor(font.author, 1.1em, 0em, 0em),
  mktime: mkblock(font.time, 500, 1em, -0.3em, 0em),
  mkabstract: mkabstract(font.abstract, 1em, 10pt, 10pt, keywords-font: font.keywords),
  mkcontent: mkcontent(0em, 0em, font: font.contents),
)

#let book-components(font) = (
  mktitle: mkblock(font.title, 700, 2.3em, 10em, 10em),
  mkinfo: mkblock(font.info, 700, 1.5em, 0em, 10em),
  mkauthor: mkauthor(font.author, 1.1em, 0em, 0em),
  mktime: mkblock(font.time, 500, 1.3em, 10em, 0em),
  mkabstract: mkabstract(font.abstract, 1em, 0em, 10pt, keywords-font: font.keywords),
  mkpreface: mkpreface(font.preface, 2em, 0em, 10pt),
  mkcontent: mkcontent(0em, 0em, font: font.contents),
)

#let report-components(font) = (
  mktitle: mkblock(font.title, 700, 2.2em, 10em, 5em),
  mkinfo: mkblock(font.info, 700, 2.5em, 0em, 15em),
  mkauthor: mkauthor(font.author, 1.3em, 0em, 0em),
  mktime: mkblock(font.time, 500, 1.3em, 10em, 0em),
  mkabstract: mkabstract(font.abstract, 1em, 0em, 10pt, keywords-font: font.keywords),
  mkpreface: mkpreface(font.preface, 1.1em, 0em, 10pt),
  mkcontent: mkcontent(0em, 0em, font: font.contents),
)

// Preserve direct component imports while templates use per-document factories.
#let article = article-components(resolve-fonts((:), template: "article"))
#let book = book-components(resolve-fonts((:), template: "book"))
#let report = report-components(resolve-fonts((:), template: "report"))

#let proof(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[_Proof._ #h(0.75em) #body
    #align(right)[$qed$]
  ]
  newpara()
}

#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%,
  )[_Solution._ #h(0.75em) #body
  ]
  newpara()
}

#let blankblock(color: color.orange, body) = {
  context block(
    fill: color.transparentize(70%),
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    stroke: (left: (thickness: 4pt, paint: color)),
    [
      #set text(font: countblock-font.get())
      #set align(left)
      #newpara()
      #body
    ],
  )
  newpara()
}

#let separator = {
  block(
    inset: 0pt,
    width: 100%,
    stroke: (top: (thickness: 1pt, paint: mycolor.grey)),
  )[]
  newpara()
}
