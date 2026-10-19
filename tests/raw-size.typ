// Check the final raw.line style, not just the surrounding raw element.
#import "../src/main.typ": *
#import slides: slide

#let template = sys.inputs.at("template", default: "article")
#let size-input = sys.inputs.at("size", default: "16")
#let requested-size = if size-input == "auto" { auto } else { int(size-input) * 1pt }
#let size = if requested-size == auto {
  if template == "beamer" { 20pt } else { 11pt }
} else { requested-size }
#let expected = state("scripst-test-raw-size", size)
#let inline-count = counter("scripst-test-inline-raw")
#let block-count = counter("scripst-test-block-raw")

#show: scripst.with(
  template: template,
  font-size: requested-size,
  fonts: (body: "DejaVu Serif", raw: "DejaVu Sans Mono"),
  lang: "en",
  header: false,
  beamer: (section-slides: false),
)

#show raw: it => {
  if it.block { block-count.step() } else { inline-count.step() }
  it
}
#show raw.line: it => context {
  assert(calc.abs((text.size - expected.get()) / 1pt) < 0.000001,
    message: "raw size: expected " + repr(expected.get()) + ", got " + repr(text.size))
  assert.eq(text.font, "dejavu sans mono")
  it
}

#let sample = [
  Body text and `inline code` share the configured size.
  ```typst
  #let answer = 42
  ```
  #text(size: 12pt)[
    #expected.update(12pt)
    Local text and `local inline code` are 12 pt.
    ```typst
    #let local = 12
    ```
    #expected.update(size)
  ]
  #[
    #show raw: set text(size: 9pt)
    #expected.update(9pt)
    An explicit override keeps `small inline code` at 9 pt.
    ```typst
    #let small = 9
    ```
    #expected.update(size)
  ]
  #context {
    assert.eq(inline-count.get(), (3,))
    assert.eq(block-count.get(), (3,))
  }
]

#if template == "beamer" { slide(title: [Raw size])[#sample] } else { sample }
