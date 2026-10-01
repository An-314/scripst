# Font interface regression tests

Run from the package root. `fonts.typ` checks resolved fonts in rendered content
for article, book, and report, including pre-bound and custom countblocks, code,
math, and a multi-page countblock. It requires the DejaVu, Liberation, and SimSun
fonts to inspect the intended output without missing-font warnings.

```sh
typst compile --root . tests/fonts.typ /tmp/fonts-article.pdf
typst compile --root . --input template=book tests/fonts.typ /tmp/fonts-book.pdf
typst compile --root . --input template=report tests/fonts.typ /tmp/fonts-report.pdf
typst compile --root . tests/fonts-header.typ /tmp/fonts-header.pdf
typst compile --root . tests/fonts-scope.typ /tmp/fonts-scope.pdf
```

All `fonts-invalid.typ` cases must fail. Choose a case with `--input case=...`:
`not-dict`, `unknown-key`, `empty-list`, `empty-name`, `wrong-type`, `nested-list`,
`bad-descriptor`.

`fonts-defaults.typ` compares the default appearance against 1.1.3 (both local
package versions must be installed). Render both outputs to images and compare;
the three templates should retain the same page count and appearance.

```sh
typst compile --root . --input version=1.1.3 --input template=book tests/fonts-defaults.typ /tmp/fonts-old.pdf
typst compile --root . --input version=1.2.0 --input template=book tests/fonts-defaults.typ /tmp/fonts-new.pdf
```
