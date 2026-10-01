#import "configs.typ": font

// Keep the public legacy `font` dictionary usable as an override dictionary.
#let default-fonts = (
  ..font,
  raw: (font.raw, "SimSun"),
  info: auto,
  time: auto,
  abstract: auto,
  keywords: auto,
  preface: auto,
  contents: auto,
  table: auto,
  math: auto,
)

#let resolve-fonts(overrides, template: "article") = {
  if type(overrides) != dictionary {
    panic("scripst: fonts must be a dictionary")
  }
  for (role, value) in overrides {
    if role not in default-fonts {
      panic("scripst: unknown fonts key `" + role + "`")
    }
    if value != auto {
      let families = if type(value) == array { value } else { (value,) }
      if families.len() == 0 {
        panic("scripst: fonts." + role + " must not be empty")
      }
      for family in families {
        let name = if type(family) == dictionary { family.at("name", default: none) } else { family }
        if type(name) != str or name == "" {
          panic("scripst: fonts." + role + " must be a font name, font descriptor, or non-empty array of these")
        }
      }
    }
  }
  let result = default-fonts + overrides
  // `auto` restores a legacy role's default or follows a related role.
  for (role, value) in font {
    if result.at(role) == auto { result.insert(role, default-fonts.at(role)) }
  }
  let inherit = (
    info: if template == "article" { "author" } else { "title" },
    time: "body", abstract: "body", keywords: "emph",
    preface: "body", contents: "body", table: "body",
  )
  for (role, parent) in inherit {
    if result.at(role) == auto { result.insert(role, result.at(parent)) }
  }
  result
}

// Pre-bound theorem/note functions read the configuration at their location.
// The default also allows using these components outside `scripst`.
#let countblock-font = state("scripst-countblock-font", font.countblock)

#let with-countblock-font(value, body) = context {
  let previous = countblock-font.get()
  countblock-font.update(value)
  body
  countblock-font.update(previous)
}
