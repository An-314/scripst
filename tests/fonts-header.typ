#import "../src/main.typ": *

#show regex("AuthorProbe"): it => context {
  assert.eq(text.font, "dejavu sans mono")
  it
}
#show regex("HeaderProbe"): it => context {
  assert.eq(text.font, if here().position().page == 1 { "dejavu serif" } else { "liberation mono" })
  it
}
#show: scripst.with(
  title: [HeaderProbe],
  author: ("AuthorProbe",),
  fonts: (title: "DejaVu Serif", author: "DejaVu Sans Mono", header: "Liberation Mono"),
)
= First
Body.
#pagebreak()
Continuation page.
