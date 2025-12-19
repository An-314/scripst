// numbering/lib.typ
// Chapter/section-aware numbering utilities with correct cross-references (Typst ≥ 0.13).
//
// Exports:
// - chap-counter
// - extract-heading
// - generate-counter
// - heading-counters
// - fix-numbered-refs
//
// Extra (for custom blocks like countblock):
// - freeze-counter-number
// - install-counter-resets
// - install-cb-counter-resets

#let chap-counter = counter("chap-counter")

#let _last(arr) = arr.at(arr.len() - 1)
#let _last_int(x) = if type(x) == int { x } else { _last(x) }

#let _unique(arr) = {
  let out = ()
  for x in arr {
    if not out.contains(x) { out.push(x) }
  }
  out
}

// Format the chapter/section prefix taken from `chap-counter` at `loc`.
#let extract-heading(depth, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }
  numbering(outline, ..chap-counter.at(loc).slice(0, depth))
}

// Prefix `it` with the current (or provided) chapter/section prefix, depending on `counter-depth`.
//
// counter-depth semantics (same as your original code):
// - 3: use 1.2.3 style when both level-1 and level-2 headings exist
// - 2: use 1.3 style when level-1 headings exist
// - otherwise: show `it` only
#let generate-counter(counter-depth, it, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }

  let has-h1 = query(heading.where(level: 1)).len() != 0
  let has-h2 = query(heading.where(level: 2)).len() != 0

  let strit = if type(it) != str and type(it) != content { str(it) } else { it }

  if has-h1 and has-h2 and counter-depth == 3 {
    extract-heading(2, outline: outline, loc: loc) + "." + strit
  } else if has-h1 and (counter-depth == 3 or counter-depth == 2) {
    extract-heading(1, outline: outline, loc: loc) + "." + strit
  } else {
    strit
  }
}

// --- Custom counters (for theorem/definition blocks, etc.) --------------------
//
// Freeze a prefixed number for an arbitrary counter *at the insertion location*.
//
// Why: figure/equation numbering functions are re-evaluated at the reference site,
// which can make `here()`-based prefixes wrong. By precomputing the final string
// once (at the block's own location) and making the numbering callback return a
// constant, references stay correct.
//
// Assumes you already stepped the counter at this location.
#let freeze-counter-number(counter-name, depth: 2, outline: "1.1", loc: none) = context {
  let loc = if loc == none { here() } else { loc }
  let n = _last_int(counter(counter-name).at(loc))
  generate-counter(depth, n, outline: outline, loc: loc)
}

// Install reset rules for a list of counter names.
// - depth=2/3: reset at level-1
// - depth=3: additionally reset at level-2
#let install-counter-resets(counter-names, depth: 2, body) = {
  let counter-names = _unique(counter-names)

  show heading.where(level: 1, outlined: true): it => {
    if depth == 2 or depth == 3 {
      for name in counter-names { counter(name).update(0) }
    }
    it
  }

  show heading.where(level: 2, outlined: true): it => {
    if depth == 3 {
      for name in counter-names { counter(name).update(0) }
    }
    it
  }

  body
}

// --- Heading backbone ---------------------------------------------------------

// Install chapter counter stepping + counter resets on outlined headings.
// This is the "numbering backbone": it keeps `chap-counter` in sync with headings,
// and resets figure/equation counters when entering a new chapter/section.
//
// Parameters:
// - counter-depth: same meaning as generate-counter (controls when to reset figures)
// - matheq-depth: same meaning as generate-counter (controls when to reset equations)
// - offset: starting chapter number offset (e.g., 0 for normal, -1, 1, etc.)
#let heading-counters(
  counter-depth: 2,
  matheq-depth: 2,
  offset: 0,
  reset-figure-kinds: (image, table, raw),
  body,
) = {
  // Initialize chap-counter to (offset,0,0)
  chap-counter.update((x, ..y) => (offset, 0, 0))

  show heading.where(level: 1, outlined: true): it => {
    if matheq-depth == 2 or matheq-depth == 3 { counter(math.equation).update(0) }
    if counter-depth == 2 or counter-depth == 3 {
      for k in reset-figure-kinds { counter(figure.where(kind: k)).update(0) }
    }
    chap-counter.step(level: 1)
    chap-counter.update((x, ..y) => (x, 0, 0))
    it
  }

  show heading.where(level: 2, outlined: true): it => {
    if matheq-depth == 3 { counter(math.equation).update(0) }
    if counter-depth == 3 {
      for k in reset-figure-kinds { counter(figure.where(kind: k)).update(0) }
    }
    chap-counter.step(level: 2)
    chap-counter.update((x, y, ..z) => (x, y, 0))
    it
  }

  show heading.where(level: 3, outlined: true): it => {
    chap-counter.step(level: 3)
    it
  }

  body
}

// --- Reference fix ------------------------------------------------------------

// Resolve what prefix/supplement should be shown for a ref.
// If the user did not provide a supplement, we fall back to the referenced element's supplement.
#let _resolve-supplement(r, el) = {
  if r.supplement == none or r.supplement == auto { [#el.supplement] } else if type(r.supplement) == function {
    r.supplement(el)
  } else { r.supplement }
}

// Fix `@ref` for figures/equations/custom blocks so that numbering is computed at the referenced element's location.
// This avoids the "引用处章节号污染" problem.
//
// Custom-block support:
// - pass `cb` (kind -> (info, color, counter-name)), OR pass `custom` (kind -> counter-name)
// - the ref will use counter(counter-name) at the referenced location (NOT the figure counter)
#let fix-numbered-refs(
  fig-depth: 2,
  fig-outline: "1.1",
  fig-color: none,
  eq-depth: 2,
  eq-outline: "1.1",
  eq-color: none,
  custom: none,
  custom-depth: none,
  custom-outline: none,
  body,
) = {
  let _paint(content, color) = if color == none { content } else { text(content, fill: color) }
  let _paintc(content, color) = if color == none { content } else { text(fill: color)[#content] }

  show ref: r => context {
    let el = r.element
    if el == none { return r }
    let loc = el.location()

    if el.func() == math.equation {
      let n = _last_int(counter(math.equation).at(loc))
      let num = generate-counter(eq-depth, n, outline: eq-outline, loc: loc)
      return link(loc, _paint("(" + num + ")", eq-color))
    }

    if el.func() == figure {
      // simple custom map: kind -> counter-name
      if custom != none and type(el.kind) == str and (el.kind in custom) {
        let counter-name = custom.at(el.kind)
        let n = _last_int(counter(counter-name).at(loc))
        let depth = if custom-depth != none { custom-depth } else { fig-depth }
        let outline = if custom-outline != none { custom-outline } else { fig-outline }
        let num = generate-counter(depth, n, outline: outline, loc: loc)
        let sup = _resolve-supplement(r, el)
        return link(loc, if sup == [] { _paint(num, fig-color) } else { _paintc([#sup #h(0.15em) #num], fig-color) })
      }

      // Normal figures: use the figure's own counter (by kind) at the referenced location.
      let n = _last_int(counter(figure.where(kind: el.kind)).at(loc))
      let num = generate-counter(fig-depth, n, outline: fig-outline, loc: loc)
      let sup = _resolve-supplement(r, el)
      return link(loc, if sup == [] { _paint(num, fig-color) } else { _paintc([#sup #h(0.15em) #num], fig-color) })
    }
    r
  }
  body
}
