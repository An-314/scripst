// Presentation helpers are namespaced to avoid changing Scripst's existing exports.
#import "@preview/touying:0.8.0": (
  themes, utils, pause, meanwhile, only, uncover, alternatives, speaker-note, appendix,
  config-common, config-colors, config-info, config-page, config-store,
)
#import themes.stargazer: title-slide, tblock, focus-slide, ending-slide
#import "configs.typ": font

// Only style the title; pass slide bodies through for Touying's parser.
#let _title(value) = if value == auto or value == none { value } else {
  self => text(
    font: self.store.at("scripst-fonts", default: font).heading,
    utils.call-or-display(self, value),
  )
}

#let slide(title: auto, ..args) = themes.stargazer.slide(title: _title(title), ..args)
#let outline-slide(title: utils.i18n-outline-title, ..args) = themes.stargazer.outline-slide(title: _title(title), ..args)
