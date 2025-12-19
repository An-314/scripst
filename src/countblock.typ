#import "components.typ": *
#import "configs.typ": *
#import "numbering/lib.typ": *


#let add-countblock(cb, name, info, color, counter-name: none) = {
  if counter-name == none { counter-name = name }
  cb.insert(name, (info, color, counter-name))
  return cb
}

#let reg-countblock(counter-name, cb-counter-depth: cb.at("cb-counter-depth"), body) = {
  show heading.where(level: 1, outlined: true): it => {
    if cb-counter-depth == 2 or cb-counter-depth == 3 { counter(counter-name).update(0) }
    it
  }
  show heading.where(level: 2, outlined: true): it => {
    if cb-counter-depth == 3 { counter(counter-name).update(0) }
    it
  }
  body
}

#let countblock(name, cb, cb-counter-depth: cb.at("cb-counter-depth"), subname: "", count: true, lab: none, body) = {
  let (info, color, counter-name) = cb.at(name)
  if cb.at(name) == none { panic("countblock: block not registered") }

  // 1) 先 step（让计数器在这个位置 +1）
  if count { counter(counter-name).step() }

  // 2) 在“插入位置”冻结出最终字符串（含章节前缀）
  let num = if count { freeze-counter-number(counter-name, depth: cb-counter-depth) } else { "" }

  let title = info + " " + num + " " + subname

  // 3) figure 的 numbering 回调直接返回常量 num（不要再在回调里读 here()/counter.display()）
  block(
    fill: color.transparentize(60%),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
    stroke: (left: (thickness: 4pt, paint: color)),
    [
      *#title* #h(0.75em)
      #figure(
        [],
        caption: none,
        kind: name,
        supplement: cb.at(name).at(0),
        numbering: _ => if count { num } else { none },
      )
      #if lab != none { label(lab) }
      #v(-1em)
      #body
    ],
  )
}

#let definition = countblock.with("def", cb)
#let theorem = countblock.with("thm", cb)
#let proposition = countblock.with("prop", cb)
#let lemma = countblock.with("lem", cb)
#let corollary = countblock.with("cor", cb)
#let remark = countblock.with("rmk", cb)
#let claim = countblock.with("clm", cb)
#let exercise = countblock.with("ex", cb)
#let problem = countblock.with("prob", cb)
#let example = countblock.with("eg", cb)
#let note = countblock.with("note", cb, count: false)
#let caution = countblock.with("cau", cb, count: false)

#let reg-default-countblock(cb-counter-depth: cb.at("cb-counter-depth"), body) = {
  show: reg-countblock.with("def", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("thm", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("prop", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("ex", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("prob", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("eg", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("note", cb-counter-depth: cb-counter-depth)
  show: reg-countblock.with("cau", cb-counter-depth: cb-counter-depth)
  body
}

// Convenience: derive all counter names from your `cb` registry
// (kind -> (info, color, counter-name)).
#let install-cb-counter-resets(cb, depth: cb.at("cb-counter-depth"), body) = {
  let names = ()
  for (k, v) in cb.pairs() {
    if type(k) == str and k != "cb-counter-depth" {
      names.push(v.at(2))
    }
  }
  install-counter-resets(names, depth: depth)[body]
}
