// Compile from the package root:
// typst compile --root . docs/locale/beamer-en.typ
// typst compile --root . --input handout=true docs/locale/beamer-en.typ
#import "../../src/main.typ": *
#import slides: *

#let handout = sys.inputs.at("handout", default: "false") == "true"
#let teal = rgb("215B63")
#let pale = rgb("F0F5F5")

#show: scripst.with(
  template: "beamer",
  title: [Scripst Beamer],
  info: [A complete guide to academic presentations],
  author: ("Scripst documentation",),
  time: [1.2.0],
  lang: "en",
  countblock-lang: "en",
  font-size: 18pt,
  matheq-depth: 1,
  counter-depth: 1,
  cb-counter-depth: 1,
  link-color: teal,
  fonts: (
    body: "Noto Sans", title: "Noto Sans", heading: "Noto Sans",
    strong: "Noto Sans", emph: "Noto Sans", author: "Noto Sans",
    header: "Noto Sans", countblock: "Noto Sans", caption: "Noto Sans",
    quote: "Noto Sans", raw: "Noto Sans Mono",
    math: "New Computer Modern Math",
  ),
  beamer: (
    short-title: [Scripst · Beamer guide],
    institution: [Configuration, layout, numbering, and practical examples],
    handout: handout,
    section-slides: false,
    colors: (primary: teal, primary-dark: rgb("163F46")),
  ),
)

// Explicit documentation styles: package defaults still inherit raw text size.
#show raw.where(block: true): set text(size: 12pt)
#show raw.where(block: true): it => block(
  width: 100%, fill: pale, radius: 5pt, inset: 10pt, it,
)
#show table: set text(size: 14pt)
#set table(stroke: 0.4pt + rgb("D5E1E1"), inset: 7pt)

#title-slide()
#outline-slide(title: [In this guide])

= Start

#slide(title: [Requirements and package boundaries])[
  #tblock(title: [One Scripst entry point, one slide engine])[
    Scripst provides font roles, Physica notation, countblocks, and Ratchet
    numbering. Touying 0.8.0 provides Stargazer pages, columns, and overlays.
  ]
  - Use *Typst 0.15.0 or newer* with Scripst 1.2.0.
  - Import the `slides` namespace only when creating a presentation.
  - The package does not bundle fonts; install your choices or replace them.
  - “Beamer” names the presentation template. It does not read LaTeX Beamer source.
  This manual uses 18pt body text, 12pt block code, and 14pt tables.
]

#slide(title: [The smallest complete presentation])[
  ```typst
  #import "@preview/scripst:1.2.0": *
  #import slides: *
  #show: scripst.with(
    template: "beamer", title: [My talk], author: ("A. Author",),
    lang: "en", matheq-depth: 1, cb-counter-depth: 1,
    beamer: (institution: [My institute], section-slides: false),
  )
  #title-slide()
  = Introduction
  #slide(title: [A first result])[
    #theorem[The result goes here.]
  ]
  ```
  `title-slide()` and `outline-slide()` are explicit calls. Do not add a second
  `#show: stargazer-theme` around the same document.
]

= Settings

#slide(title: [Shared settings: metadata and typography])[
  #table(
    columns: (1.1fr, 1fr, 2.1fr),
    table.header([*Parameter*], [*Default*], [*Presentation behavior*]),
    [`title` / `info`], [`""` / `""`], [Cover title / subtitle.],
    [`author` / `time`], [`()` / `""`], [Author array / date content or `datetime`.],
    [`font-size`], [`auto` → `20pt`], [Body size; print templates keep 11pt.],
    [`fonts`], [`(:)`], [Override individual roles; see the next pages.],
    [`lang`], [`"zh"`], [Body language; set `"en"` for English.],
    [`par-indent`], [`auto` → `0em`], [Print templates keep 2em.],
    [`par-leading` / `par-spacing`], [`none` / `none`], [Beamer resolves them to 0.65em / 0.7em.],
  )
  Set these in `scripst.with(...)`, not inside the `beamer` dictionary.
]

