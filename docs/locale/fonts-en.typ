#pagebreak(weak: true)

== fonts: configure fonts by role <font-settings>

Starting with Scripst 1.2.0, the main function accepts a `fonts` dictionary.
Its default, `(:)`, keeps the existing fonts. Supply only the roles you want to change;
there is no need to edit package files. `font-size` still controls the text size.

```typst
#import "@preview/scripst:1.2.0": *
#show: scripst.with(
  fonts: (
    body: ("Libertinus Serif", "Noto Serif CJK SC"),
    heading: ("Libertinus Sans", "Noto Sans CJK SC"),
    countblock: ("Libertinus Serif", "Noto Serif CJK SC"),
    raw: ("DejaVu Sans Mono", "Noto Sans CJK SC"),
    math: "New Computer Modern Math",
  ),
)
```

Each value accepts a font name, a font descriptor such as
`(name: "SimSun", covers: "latin-in-cjk")`, or a non-empty array of these.
Typst tries fonts in array order for each character. Install fonts locally or upload
them to your web project; Scripst does not bundle fonts.

The default lists below are abbreviated as:

- S: `("CMU Serif", "Linux Libertine", "SimSun")`
- H: `("CMU Serif", "Linux Libertine", "SIMHEI")`
- K: `("CMU Serif", "Linux Libertine", "KaiTi")`

#table(
  columns: (auto, 1fr, 1fr),
  table.header([Key], [Role], [Default / inheritance]),
  [`body`], [Body text, ordinary lists, page numbers], [S],
  [`title`], [Document / cover title], [H],
  [`info`], [Subtitle], [Follows `author` in article; `title` in book/report],
  [`author`], [Authors], [K],
  [`time`], [Date], [Follows `body`],
  [`abstract`], [Abstract body], [Follows `body`],
  [`keywords`], [Keyword contents], [Follows `emph`],
  [`preface`], [Preface title and body], [Follows `body`],
  [`contents`], [Base font for outline entries], [Follows `body`],
  [`heading`], [Headings, including outline title], [H],
  [`countblock`], [Theorem-like block bodies and `blankblock`], [S],
  [`caption`], [Captions and figure base font], [K],
  [`table`], [Table contents], [Follows `body`],
  [`header`], [Running headers], [`("Linux Libertine", "SimSun")`],
  [`strong`], [Bold text, block titles, top-level outline entries], [H],
  [`emph`], [Emphasis, including proof/solution titles], [K],
  [`quote`], [Quotations, retaining italics], [K],
  [`raw`], [Inline and block code], [`("Consolas", "SimSun")`],
  [`math`], [Inline and display equations], [`auto`: keep Typst's math font settings],
)

Changing `body` does not replace independent defaults such as `heading`, `strong`,
`emph`, or `countblock`. Roles marked “follows” inherit the resolved parent font
unless explicitly overridden. `auto` restores a role's default or inheritance.
More specific formatting still applies inside components: block titles use `strong`,
equations use `math`, and the outline title uses `heading`. Set related roles to the
same font list when a uniform appearance is desired.

The exported `default-fonts` dictionary contains all defaults. The existing `font`
dictionary remains available and may also be passed to `fonts`.

```typst
#let family = ("Libertinus Serif", "Noto Serif CJK SC")
#let my-fonts = default-fonts + (
  body: family, heading: family, strong: family, emph: family,
  countblock: family,
)
#show: scripst.with(fonts: my-fonts)
```

Use an OpenType MATH font for `math`. Explicit `raw` lists are passed through unchanged;
the default SimSun fallback is not appended to your override.
Unknown keys, empty lists, and invalid value types produce an error.
