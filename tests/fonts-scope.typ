#import "../src/main.typ": *
#import "../src/fonts.typ": with-countblock-font

#let check(expected) = context { assert.eq(text.font, expected) }
#with-countblock-font("DejaVu Sans")[
  #note[#check("dejavu sans")Outer font]
  #with-countblock-font("DejaVu Serif")[
    #note[#check("dejavu serif")Inner font]
  ]
  #note[#check("dejavu sans")Restored outer font]
]
#note[#check(font.countblock.map(lower))Default font restored]

#scripst(fonts: (countblock: "DejaVu Serif"), header: false)[
  #note[#check("dejavu serif")Custom template font]
]
#scripst(header: false)[
  #note[#check(font.countblock.map(lower))Default template font]
]