#slide(title: [Shared settings: numbering and references])[
  #table(
    columns: (1.4fr, 0.8fr, 1.8fr),
    table.header([*Parameter*], [*Default*], [*Purpose*]),
    [`matheq-depth` / `counter-depth` / `cb-counter-depth`], [`2`], [Depth for equations / figures / countblocks.],
    [`matheq-outline` / `counter-outline`], [`"(1.1)"` / `"1.1"`], [Equation / figure-countblock number format.],
    [`matheq-color` / `counter-color`], [`red` / `blue`], [Ratchet equation / figure-reference color.],
    [`link-color` / `ref-color`], [`blue` / `red`], [External links / ordinary references.],
    [`numbering-format` / `offset`], [`none` / `0`], [Heading number format / Ratchet chapter offset.],
    [`countblocks` / `countblock-lang`], [`cb` / `"en"`], [Block registry / block-title language.],
  )
  Internal theme navigation keeps its own contrast colors. Heading number
  visibility and whether a heading participates in numbering are separate concerns.
]

#slide(title: [Fonts are configured by role])[
  #table(
    columns: (1fr, 2.3fr),
    table.header([*Role*], [*Where it is used*]),
    [`body`], [Ordinary prose. Does not replace every other role.],
    [`title` / `info`], [Cover title / subtitle.],
    [`heading`], [Slide titles and headings.],
    [`author` / `time` / `header`], [Author, date, and footer title.],
    [`countblock` / `caption` / `table`], [Block body, figure caption, table text.],
    [`strong` / `emph` / `quote`], [Strong text, emphasis, quotations.],
    [`raw` / `math`], [Code / mathematical font.],
  )
  Values may be a family name, a font descriptor, a nonempty fallback array,
  or `auto`. Unknown roles and empty font names are rejected.
]

#slide(title: [Font inheritance is deliberately selective])[
  ```typst
  #show: scripst.with(
    template: "beamer",
    fonts: (
      body: ("Noto Sans", "Noto Sans CJK SC"),
      title: "Noto Sans", heading: "Noto Sans",
      strong: "Noto Sans", countblock: "Noto Sans",
      raw: "Noto Sans Mono", math: "New Computer Modern Math",
    ),
  )
  ```
  - In beamer, `info: auto` follows `title`; `time` and `table` follow `body`.
  - Legacy roles such as `heading`, `strong`, and `countblock` keep their own
    defaults. Set them explicitly for a consistent sans-serif presentation.
  - `math: auto` preserves Typst's math-font choice. `fonts` selects families,
    not point sizes. Print-only roles remain accepted but have no slide body.
]

#slide(title: [Raw text follows the surrounding font size])[
  Scripst cancels Typst's default raw-text scaling. Both inline code and fenced
  code inherit `font-size` and a local `set text(size: ...)` by default.
  ````typst
  #slide(title: [Code on one slide])[
    #set text(size: 16pt)
    #show raw.where(block: true): set text(size: 10pt)
    Inline `code` remains 16pt.
    ```typst
    #let amplitude = 1 / calc.sqrt(2)
    ```
  ]
  ````
  Only the displayed block is explicitly 10pt in this example. This manual
  explicitly chooses 12pt blocks to fit longer API examples; that is not a
  hidden package default.
]

#slide(title: [The beamer dictionary: page and identity])[
  #table(
    columns: (1fr, 0.7fr, 2fr),
    table.header([*Key*], [*Default*], [*Meaning*]),
    [`aspect-ratio`], [`"16-9"`], [Also accepts `"4-3"` and `"16-10"`.],
    [`institution`], [`none`], [Rich-text affiliation on the title slide.],
    [`logo`], [`none`], [Image or content passed to Stargazer.],
    [`short-title`], [`auto`], [Footer title; `auto` uses the full `title`.],
    [`align`], [`top`], [Vertical content alignment; use `horizon` to center.],
  )
  ```typst
  beamer: (
    aspect-ratio: "16-9", institution: [My institute],
    short-title: [A short title], align: horizon,
    // logo: image("logo.svg", width: 2cm),
  ),
  ```
]

#slide(title: [The beamer dictionary: behavior and extension])[
  #table(
    columns: (1fr, 0.65fr, 2.1fr),
    table.header([*Key*], [*Default*], [*Meaning*]),
    [`colors`], [`(:)`], [Override Touying color roles.],
    [`progress-bar`], [`false`], [Display the bottom progress bar.],
    [`handout`], [`false`], [Normally keep the last overlay of each logical slide.],
    [`section-slides`], [`true`], [Create transition slides for top-level sections.],
    [`config`], [`()`], [An array of extra Touying configuration dictionaries.],
  )
  These two pages cover all ten supported keys. Unknown keys fail early.
  `colors` must be a dictionary; `config` must be an array, even when it contains
  only one item. Arrays need a trailing comma for a single entry.
]

