#import "../src/main.typ": *
#import "../src/fonts.typ": resolve-fonts

#let defaults = resolve-fonts((:))
#assert.eq(defaults.body, font.body)
#assert.eq(defaults.raw, (font.raw, "SimSun"))
#assert.eq(resolve-fonts((body: "DejaVu Serif")).table, "DejaVu Serif")
#assert.eq(resolve-fonts((body: auto)).body, font.body)
#assert.eq(resolve-fonts((raw: ("Consolas", "SimSun"))).raw, ("Consolas", "SimSun"))
#assert.eq(resolve-fonts((body: (name: "SimSun", covers: "latin-in-cjk"))).body.name, "SimSun")

#let chosen = (
  title: "DejaVu Sans", info: "DejaVu Serif", author: "DejaVu Sans Mono",
  time: "Liberation Sans", body: "Liberation Serif",
  abstract: "DejaVu Sans Mono", keywords: "Liberation Mono",
  preface: "DejaVu Serif", contents: "Liberation Sans",
  heading: "DejaVu Sans", table: "DejaVu Sans Mono",
  caption: "DejaVu Serif", header: "Liberation Mono",
  strong: "Liberation Sans", emph: "Liberation Mono", quote: "DejaVu Serif",
  raw: ("DejaVu Sans Mono", "SimSun"), countblock: "DejaVu Sans Mono",
  math: "DejaVu Math TeX Gyre",
)

#let check(role) = context {
  let value = chosen.at(role)
  let expected = if type(value) == array { value } else { (value,) }
  let actual = if type(text.font) == array { text.font } else { (text.font,) }
  assert.eq(actual, expected.map(lower), message: "Wrong font for " + role + ": " + repr(text.font))
}

#show: scripst.with(
  template: sys.inputs.at("template", default: "article"),
  title: [#check("title")Font interface],
  info: [#check("info")Font configuration],
  author: ("Author",),
  time: [#check("time")Date],
  abstract: [#check("abstract")Abstract text.],
  keywords: ([#check("keywords")Keyword],),
  preface: [#check("preface")Preface text.],
  contents: true,
  header: false,
  fonts: chosen,
  lang: "en",
)

#show raw: it => [#check("raw")#it]
#show outline.entry: it => [#check("contents")#it]

#heading(outlined: false)[#check("heading")Font roles]

== Listed section

#check("body")Body text. *#check("strong")Strong text.* _#check("emph")Emphasis._
#quote(block: true)[#check("quote")Quoted text.]
`Inline code`
```typst
#let answer = 42
```
#figure(table(columns: 2, [#check("table")A], [B]), caption: [#check("caption")Caption])
$ #check("math") integral_0^1 x^2 dif x = 1/3 $
#theorem(lab: "font-thm")[#check("countblock")Theorem text.]
#note[#check("countblock")Unnumbered note.]
#blankblock[#check("countblock")Blank block.]
#let custom = add-countblock(cb, "custom", "Custom", blue)
#countblock("custom", custom, count: false)[#check("countblock")Custom registry.]
Reference: @font-thm.

#theorem[
  #check("countblock")
  #for i in range(80) [A long countblock must still break across pages. #parbreak()]
]
