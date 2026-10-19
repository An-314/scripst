// Compile from the package root:
// typst compile --root . docs/beamer.typ
#import "../src/main.typ": *
#import slides: *

#show: scripst.with(
  template: "beamer",
  title: [从笔记到学术演示],
  info: [Scripst 1.2.0 · 二能级量子系统],
  author: ("Scripst 示例",),
  time: [1.2.0],
  lang: "zh",
  countblock-lang: "zh",
  matheq-depth: 1,
  counter-depth: 1,
  cb-counter-depth: 1,
  fonts: (
    body: ("Noto Sans", "Noto Sans CJK SC"),
    title: ("Noto Sans", "Noto Sans CJK SC"),
    heading: ("Noto Sans", "Noto Sans CJK SC"),
    strong: ("Noto Sans", "Noto Sans CJK SC"),
    author: ("Noto Sans", "Noto Sans CJK SC"),
    header: ("Noto Sans", "Noto Sans CJK SC"),
    countblock: ("Noto Sans", "Noto Sans CJK SC"),
    caption: ("Noto Sans", "Noto Sans CJK SC"),
    math: "New Computer Modern Math",
  ),
  beamer: (
    short-title: [Scripst · Beamer],
    institution: [同一套数学记号、字体接口与编号系统],
    section-slides: false,
    colors: (primary: rgb("215B63"), primary-dark: rgb("163F46")),
  ),
)

#title-slide()

= 量子态与测量

#slide(title: [写作习惯不变，换成演示布局])[
  #tblock(title: [Scripst + Touying])[
    Scripst 管字体、数学工具和编号；Touying 管幻灯片、分栏和逐步显示。
  ]
  - 用 `template: "beamer"` 切换模板。
  - 用 `slide(title: [...])` 明确组织每页。
  - 保留 Physica 的 `ket`、`bra` 与 Scripst 的 countblock。
]

#slide(title: [同一量子态，两栏说明], composer: (3fr, 2fr))[
  #definition(subname: [归一化态], lab: "normalized-state", breakable: false)[
    在正交归一基 $ket(0), ket(1)$ 下，
    $ ket(psi) = alpha ket(0) + beta ket(1) $
    且 $abs(alpha)^2 + abs(beta)^2 = 1$。
  ]
][
  #set text(size: 16pt)
  *测量结果与概率*

  #three-line-table[
    | 结果 | 概率 |
    | :---: | :---: |
    | $0$ | $abs(alpha)^2$ |
    | $1$ | $abs(beta)^2$ |
  ]
  #v(0.6em)
  总概率为 $1$；概率幅本身可以是复数。
]

#slide(title: [一步一步，展示期望值])[
  取能量本征值 $E_0 = -hbar omega / 2$、$E_1 = hbar omega / 2$：
  $ hat(H) = (hbar omega)/2 (ket(1) bra(1) - ket(0) bra(0)) $

  #pause

  由 @normalized-state 和正交归一关系，得到
  $ bra(psi) hat(H) ket(psi) = (hbar omega)/2 (abs(beta)^2 - abs(alpha)^2) $
  // Put pause between complete blocks, not inside a countblock.
]

#slide(title: [同一套接口，按报告调整])[
  #theorem(subname: [等概率态], breakable: false)[
    若 $abs(alpha)^2 = abs(beta)^2 = 1/2$，则能量期望值为 $0$。
  ]
  - 字体：主函数的 `fonts`；正文大小：`font-size`。
  - 配色、比例、单位与讲义模式：`beamer` 字典。
  - 编号与交叉引用继续由 Ratchet 统一管理。
  #v(0.5em)
  #text(size: 0.75em)[源码：`docs/beamer.typ` · 配置说明：`docs/beamer.md`]
]