#slide(title: [Change the palette without changing content])[
  ```typst
  beamer: (
    colors: (
      primary: rgb("215B63"),
      primary-dark: rgb("163F46"),
      secondary: white, tertiary: rgb("215B63"),
      neutral-lightest: white, neutral-darkest: rgb("152C30"),
    ),
    progress-bar: true,
    section-slides: false,
  ),
  ```
  - `primary` colors the title area, theme blocks, and other accents.
  - Dark and light roles control contrast in navigation and the footer.
  - Scripst's numbered blocks use their registry colors, not `beamer.colors`.
  - Keep a small palette and check text contrast in the exported PDF.
]

= Pages

#slide(title: [Explicit slides and their parameters])[
  ```typst
  #slide(title: [Results], align: top,
    config: config-page(margin: (x: 2em, top: 4em, bottom: 2em)),
  )[
    #set text(size: 17pt)
    Content for this logical slide.
  ]
  ```
  #table(
    columns: (1fr, 2.2fr),
    table.header([*Argument*], [*Use*]),
    [`title` / `header` / `footer`], [Override the title, header area, or footer for this slide.],
    [`align` / `config`], [Local alignment / one configuration dictionary.],
    [`composer`], [Column widths or a custom composition function.],
    [`repeat` / `setting`], [Overlay count (`auto` normally) / local styling function.],
  )
]

#slide(title: [Heading-driven slides and the outline])[
  ```typst
  #title-slide()
  #outline-slide(title: [Roadmap])
  = Background
  == Question
  Text for the first content slide.
  == Method
  Text for the next content slide.
  = Results
  #slide(title: [An explicit result])[More content.]
  ```
  Top-level headings organize sections; second-level headings start content
  slides. `section-slides: false` removes automatic section transitions.

  An explicit `slide(title: ...)` title is not automatically an outline entry.
  Keep a real heading hierarchy when you need a meaningful outline or navigation.
]

#slide(title: [A real two-column slide], composer: (3fr, 2fr))[
  #tblock(title: [Left: explanation])[
    Each content argument becomes one column. A `(3fr, 2fr)` composer gives
    this side three fifths of the available width.
  ]
  ```typst
  #slide(composer: (3fr, 2fr))[
    Explanation.
  ][
    Equation or figure.
  ]
  ```
][
  *Right: a compact result*
  $ ket(psi) = alpha ket(0) + beta ket(1) $
  $ abs(alpha)^2 + abs(beta)^2 = 1 $
  Use local text sizes when necessary, but split a crowded slide before
  shrinking everything.
]

#slide(title: [One pause, two PDF pages])[
  *First state:* introduce a normalized state,
  $ ket(psi) = alpha ket(0) + beta ket(1). $
  ```typst
  #slide(title: [A gradual argument])[
    State the assumptions.
    #pause
    State the conclusion.
  ]
  ```
  #pause
  *Second state:* reveal the probabilities $P(0) = abs(alpha)^2$ and
  $P(1) = abs(beta)^2$. Earlier content stays visible.

  This is the only live overlay in the manual. The logical slide number stays
  the same; the PDF gains one physical page.
]

#slide(title: [Visibility controls and handouts])[
  ```typst
  #slide(title: [Visibility], repeat: 2)[
    #only(1)[Only in the first state; no space is reserved later.]
    #uncover(2)[Visible in the second state; hidden space is reserved.]
  ]
  // In the main configuration:
  beamer: (handout: true),
  ```
  - `only` removes hidden content from layout; `uncover` keeps its space.
  - `meanwhile` restarts overlay placement from the first state. Use it only
    when coordinating several independent reveal sequences.
  - Handout mode normally keeps the final state of each logical slide. It is
    not an article export or a multi-slide-per-sheet print layout.
  - `speaker-note[...]` attaches notes to a preceding slide; `#show: appendix`
    marks the following material as appendix content.
]

= Content

