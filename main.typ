#import "@local/scripst:1.1.0": *

#show: scripst.with(
  title: [],
  info: [],
  author: (),
  time: datetime.today().display(),
  abstract: [],
  keywords: (),
  contents: true,
  content_depth: 3,
  matheq_depth: 2,
  lang: "zh",
)
