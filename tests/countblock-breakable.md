# Countblock page-break regression test

Run from the package root:

```sh
typst compile --root . tests/countblock-breakable.typ /tmp/countblock-breakable.pdf
```

The test asserts page locations for default and explicit `true`, per-call `false`,
the default on the next call, unnumbered notes, and custom blocks. It also checks
that reference anchors stay with the visible block and numbering advances once
per numbered block.