#slide(title: [Countblocks: familiar calls, local controls])[
  ```typst
  #theorem(subname: [A result], lab: "my-result", breakable: false)[
    State the result here.
  ]
  #note[An unnumbered explanation; refer to @my-result.]
  ```
  #table(
    columns: (1fr, 2.3fr),
    table.header([*Call parameter*], [*Meaning*]),
    [`subname: ""` / `lab: none`], [Optional subtitle / label for a native reference.],
    [`count: true`], [Whether to show and advance the number; note/caution default to false.],
    [`breakable: true`], [Per-call setting, not a registry-wide class setting.],
  )
  Built-ins include definition, theorem, proposition, lemma, corollary, remark,
  claim, exercise, problem, example, note, and caution. Proposition through claim
  share the proposition counter.
]

#slide(title: [Register a custom block and choose its language])[
  ```typst
  #let blocks = add-countblock(cb, "result", "Result", teal, depth: 1)
  #let result = countblock.with("result", blocks)
  #show: scripst.with(
    template: "beamer", countblocks: blocks,
    lang: "en", countblock-lang: "en",
  )
  #slide(title: [A custom result])[
    #result(lab: "custom-result", breakable: false)[A useful result.]
  ]
  ```
  Pass the same registry to `countblock.with` and `scripst`. No separate
  registration or counter-reset calls are needed.

  `countblock-lang` localizes built-in names independently of `lang`. A custom
  literal such as `"Result"` stays literal. Use `counter-name:` to share a
  counter; all blocks sharing it must use the same depth.
]

#slide(title: [Numbering depth: global, section, subsection])[
  #table(
    columns: (0.6fr, 1.3fr, 2fr),
    table.header([*Depth*], [*Form*], [*Reset boundary*]),
    [`1`], [`1`, `2`, `3`], [Global sequence. Recommended for short talks.],
    [`2`], [`1.1`, `1.2`], [Top-level section.],
    [`3`], [`1.1.1`, `1.1.2`], [Second-level subsection.],
  )
  Missing heading levels contribute zero: without a top-level heading, depth 2
  may produce `0.1`; depth 3 may produce `0.0.1`. Use depth 1 if there is no hierarchy.
  ```typst
  #let blocks = set-countblock-depth(cb, "thm", 1)
  #let blocks = set-countblock-depth(blocks, "lem", 3, detach: true)
  #show: scripst.with(template: "beamer", countblocks: blocks,
    matheq-depth: 1, counter-depth: 1, cb-counter-depth: 2)
  ```
  `detach: true` separates that block from its shared counter. Registry depth
  `none` inherits `cb-counter-depth`; explicit registry depths are 1, 2, or 3.
]

#slide(title: [Physica, countblocks, and a three-line table], composer: (3fr, 2fr))[
  #definition(subname: [Normalized state], lab: "guide-state", breakable: false)[
    In an orthonormal basis,
    $ ket(psi) = alpha ket(0) + beta ket(1) $
    with $bra(psi) ket(psi) = 1$.
  ]
  $ integral_0^1 x^2 dd(x) = 1/3, quad sum_(n=1)^N n = (N(N+1))/2 $
][
  #three-line-table[
    | Outcome | Probability |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
    | $1$ | $abs(beta)^2$ |
  ]
  ```typst
  $ bra(psi) ket(psi) = 1 $
  #three-line-table[
    | Outcome | Probability |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
  ]
  ```
  Physica and table helpers are already exported by Scripst.
]

= Styling

#slide(title: [The purple Stargazer reference style])[
  ```typst
  #show: scripst.with(
    template: "beamer", fonts: (body: "MiSans"),
    beamer: (
      align: horizon, aspect-ratio: "16-9", progress-bar: false,
      colors: (
        primary: rgb("660099"), primary-dark: rgb("330066"),
        secondary: rgb("9933CC"), tertiary: rgb("CC99FF"),
        neutral-lightest: rgb("FAFAFF"), neutral-darkest: rgb("1E002D"),
      ),
      config: (config-page(margin: (top: 3.5em, bottom: 2.5em, x: 2.5em)),),
    ),
  )
  ```
  This restores the older palette, alignment, and body-page margins. Set other
  font roles explicitly as needed. A 0.6.1 to 0.8.0 migration is not pixel-identical:
  upstream title and section layouts have also changed.
]

