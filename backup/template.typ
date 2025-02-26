/* This is a template for writing articles in Chinese. */
#import "@preview/tablex:0.0.6": tablex, hlinex
#import "@preview/tablem:0.1.0": tablem

#let three-line-table = tablem.with(
  render: (columns: auto, ..args) => {
    tablex(
      columns: columns,
      auto-lines: false,
      align: center + horizon,
      hlinex(y: 0),
      hlinex(y: 1),
      ..args,
      hlinex(),
    )
  }
)

#let newpara() = {
  par()[#text(size: 0.0em)[#h(0.0em)]]
  v(-12pt)
}

#let project(
  template: "article",
  title: "",
  info:"",
  authors: (),
  time: "",
  abstract: none,
  keywords: (),
  preface: none,
  contents: false,
  content_depth: 2,
  font_size: 11pt,
  body
) = {
  /****** 设置字体 ******/
  let song = ("CMU Serif", "Linux Libertine", "SimSun")
  let hei = ("CMU Serif", "Linux Libertine", "SIMHEI")
  let kai = ("CMU Serif","Linux Libertine", "KaiTi",)
  let xbsong = "FZXiaoBiaoSong-B05"
  let code = "Consolas"
  let title-font = hei
  let author-font = kai
  let body-font = song
  let heading-font = hei
  let caption-font = kai
  let header-font = kai
  let strong-font = hei
  let emph-font = kai
  let quote-font = kai
  let raw-font = code
  /************************* 初始化文档 *************************/
  set document(author: authors, title: title)
  set heading(numbering: "1.1")
  set text(font: body-font, lang: "zh", region: "cn")
  set bibliography(style: "gb-7714-2015-numeric")
  /************************* 设置样式字体 *************************/
  set par(first-line-indent: 2em,leading: 1.1em)
  set enum(indent: 2em)
  set figure(gap: 0.5cm)
  set text(font: body-font, size: font_size)
  show strong: set text(font: strong-font)
  show emph: set text(font: emph-font)
  show ref: set text(red)
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
  )
  show raw.where(block: true): set par(leading: 0.7em)
  show raw: set text(font: (raw-font, "simsun"), size: 10pt)
  show link: underline
  show link: set text(blue)
  /************************* 调整样式 *************************/
  show heading: it => box(width: 100%)[
    #set text(font: heading-font)
    #v(-0.8em)
    #if it.numbering != none { counter(heading).display() }
    #h(0.2em)
    #it.body
    #v(0.5em)
  ]
  show heading.where(level: 1): it => box(width: 100%)[
    #v(0.3em)
    #set heading(numbering: "一")
    #it
  ]

  /** 把每一板块封装成函数 */
  let mktitle(title) ={
    align(center)[
      #if(template == "report") {
        v(10em)
        block(text(font: title-font, weight: 700, 2.2em, title))
        v(5em)
      } else if(template == "book") {
        v(20em)
        block(text(font: title-font, weight: 700, 2.3em, title))
        v(5em)
      } else [
        #block(text(font: title-font, weight: 700, 2.3em, title))
      ]
  ]}
  let mkinfo(info) = {
    if(info != ""){
      align(center)[
        #if (template in ("report")) {
          align(center)[
            #v(0em)
            #block(text(font: title-font, weight: 700, 2.5em, info))
            #v(15em)
          ]}else if(template in ("book")) {
            block(text(font: title-font, weight: 700, 1.5em, info))
            v(10em)
          }else{
            v(0.5em)
            block(text(font: author-font, 1.5em, info))
        }
      ]
    }
  }
  let mkauthor(author) = {
    let author-size = if(template == "report"){ 1.3em }else{ 1.1em }
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, text(font: author-font,size: author-size, author))),
      ),
    )
  }
  let mktime(time) = {
  if (time != "") {align(center)[
    #if(template in ("report", "book")) {
      v(10em)
      set text(1.3em)
      time
    } else{
      v(-0.3em)
      set text(1em)
      time
  }]}}
  let mkabstruct(abstract, keywords) = {
    if (abstract != none) {
      set par(first-line-indent: 0em,leading: 1.1em)
      v(2pt)
      [*摘要：*#abstract]
      v(1pt)
      if keywords!= () [
        *关键字：* 
        #text(font: kai, keywords.join("；"))
      ]
      v(10pt)
    }
  }
  let mkpreface(preface) = {
    if (preface != none) {
    [
      #v(2em)
      #set align(center)
      #set text(2.5em)
      *前言*
      #v(1em)
    ]
      set par(first-line-indent: 2em,leading: 1.1em)
      v(2pt)
      preface
      v(10pt)
    }
  }
  let mkcontent(contents) = {
    if(contents) {
      set par(first-line-indent: 2em,leading: 1em)
      show outline.entry.where(level: 1): it => {
          v(0.3em)
          h(-2.0em)
          set text(15pt)
          strong(it)
      }
      outline(indent: auto, depth: content_depth, fill: repeat( "  ·"))
      v(20pt)
    }
  }
  // 调整图片
  show figure: it => [
    #v(2pt)
    #set text(font: caption-font)
    #it
    #v(-2em)
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(13pt)
  ]
  show image: it => [
    #it
    #v(-1.1em)
    #par()[#text(size: 0.0em)[#h(1.0em)]]
  ]
  // 调整表格
  show table: it => [
    #set text(font: body-font)
    #it
  ]
  // 调整列表
  show enum: it => [
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(-12pt)
  ]
  show list: it => [
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(-12pt)
  ]
  // 调整引用
  show quote: it => [
    #set text(font: quote-font)
    #align(center)[#it]
  ]
  // 数学公式
  set math.equation(numbering: it => {
    locate(loc => {
      let count = counter(heading.where(level:1)).at(loc).last()
      numbering("(1.1)", count, it)
    })
  })
  // 调整页眉页脚
  let pageheading = [
    #set text(font: header-font)
    #let header = if(template in ("article")) {
      if(selector(heading.where(level:1)) == true) {
        locate(loc => [#locate(loc => [#counter(heading.where(level:1)).display() #query(selector(heading.where(level:1)).before(loc), loc).last().body.text])])
      }else{
        ""
      }
    }else{
      none
    }
    #if(header != "" and header != none) {
      locate(loc => if(loc.page() != 1) [#title #h(1fr) #info #h(1fr) #header])}else{
      locate(loc => if(loc.page() != 1) [#title #h(1fr) #info])
    }
  ]
  

  // 正文
  if(template in ("article")){
    set page(numbering: "1", number-align: center, header: pageheading,)
    mktitle(title)
    mkinfo(info)
    mkauthor(authors)
    mktime(time)
    mkabstruct(abstract, keywords)
    mkcontent(contents)
    body
  }else if(template in ("report")){
    mktitle(title)
    mkinfo(info)
    mkauthor(authors)
    mktime(time)
    if (contents){
      set page(numbering: "I", number-align: center,header: pageheading,)
      counter(page).update(1)
      mkabstruct(abstract, keywords)
      v(2em)
      mkcontent(contents)
    }
    let pageheading = [
      #set text(font: header-font)
      #let header = locate(loc => [#locate(loc => [#counter(heading.where(level:1)).display() #query(selector(heading.where(level:1)).before(loc), loc).last().body.text])])
      #if(header != "" and header != none) {
        locate(loc => if(loc.page() != 1) [#title #h(1fr) #info #h(1fr) #header])}else{
        locate(loc => if(loc.page() != 1) [#title #h(1fr) #info])
      }
    ]
    set page(numbering: "1", number-align: center,header: pageheading,)
    counter(page).update(1)
    if (contents != true){
      mkabstruct(abstract, keywords)
    }
    show heading.where(level:1): it => {
      counter(math.equation).update(0)
      it
    }
    body
  }else if(template in ("book")){
    mktitle(title)
    mkinfo(info)
    mkauthor(authors)
    mktime(time)
    show heading: it => box(width: 100%)[
      #set text(font: heading-font)
      #v(0.5em)
      #if it.numbering != none { counter(heading).display() }
      #h(0.2em)
      #set text(1.2em)
      #it.body
      #v(0.5em)
    ]
    show heading.where(level: 1): it => box(width: 100%)[
      #v(2em)
      #set align(center)
      #set heading(numbering: "一")
      #set text(1.5em)
      #it
      #v(1em)
    ]
    if (preface!=none){
      set page(numbering: "A", number-align: center, header: pageheading,)
      counter(page).update(1)
      mkpreface(preface)
    }
    if (contents){
      set page(numbering: "I", number-align: center, header: pageheading,)
      counter(page).update(1)
      mkcontent(contents)
    }
    let pageheading = [
      #set text(font: header-font)
      #let header = locate(loc => [#locate(loc => [#counter(heading.where(level:1)).display() #query(selector(heading.where(level:1)).before(loc), loc).last().body.text])])
      #if(header != "" and header != none) {
        locate(loc => if(loc.page() != 1) [#title #h(1fr) #info #h(1fr) #header])}else{
        locate(loc => if(loc.page() != 1) [#title #h(1fr) #info])
      }
    ]
    set page(numbering: "1", number-align: center, header: pageheading,)
    counter(page).update(1)
    show heading.where(level:1): it => {
      counter(math.equation).update(0)
      it
    }

    body
  }
}


/************************* 定义常用块 *************************/
#let problem-counter = counter("problem")
#problem-counter.step()

#let problem(body) = {
  problem-counter.step()
  set enum(numbering: "(1)")
  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*题目 #problem-counter.display().* #h(0.75em) #body]
}

#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%
  )[*解答.* #h(0.75em) #body]
}

#let theorem-counter = counter("theorem")
#show heading.where(level:1): it => {
      counter("theorem").update(0)
      it
    }

#let theorem(body, name:none) = {
  theorem-counter.step()
  
  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*Theorem [#counter(heading.where(level:1)).display().#theorem-counter.display()]* #if(name!=none){text(style: "italic",weight: "bold", name)} #h(0.75em) #body]
}

#let proof(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%
  )[_Proof._ #h(0.75em) #body 
  #align(right)[$qed$]
  ]
}
