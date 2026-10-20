// See beamer.md for the small test matrix and PDF page-count checks.
#import "../src/main.typ": *
#import slides: *

#let mode = sys.inputs.at("mode", default: "counts")
#let depth = if mode in ("edges", "visible-headings") { 2 } else { int(sys.inputs.at("depth", default: "1")) }
#let handout = sys.inputs.at("handout", default: "false") == "true"
#let aspect = sys.inputs.at("aspect", default: "16-9")
#let blocks = add-countblock(cb, "custom", "Custom", blue)
#let custom = countblock.with("custom", blocks)
#let chosen = (
  title: "DejaVu Sans", info: "DejaVu Serif", author: "DejaVu Sans Mono",
  time: "Liberation Sans", body: "Liberation Serif", heading: "DejaVu Sans",
  table: "DejaVu Sans Mono", caption: "DejaVu Serif", header: "Liberation Mono",
  strong: "Liberation Sans", emph: "Liberation Mono", quote: "DejaVu Serif",
  raw: "DejaVu Sans Mono", countblock: "DejaVu Sans Mono", math: "DejaVu Math TeX Gyre",
)
#let check-font(role) = context {
  let actual = if type(text.font) == array { text.font } else { (text.font,) }
  assert.eq(actual, (lower(chosen.at(role)),), message: "Wrong beamer font for " + role)
}
#let check-target(name, kind, number) = {
  let targets = query(label(name))
  assert.eq(targets.len(), 1, message: "Label must occur exactly once: " + name)
  let actual = counter(figure.where(kind: kind)).at(targets.first().location())
  assert.eq(actual, (number,), message: name + ": expected " + str(number) + ", got " + repr(actual))
}

