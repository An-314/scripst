# Countblock page-break regression test

Run from the package root:

```sh
typst compile --root . tests/countblock-breakable.typ /tmp/countblock-breakable.pdf
```

The test asserts page locations for default and explicit `true`, per-call `false`,
the default on the next call, unnumbered notes, and custom blocks. It also checks
anchor pages for the breakable samples and that numbering advances once per
numbered block.

The existing external anchor is intentionally unchanged. When `breakable: false`
moves the visible block to the next page, its reference target may remain on the
preceding page; this test does not claim to fix or validate anchor relocation.
