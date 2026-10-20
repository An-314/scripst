# Beamer regression checks

Run from the package root. These tests use local source imports and the same
DejaVu/Liberation fonts as the existing font tests.

```sh
typst compile --root . tests/beamer-regression.typ /tmp/beamer-counts.pdf
typst compile --root . --input handout=true tests/beamer-regression.typ /tmp/beamer-handout.pdf
typst compile --root . --input empty-author=true tests/beamer-regression.typ /tmp/beamer-empty-author.pdf
typst compile --root . --input depth=2 tests/beamer-regression.typ /tmp/beamer-depth2.pdf
typst compile --root . --input depth=3 tests/beamer-regression.typ /tmp/beamer-depth3.pdf
typst compile --root . --input depth=3 --input handout=true tests/beamer-regression.typ /tmp/beamer-depth3-handout.pdf
typst compile --root . --input mode=fonts tests/beamer-regression.typ /tmp/beamer-fonts.pdf
typst compile --root . --input mode=fonts --input aspect=4-3 tests/beamer-regression.typ /tmp/beamer-fonts-4-3.pdf
typst compile --root . --input mode=sections tests/beamer-regression.typ /tmp/beamer-sections.pdf
typst compile --root . --input mode=headings tests/beamer-regression.typ /tmp/beamer-headings.pdf
typst compile --root . --input mode=edges tests/beamer-regression.typ /tmp/beamer-edges.pdf
typst compile --root . --input mode=edges --input style-outlined=true tests/beamer-regression.typ /tmp/beamer-edges-style.pdf
typst compile --root . --input mode=visible-headings tests/beamer-regression.typ /tmp/beamer-visible-headings.pdf
typst compile --root . --input mode=visible-headings --input handout=true tests/beamer-regression.typ /tmp/beamer-visible-headings-handout.pdf
```

The numbered-content cases assert unique reference labels, consecutive equation
and countblock numbers, the shared lemma/proposition counter, a custom registry,
a raw figure, and section/subsection prefixes and resets. The first slide has two overlays; the depth-1
case has no headings. The final slide checks its physical page number. Normal
outputs must have **5 pages**, handouts **4 pages**, font outputs **2 pages**,
the heading-only case **2 pages**, the section-divider/edge cases **4 pages**, and the visible-heading case
**3 pages** (**2** in handout mode);
verify the total with `pdfinfo` as well to catch blank trailing pages.

The font case checks title, subtitle, author, date, body, strong, emphasis, raw,
heading, equation, table, caption, and pre-bound/custom countblock roles while
also exercising two-column composition and Physica bra/ket notation. Inspect
the generated pages for clipping/overflow; successful assertions alone do not
guarantee good layout.

The edge case checks `offset: 3`, explicit `outlined: false`, `numbering: none`
(which must still count when outlined), and the existing `<hd.x>` suppression.
The section-divider case also guards against advancing the heading counter twice
when both a divider and a following content slide are present.
The inherited-style variant keeps a locally styled heading and its following
slide in the same scope, avoiding Touying's implicit slide at a closed scope.
The visible-heading case checks that later overlays reuse the first overlay's
hidden-heading snapshot rather than capturing a heading from the previous
overlay's visible body.

Each invalid case must fail with an actionable Scripst diagnostic:

```sh
typst compile --root . --input case=not-dict tests/beamer-invalid.typ /tmp/beamer-invalid.pdf
typst compile --root . --input case=unknown-key tests/beamer-invalid.typ /tmp/beamer-invalid.pdf
typst compile --root . --input case=bad-colors tests/beamer-invalid.typ /tmp/beamer-invalid.pdf
typst compile --root . --input case=bad-config tests/beamer-invalid.typ /tmp/beamer-invalid.pdf
```

Also run the existing article/book/report font and countblock regressions; this
suite does not replace their default-appearance comparisons.