#show: scripst.with(
  template: "beamer",
  title: if mode == "fonts" { [#check-font("title")Font roles] } else { [] },
  info: if mode == "fonts" { [#check-font("info")Presentation subtitle] } else { [] },
  author: if mode == "fonts" { ([#check-font("author")Author],) } else if sys.inputs.at("empty-author", default: "false") == "true" { () } else { ("Author",) },
  time: if mode == "fonts" { [#check-font("time")2026] } else { "" },
  fonts: chosen,
  lang: "en",
  countblocks: blocks,
  matheq-depth: depth, counter-depth: depth, cb-counter-depth: depth,
  offset: if mode == "edges" { 3 } else { 0 },
  beamer: (handout: handout, section-slides: mode == "sections", aspect-ratio: aspect, short-title: "Beamer tests"),
)

#if mode == "visible-headings" {
  heading(depth: 1)[Hidden section]
  slide(title: [Overlay with a body heading], composer: (1fr, 1fr))[
    #theorem(lab: "before-visible")[Before the body heading.]
    #heading(level: 1, outlined: false)[Visible body heading]
    #theorem(lab: "after-visible")[After the body heading.]
  ][
    #pause
    A later reveal.
  ]
  slide(title: [Snapshot check])[
    #theorem(lab: "after-overlay")[After the overlay.]
    #context {
      for (name, number) in (("before-visible", 1), ("after-visible", 2), ("after-overlay", 3)) {
        check-target(name, "thm", number)
        assert.eq(counter("chap-counter").at(query(label(name)).first().location()), (1, 0, 0), message: name)
      }
      assert.eq(here().page(), if handout { 2 } else { 3 })
    }
  ]
} else if mode == "edges" {
  heading(depth: 1)[Counted section]
  slide(title: [Offset])[
    #theorem(lab: "edge-first")[First theorem.]
  ]
  if sys.inputs.at("style-outlined", default: "false") == "true" {
    set heading(outlined: false)
    heading(depth: 1)[Unoutlined section]
    slide(title: [Unoutlined heading])[
      #theorem(lab: "edge-second")[The counter must not reset.]
    ]
  } else {
    heading(depth: 1, outlined: false)[Unoutlined section]
    slide(title: [Unoutlined heading])[
      #theorem(lab: "edge-second")[The counter must not reset.]
    ]
  }
  heading(depth: 1, numbering: none)[Unnumbered but outlined section]
  slide(title: [Unnumbered heading])[
    #theorem(lab: "edge-third")[The counter must reset.]
  ]
  [#heading(depth: 1)[Hidden by label] <hd.x>]
  slide(title: [Label suppression])[
    #theorem(lab: "edge-fourth")[The counter must not reset.]
    #context {
      let unoutlined = query(heading).filter(it => it.body == [Unoutlined section])
      assert.eq(unoutlined.first().outlined, false, message: "Rendered heading must retain outlined: false")
      for (name, number, prefix) in (
        ("edge-first", 1, 4), ("edge-second", 2, 4),
        ("edge-third", 1, 5), ("edge-fourth", 2, 5),
      ) {
        check-target(name, "thm", number)
        assert.eq(counter("chap-counter").at(query(label(name)).first().location()), (prefix, 0, 0), message: name)
      }
      assert.eq(here().page(), 4)
    }
  ]
} else if mode == "headings" {
  heading(depth: 1)[Automatic slides]
  heading(depth: 2)[First content]
  theorem(lab: "automatic-first")[First theorem.]
  heading(depth: 2)[Second content]
  theorem(lab: "automatic-second")[Second theorem.]
  context {
    check-target("automatic-first", "thm", 1)
    check-target("automatic-second", "thm", 2)
    assert.eq(here().page(), 2)
  }
} else if mode == "sections" {
  heading(depth: 1)[First section]
  slide(title: [First content])[
    A section divider precedes this slide.
    #context {
      assert.eq(here().page(), 2)
      assert.eq(counter("chap-counter").get(), (1, 0, 0))
    }
  ]
  heading(depth: 1)[Second section]
  slide(title: [Last content])[
    Another divider precedes this slide.
    #context {
      assert.eq(here().page(), 4)
      assert.eq(counter("chap-counter").get(), (2, 0, 0))
    }
  ]
} else if mode == "fonts" {
  title-slide()
  slide(title: [#check-font("heading")Font checks], composer: (1fr, 1fr))[
    #check-font("body")Body. *#check-font("strong")Strong.* _#check-font("emph")Emphasis._
    #quote[#check-font("quote")Quote.]
    #show raw: it => [#check-font("raw")#it]
    `Code`
    #heading(level: 3)[#check-font("heading")Heading]
    $ #check-font("math") bra(psi) ket(psi) = 1 $
  ][
    #figure(table(columns: 2, [#check-font("table")A], [B]), caption: [#check-font("caption")Caption])
    #theorem(breakable: false)[#check-font("countblock")Theorem.]
    #note[#check-font("countblock")Note.]
    #custom(count: false)[#check-font("countblock")Custom.]
    #context { assert.eq(here().page(), 2) }
  ]
} else {
  if depth > 1 { heading(depth: 1)[First section] }
  if depth == 3 { heading(depth: 2)[First subsection] }
  slide(title: [Overlay], composer: (1fr, 1fr))[
    #metadata(none) <deck-start>
    #context { assert.eq(text.size, 20pt) }
    #theorem(lab: "first", breakable: false)[First theorem.]
    $ integral_0^1 x dif x = 1/2 $ <eq-first>
  ][
    #custom(lab: "custom-first", breakable: false)[Custom block.]
    #figure(raw("x = 1"), caption: [Code]) <raw-first>
    #pause
    - An incremental item.
  ]
  slide(title: [Shared counters], composer: (1fr, 1fr))[
    #lemma(lab: "lemma-first", breakable: false)[Lemma.]
    #proposition(lab: "prop-second", breakable: false)[Proposition shares the lemma counter.]
  ][
    #theorem(lab: "second", breakable: false)[Second theorem.]
    $ sum_(n=1)^N n = N(N+1)/2 $ <eq-second>
    @first, @custom-first, @eq-first.
  ]
  if depth > 1 { heading(depth: 2)[Second subsection] }
  slide(title: [Subsection boundary])[
    #theorem(lab: "third", breakable: false)[Third theorem location.]
    #custom(lab: "custom-second", breakable: false)[Custom counter after a subsection boundary.]
  ]
  if depth > 1 { heading(depth: 1)[Second section] }
  if depth == 3 { heading(depth: 2)[First subsection] }
  slide(title: [Final checks])[
    #theorem(lab: "fourth", breakable: false)[Final theorem.]
    References: @first, @second, @third, @fourth, @lemma-first, @prop-second.
    #context {
      check-target("first", "thm", 1)
      check-target("second", "thm", 2)
      check-target("third", "thm", if depth == 3 { 1 } else { 3 })
      check-target("fourth", "thm", if depth > 1 { 1 } else { 4 })
      check-target("custom-first", "custom", 1)
      check-target("custom-second", "custom", if depth == 3 { 1 } else { 2 })
      check-target("raw-first", raw, 1)
      check-target("lemma-first", "prop", 1)
      check-target("prop-second", "prop", 2)
      for (name, number) in (("eq-first", 1), ("eq-second", 2)) {
        let targets = query(label(name))
        assert.eq(targets.len(), 1, message: "Equation label must be unique")
        assert.eq(counter(math.equation).at(targets.first().location()), (number,))
      }
      if depth > 1 {
        for (name, expected) in (
          ("first", if depth == 3 { (1, 1, 0) } else { (1, 0, 0) }),
          ("third", if depth == 3 { (1, 2, 0) } else { (1, 1, 0) }),
          ("fourth", if depth == 3 { (2, 1, 0) } else { (2, 0, 0) }),
        ) {
          assert.eq(counter("chap-counter").at(query(label(name)).first().location()), expected, message: "Wrong heading prefix at " + name)
        }
      }
      assert.eq(query(<deck-start>).map(it => it.location().page()), if handout { (1,) } else { (1, 2) })
      assert.eq(here().page(), if handout { 4 } else { 5 })
    }
  ]
}
