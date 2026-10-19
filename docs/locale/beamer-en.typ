// Compile from the package root:
// typst compile --root . docs/locale/beamer-en.typ
#import "../../src/main.typ": *
#import slides: *

#show: scripst.with(
  template: "beamer",
  title: [From notes to academic slides],
  info: [Scripst 1.2.0 · A two-level quantum system],
  author: ("Scripst examples",),
  time: [1.2.0],
  lang: "en",
  matheq-depth: 1,
  counter-depth: 1,
  cb-counter-depth: 1,
  fonts: (
    body: "Noto Sans",
    title: "Noto Sans",
    heading: "Noto Sans",
    strong: "Noto Sans",
    author: "Noto Sans",
    header: "Noto Sans",
    countblock: "Noto Sans",
    caption: "Noto Sans",
    math: "New Computer Modern Math",
  ),
  beamer: (
    short-title: [Scripst · Beamer],
    institution: [Familiar notation, configurable fonts, consistent numbering],
    section-slides: false,
    colors: (primary: rgb("215B63"), primary-dark: rgb("163F46")),
  ),
)

#title-slide()

= States and measurements

#slide(title: [Keep the notation. Change the layout.])[
  #tblock(title: [Scripst + Touying])[
    Scripst handles fonts, math tools, and numbering. Touying handles slides,
    columns, and incremental reveals.
  ]
  - Switch with `template: "beamer"`.
  - Organize each page with `slide(title: [...])`.
  - Keep Physica's `ket`, `bra`, and Scripst's countblocks.
]

#slide(title: [One quantum state, two columns], composer: (3fr, 2fr))[
  #definition(subname: [Normalized state], lab: "normalized-state", breakable: false)[
    In an orthonormal basis $ket(0), ket(1)$,
    $ ket(psi) = alpha ket(0) + beta ket(1) $
    with $abs(alpha)^2 + abs(beta)^2 = 1$.
  ]
][
  #set text(size: 16pt)
  *Measurement probabilities*

  #three-line-table[
    | Outcome | Probability |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
    | $1$ | $abs(beta)^2$ |
  ]
  #v(0.6em)
  The probabilities sum to $1$; the amplitudes may be complex.
]

#slide(title: [Reveal the expectation value step by step])[
  Let $E_0 = -hbar omega / 2$ and $E_1 = hbar omega / 2$. Then
  $ hat(H) = (hbar omega)/2 (ket(1) bra(1) - ket(0) bra(0)) $

  #pause

  Using @normalized-state and orthonormality,
  $ bra(psi) hat(H) ket(psi) = (hbar omega)/2 (abs(beta)^2 - abs(alpha)^2) $
  // Put pause between complete blocks, not inside a countblock.
]

#slide(title: [One interface, tailored to your talk])[
  #theorem(subname: [Equal probabilities], breakable: false)[
    If $abs(alpha)^2 = abs(beta)^2 = 1/2$, the mean energy is $0$.
  ]
  - Choose fonts with `fonts` and body size with `font-size`.
  - Configure colors, aspect ratio, and handouts with `beamer`.
  - Ratchet keeps numbering and cross-references consistent.
  #v(0.5em)
  #text(size: 0.75em)[Source: `docs/locale/beamer-en.typ` · Guide: `docs/beamer.md`]
]