#slide(title: [Advanced configuration: margins and footer])[
  ```typst
  beamer: (
    config: (
      config-page(margin: (top: 4em, bottom: 2em, x: 2em)),
      config-store(
        footer-columns: (20%, 20%, 1fr, 5em),
        footer-a: [A. Author], footer-c: [Short report title],
      ),
      config-common(frozen-counters: (counter("my-counter"),)),
    ),
  ),
  ```
  Configuration dictionaries merge in array order. Extra frozen counters are
  added to Scripst's required set, not substituted for it.

  Use `config-page`, not a competing `set page`. Configure handouts, section
  transitions, and fonts through Scripst's interfaces; its initialization and
  numbering protection are not general-purpose replacement hooks.
]

= Reference

#slide(title: [Print-only parameters do not create slide pages])[
  #table(
    columns: (1.35fr, 2fr),
    table.header([*Print parameter*], [*Beamer alternative*]),
    [`header`], [The Stargazer navigation and footer manage slide chrome.],
    [`contents` / `content-depth`], [Call `outline-slide()` explicitly and configure that call.],
    [`abstract` / `keywords`], [Create an ordinary slide for summary or key points.],
    [`preface`], [Create an introduction slide.],
    [`chapter-numbering-format`], [Use heading structure and the shared numbering options.],
  )
  These parameters are accepted by the shared main function but do not produce
  an article cover, abstract, preface, running header, or table of contents in beamer.

  The existing article, book, and report pipelines remain separate from the
  presentation pipeline.
]

#slide(title: [Known boundaries and safe composition])[
  - Put `pause` *between complete countblocks*. Reveals inside
    `theorem[before #pause after]` are not supported by this integration.
  - A block's `breakable` controls that block. Touying's
    `config-common(breakable: ...)` controls logical-slide overflow. They are
    different mechanisms; an oversized block is not automatically scaled.
  - Countblocks retain their original separate reference anchor. If an
    unbreakable block is moved to a later page, its anchor can remain earlier.
    Keep blocks within a slide and inspect links in the exported PDF.
  - Ratchet counters are protected across overlays; arbitrary user states or
    custom counters may need an explicit frozen-counter configuration.
  - `numbering: none` hides a heading number, but an outlined heading still
    participates in the chapter sequence. Use `outlined: false` to exclude it.
]

#slide(title: [Build the guide and check your output])[
  ```sh
  # Run from the Scripst package root.
  typst compile --root . docs/locale/beamer-en.typ /tmp/beamer-en.pdf
  typst compile --root . --input handout=true \
    docs/locale/beamer-en.typ /tmp/beamer-en-handout.pdf
  ```
  - This guide imports the repository's `../../src/main.typ`, so it tests the
    current checkout rather than a previously installed package.
  - Normal mode has *27 logical slides / 28 PDF pages*. Handout mode has 27
    pages. The small original demonstration lives in `docs/examples/beamer-en.typ`.
  - Inspect every exported page for clipping, font fallback, crowded columns,
    and reference targets. Compilation alone is not a layout check.
  - Keep body text readable; split content before shrinking an entire talk.
]

#slide(title: [Where to find the full API and examples])[
  #table(
    columns: (1fr, 2fr),
    table.header([*Resource*], [*Use it for*]),
    [`docs/beamer.md`], [Text guide, full purple setup, and configuration explanations.],
    [`docs/beamer.typ`], [Chinese edition of this presentation manual.],
    [`docs/examples/beamer-en.typ`], [Compact, runnable quantum-system demonstration.],
    [`docs/fonts.typ`], [Font roles, defaults, descriptors, and migration details.],
    [`tests/beamer.md`], [Regression cases and expected output checks.],
  )
  #link("https://typst.app/universe/package/touying/")[Touying on Typst Universe]
  #h(1em)
  #link("https://touying-typ.github.io/docs/themes/stargazer")[Stargazer theme]
  #linebreak()
  #link("https://touying-typ.github.io/docs/tutorials/settings")[Settings and counters]
  #h(1em)
  #link("https://github.com/An-314/scripst/issues")[Scripst issues]

  Online upstream documentation can change. For this package version, the
  pinned Touying 0.8.0 API and the runnable local examples are the reference.
]
