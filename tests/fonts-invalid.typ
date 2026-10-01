// Every case must fail with a clear `scripst: fonts...` error.
#import "../src/main.typ": scripst
#let cases = (
  "not-dict": "CMU Serif",
  "unknown-key": (boddy: "CMU Serif"),
  "empty-list": (raw: ()),
  "empty-name": (body: ""),
  "wrong-type": (heading: 12pt),
  "nested-list": (raw: (("Consolas", "SimSun"),)),
  "bad-descriptor": (body: (covers: "latin-in-cjk")),
)
#show: scripst.with(fonts: cases.at(sys.inputs.at("case", default: "unknown-key")))
Invalid configuration.
