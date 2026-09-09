#let song = ("CMU Serif", "Linux Libertine", "SimSun")
#let hei = ("CMU Serif", "Linux Libertine", "SIMHEI")
#let kai = ("CMU Serif", "Linux Libertine", "KaiTi")
#let code = "Consolas"
#let smallcap = ("Linux Libertine", "SimSun")

#let font = (
  title: hei,
  author: kai,
  body: song,
  countblock: song,
  heading: hei,
  caption: kai,
  header: smallcap,
  strong: hei,
  emph: kai,
  quote: kai,
  raw: code,
)

#let mycolor = (
  red: rgb("#f44336a0"),
  green: rgb("#4caf50a0"),
  blue: rgb("#2196f3a0"),
  grey: rgb("#9e9e9ea0"),
  purple: rgb("#9c27b0a0"),
  cyan: rgb("#00bcd4a0"),
  orange: rgb("#ff9800a0"),
  violet-light: rgb("#b39ddbaf"),
  violet: rgb("#9575cdb0"),
  violet-dark: rgb("#7e57c2b0"),
  violet-darker: rgb("#673ab7b0"),
  violet-deep: rgb("#5e35b1b0"),
)

#let cb = (
  "def": ((en: "Definition", zh: "定义"), mycolor.green, "def"),
  "thm": ((en: "Theorem", zh: "定理"), mycolor.blue, "thm"),
  "prop": ((en: "Proposition", zh: "命题"), mycolor.violet, "prop"),
  "lem": ((en: "Lemma", zh: "引理"), mycolor.violet-light, "prop"),
  "cor": ((en: "Corollary", zh: "推论"), mycolor.violet-dark, "prop"),
  "rmk": ((en: "Remark", zh: "注"), mycolor.violet-darker, "prop"),
  "clm": ((en: "Claim", zh: "断言"), mycolor.violet-deep, "prop"),
  "ex": ((en: "Exercise", zh: "练习"), mycolor.purple, "ex"),
  "prob": ((en: "Problem", zh: "问题"), mycolor.orange, "prob"),
  "eg": ((en: "Example", zh: "例"), mycolor.cyan, "eg"),
  "note": ((en: "Note", zh: "注记"), mycolor.grey, "note"),
  "cau": ("⚠️", mycolor.red, "cau"),
  "cb-counter-depth": 2,
)
