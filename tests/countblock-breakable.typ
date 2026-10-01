// Run from the package root: typst compile --root . tests/countblock-breakable.typ /tmp/countblock-breakable.pdf
#import "../src/main.typ": *
#set page(width: 330pt, height: 260pt, margin: 20pt)
#show: scripst.with(header: false, matheq-depth: 1, counter-depth: 1, cb-counter-depth: 1)

#let specimen(prefix, render, breakable: auto, splits: false) = {
  let before = label(prefix + "-before")
  let start = label(prefix + "-start")
  let end = label(prefix + "-end")
  let anchor = label(prefix + "-anchor")
  block(height: 105pt)[#metadata(none)#before Lead-in: #prefix]
  let options = if breakable == auto { (:) } else { (breakable: breakable) }
  render(lab: prefix + "-anchor", ..options)[
    #block(height: 45pt)[#metadata(none)#start First part of #prefix.]
    #block(height: 45pt)[Middle part.]
    #block(height: 30pt)[#metadata(none)#end Last part.]
  ]
  context {
    let page-of(lab) = query(lab).first().location().page()
    if splits {
      assert.eq(page-of(start), page-of(before))
      assert(page-of(end) > page-of(start), message: prefix + " must split")
      assert.eq(page-of(anchor), page-of(start))
    } else {
      assert(page-of(start) > page-of(before), message: prefix + " must move to the next page")
      assert.eq(page-of(end), page-of(start), message: prefix + " must stay together")
    }
    // Preserve the existing external anchor. With breakable: false, it may
    // remain on the preceding page when the visible block moves.
  }
  pagebreak()
}

#specimen("default", theorem, splits: true)
#specimen("explicit-true", theorem, breakable: true, splits: true)
#specimen("unbreakable", theorem, breakable: false)
#specimen("default-after-false", theorem, splits: true)
#specimen("unnumbered", note, breakable: false)

#let custom-blocks = add-countblock(cb, "custom", "Custom", blue)
#let custom = countblock.with("custom", custom-blocks, count: false)
#specimen("custom", custom, breakable: false)

References: @default-anchor, @explicit-true-anchor, @unbreakable-anchor.
#context {
  assert.eq(counter(figure.where(kind: "thm")).get(), (4,))
  assert.eq(counter(figure.where(kind: "note")).get(), (0,))
}
