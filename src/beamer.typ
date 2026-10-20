#import "@preview/touying:0.8.0" as touying
#import "@preview/ratchet:0.0.4": ratchet
#import "countblock.typ": countblock-counter-names, countblock-figure-groups, set-countblock-language
#import "fonts.typ": with-countblock-font
#import "styling.typ": stystrong, styemph, styref, stymatheq, labelset

#let _chapter-counter = counter("chap-counter")

#let defaults = (
  aspect-ratio: "16-9",
  institution: none,
  logo: none,
  short-title: auto,
  colors: (:),
  progress-bar: false,
  handout: false,
  section-slides: true,
  align: top,
  config: (),
)

// Touying suppresses section headings with `show heading: none`, so Ratchet's
// heading show rules do not run for those headings. Advance only that hidden
// preamble here, after Touying has restored counters for the current overlay.
#let _hidden-headings(self, groups, eq-depth) = context {
  let count = self.at("headings", default: ()).len()
  if count == 0 { return }
  // Query the resolved headings so inherited outlined/level settings are kept.
  // Later overlays must use the first overlay's snapshot, not headings that
  // may have appeared inside the preceding overlay's visible body.
  let anchor = if self.at("enable-frozen-states-and-counters", default: true) and not self.handout and self.repeat > 1 {
    touying.utils.loc-prior-newslide.get()
  } else { here() }
  let headings = query(selector(heading).before(anchor))
  for item in headings.slice(calc.max(0, headings.len() - count)) {
    if item.outlined {
      let level = item.level
      if level in (1, 2, 3) {
        if eq-depth > level { counter(math.equation).update(0) }
        for group in groups {
          if group.depth > level {
            for kind in group.kinds { counter(figure.where(kind: kind)).update(0) }
          }
        }
        _chapter-counter.step(level: level)
        _chapter-counter.update((..nums) => nums.pos().slice(0, level) + (0,) * (3 - level))
      }
    }
  }
}

#let mkbeamer(
  options, fonts, font-size, title, info, author, time, lang,
  par-indent, par-leading, par-spacing,
  countblocks, countblock-lang, matheq-depth, counter-depth, cb-counter-depth,
  matheq-outline, counter-outline, matheq-color, counter-color, link-color, ref-color,
  numbering-format, offset,
  body,
) = {
  assert(type(options) == dictionary, message: "scripst: beamer must be a dictionary")
  for key in options.keys() {
    assert(key in defaults, message: "scripst: unknown beamer key `" + key + "`")
  }
  let options = defaults + options
  assert(type(options.colors) == dictionary, message: "scripst: beamer.colors must be a dictionary")
  assert(type(options.config) == array, message: "scripst: beamer.config must be an array of Touying configurations")
  let extra = touying.utils.merge-dicts((:), ..options.config)
  let groups = countblock-figure-groups(
    countblocks, default-depth: cb-counter-depth,
    outline: counter-outline, color: counter-color,
  )
  let all-groups = ((kinds: (image, table, raw), depth: counter-depth),) + groups
  let frozen = (
    counter("chap-counter"),
    counter(figure.where(kind: raw)),
    ..countblock-counter-names(countblocks).map(kind => counter(figure.where(kind: kind))),
    ..extra.at("frozen-counters", default: ()),
  )

  // Runs once, after Touying has parsed the original slide/heading content.
  // Do not wrap the parser input in contextual Ratchet or font state scopes.
  let init(self: none, body) = {
    set text(font: fonts.body, size: font-size, lang: lang)
    set par(
      first-line-indent: par-indent,
      leading: if par-leading == none { 0.65em } else { par-leading },
      spacing: if par-spacing == none { 0.7em } else { par-spacing },
    )
    set heading(numbering: numbering-format)
    set list(marker: touying.components.knob-marker(primary: self.colors.primary))
    show heading: set text(font: fonts.heading, fill: self.colors.primary)
    show figure.caption: set text(font: fonts.caption, size: 0.65em)
    show footnote.entry: set text(size: 0.65em)
    show table: set text(font: fonts.table)
    // Cancel Typst's default 0.8em scaling and inherit the surrounding size.
    show raw: set text(font: fonts.raw, size: 1em / 0.8)
    show quote: set text(font: fonts.quote)
    show: stystrong.with(font: fonts.strong)
    show: styemph.with(font: fonts.emph)
    show: styref.with(color: ref-color)
    // Theme navigation uses internal links with its own contrast colors.
    // Recolor external URLs only; Ratchet handles numbered references.
    show link: it => {
      if type(it.dest) == str { text(fill: link-color, it) } else { it }
    }
    show: stymatheq.with(font: fonts.math)
    show: with-countblock-font.with(fonts.countblock)
    show: ratchet.with(
      offset: offset,
      eq-depth: matheq-depth,
      eq-outline: matheq-outline,
      eq-color: matheq-color,
      fig-depth: counter-depth,
      fig-outline: counter-outline,
      fig-color: counter-color,
      figure-groups: groups,
    )
    show: labelset
    set-countblock-language(countblock-lang)
    body
  }

  let authors = if type(author) == array { author } else { (author,) }
  let author-content = authors.join([ #h(0.5em) ])
  touying.themes.stargazer.stargazer-theme(
    aspect-ratio: options.aspect-ratio,
    align: options.align,
    progress-bar: options.progress-bar,
    title: self => text(font: fonts.heading, touying.utils.display-current-heading(depth: self.slide-level)),
    footer-a: text(font: fonts.author, author-content),
    footer-b: text(font: fonts.time, if type(time) == datetime { time.display() } else { time }),
    footer-c: text(font: fonts.header, if options.short-title == auto { title } else { options.short-title }),
    touying.config-info(
      title: text(font: fonts.title, title),
      subtitle: if info == none or info == "" { none } else { text(font: fonts.info, info) },
      // Keep PDF metadata plain (including the empty-author case), while
      // Stargazer's separate authors field carries title-page font styling.
      author: authors.map(item => {
        let plain = touying.utils.markup-text(item)
        if plain == none { "" } else { plain }
      }),
      authors: authors.map(item => text(font: fonts.author, item)),
      date: if time == "" or time == none { none } else if type(time) == datetime { time } else { text(font: fonts.time, time) },
      institution: options.institution,
      logo: options.logo,
    ),
    touying.config-colors(..options.colors),
    extra,
    touying.config-store(scripst-fonts: fonts),
    touying.config-common(
      handout: options.handout,
      frozen-counters: frozen,
      show-strong-with-alert: false,
      new-section-slide-fn: if options.section-slides { touying.themes.stargazer.new-section-slide } else { none },
      subslide-preamble: self => {
        _hidden-headings(self, all-groups, matheq-depth)
        touying.utils.call-or-display(self, extra.at("subslide-preamble", default: none))
      },
    ),
    touying.config-methods(init: init),
    body,
  )
}
