#import "../src/main.typ": *
#import slides: *

#let cases = (
  "not-dict": true,
  "unknown-key": (unknown: true),
  "bad-colors": (colors: true),
  "bad-config": (config: (:)),
)
#show: scripst.with(template: "beamer", beamer: cases.at(sys.inputs.at("case", default: "not-dict")))
#slide[This must not compile.]
