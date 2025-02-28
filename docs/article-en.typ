#import "@local/scripst:1.1.0": *

#show: scripst.with(
  title: [How to Use Scripst],
  info: [article template],
  author: ("AnZrew", "AnZreww", "AnZrewww"),
  time: datetime.today().display(),
  abstract: [Scripst is a Typst language template used to generate simple daily documents to meet the needs of documents, assignments, notes, papers, etc.],
  keywords: (
    "Scripst",
    "Typst",
    "template",
  ),
  contents: true,
  content_depth: 3,
  matheq_depth: 2,
  lang: "en",
)

Typst is a simple document generation language with syntax similar to Markdown's lightweight markup. Using appropriate `set` and `show` commands, you can highly customize the document's style.

Scripst is a Typst template I wrote to generate simple daily documents to meet the needs of documents, assignments, notes, papers, etc.

= Using Scripst to Typeset Typst Documents

== Using Typst

Typst is a lighter language to use compared to LaTeX. Once the template is written, you can complete the document writing with lightweight markup similar to Markdown.

Compared to LaTeX, Typst has the following advantages:
- Extremely fast compilation speed
- Simple and lightweight syntax
- Strong code extensibility
- Easier math formula input
- ...

Therefore, Typst is very suitable for writing lightweight daily documents. You can get even better typesetting results than LaTeX with the time cost of writing Markdown.

You can install Typst in the following ways:

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

You can also find more information in the #link("https://github.com/typst/typst")[Typst GitHub repository].

== Using Scripst

Based on Typst, Scripst provides some templates to generate simple daily documents.

You can find and download Scripst templates in the #link("https://github.com/An-314/scripst")[Scripst GitHub repository].

You can choose `<> code` $->$ `Download ZIP` to download the Scripst templates. When using them, just place the template files in your document directory and import the template files at the beginning of your document.

#countblock("cau", cb, count: false)[
  Consider the project directory structure to correctly import the template files.
  ```
  project/
  ├── src/
  │   ├── main.typ
  │   ├── ...
  │   └── components.typ
  ├── pic/
  │   ├── ...
  ├── main.typ
  ├── chap1.typ
  ├── chap2.typ
  ├── ...
  ```
  If the project directory structure is as shown above, then the way to import the template files in `main.typ` should be:
  ```typst
  #import "src/main.typ": *
  ```
]

The advantage of this method is that you can adjust some parameters in the template at any time. Since the template is designed modularly, you can easily find and modify the parts you need to change.

*A better way* is to refer to the official #link("https://github.com/typst/packages?tab=readme-ov-file#local-packages")[local package management documentation] and place the template files in the local package management directory `{data-dir}/typst/packages/{namespace}/{name}/{version}`, so you can use the Scripst templates anywhere.

Of course, you don't need to worry about not being able to modify the template files. You can directly use `#set, #show` commands in the document to override some parameters in the template.

For example, the template should be placed in
```
~/.local/share/typst/packages/local/scripst/1.1.0  # in Linux
%APPDATA%\typst\packages\local\scripst\1.1.0       # in Windows
```
If the directory structure is like this, then the way to import the template files in the document should be:
```typst
#import "@local/scripst:1.1.0": *
```
The advantage of this is that you can directly use `typst init` to create a new project with the template:
```bash
typst init @local/scripst:1.1.0 project_name
```
#newpara()

After importing the template, create an `article` file in this way:

```typst
#show: scripst.with(
  title: [How to Use Scripst],
  info: [This is the article template],
  author: ("Author1", "Author2", "Author3"),
  time: datetime.today().display(),
  abstract: [Abstract],
  keywords: ("Keyword1", "Keyword2", "Keyword3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "en",
)
```

These parameters and their meanings are explained in @para.

Now you can start writing your document.

= Template Parameter Description <para>

The Scripst template provides some parameters to customize the document's style.

```typst
#let scripst(
  template: "article",  // str: ("article", "book", "report")
  title: "",            // str, content, none
  info: "",             // str, content, none
  author: (),           // array
  time: "",             // str, content, none
  abstract: none,       // str, content, none
  keywords: (),         // array
  font_size: 11pt,      // length
  contents: false,      // bool
  content_depth: 2,     // int
  matheq_depth: 2,      // int: (1, 2)
  lang: "en",           // str: ("zh", "en", "fr", ...)
  body,
) = {
  ...
}
```

#newpara()

== template

#figure(
  three-line-table[
    | Parameter | Type | Optional Values | Default Value | Description |
    | --- | --- | --- | --- | --- |
    | template | `str` | `("article", "book", "report")` | `"article"` | Template type |
  ],
  numbering: none,
)

#newpara()

Currently, Scripst provides three templates: article, book, and report.

This template uses the article template.

- article: Suitable for daily documents, assignments, small notes, small papers, etc.
- book: Suitable for books, course notes, etc.
- report: Suitable for lab reports, papers, etc.

Other string inputs will cause `panic`: `"Unknown template!"`.

== title

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | title | `content`, `str`, `none`| `""` | Document title |
  ],
  numbering: none,
)

#newpara()

The document title. (If not empty) it will appear at the beginning of the document and in the header.

== info

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | info | `content`, `str`, `none`| `""` | Document information |
  ],
  numbering: none,
)

#newpara()

The document information. (If not empty) it will appear at the beginning of the document and in the header. It can be used as a subtitle or supplementary information for the article.

== author

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | author | `array`| `()` | Document authors |
  ],
  numbering: none,
)

#newpara()

The document authors. Pass in a list of `str` or `content`.

#countblock(
  "cau",
  cb,
  count: false,
)[Note, if there is only one author, do not pass in `str` or `content`, but pass in a list of `str` or `content`, for example: `author: ("Author",)`]

#newpara()

It will be displayed at the beginning of the article with $min(\#"authors", 3)$ authors per line.

== time

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | time | `content`, `str`, `none`| `""` | Document time |
  ],
  numbering: none,
)

#newpara()

The document time. It will appear at the beginning of the document and in the header.

You can choose to use Typst's `datetime` to get or format the time, such as today's date:

```typst
datetime.today().display()
```
#newpara()

== abstract

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | abstract | `content`, `str`, `none`| `none` | Document abstract |
  ],
  numbering: none,
)

#newpara()

The document abstract. (If not empty) it will appear at the beginning of the document.

It is recommended to define a `content` before using the abstract, for example:

```typst
#let abstract = [
  This is a simple document template used to generate simple daily documents to meet the needs of documents, assignments, notes, papers, etc.
]

#show: scripst.with(
  ...
  abstract: abstract,
  ...
)
```
Then pass it to the `abstract` parameter.

== keywords

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | keywords | `array`| `()` | Document keywords |
  ],
  numbering: none,
)

#newpara()

The document keywords. Pass in a list of `str` or `content`.

Like `author`, the parameter is a list, not a string.

Keywords will only appear at the beginning of the document if `abstract` is not empty.

== font_size

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | font_size | `length`| `11pt` | Document font size |
  ],
  numbering: none,
)

#newpara()

The document font size. The default is `11pt`.

Refer to the `length` type values, you can pass in units such as `pt`, `mm`, `cm`, `in`, `em`, etc.

== contents

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | contents | `bool`| `false` | Whether to generate a table of contents |
  ],
  numbering: none,
)

#newpara()

Whether to generate a table of contents. The default is `false`.

== content_depth

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | content_depth | `int`| `2` | Depth of the table of contents |
  ],
  numbering: none,
)

#newpara()

The depth of the table of contents. The default is `2`.

== matheq_depth

#figure(
  three-line-table[
    | Parameter | Type | Optional Values | Default Value | Description |
    | --- | --- | --- | --- | --- |
    | matheq_depth | `int`| `1`, `2` | `2` | Depth of math equation numbering |
  ],
  numbering: none,
)

#newpara()

The depth of math equation numbering. The default is `2`.

Generally, use `1` when there are no chapters, and use `2` when there are chapters.

== lang

#figure(
  three-line-table[
    | Parameter | Type | Default Value | Description |
    | --- | --- | --- | --- |
    | lang | `str`| `"en"` | Document language |
  ],
  numbering: none,
)

#newpara()

The document language. The default is `"en"`.

You can pass in languages such as `"zh"`, `"en"`, `"fr"`, etc.

== body

When using `#show: scripst.with(...)`, the `body` parameter does not need to be passed manually. Typst will automatically pass the remaining document content to the `body` parameter.

= Template Effect Display

== Document Beginning

The beginning of the document will display the title, information, authors, time, abstract, keywords, etc., as shown at the beginning of this document.

== Table of Contents

If the `contents` parameter is `true`, a table of contents will be generated as shown in this document.

== Fonts and Environments

Scripst provides some commonly used fonts and environments, such as bold, italic, headings, images, tables, lists, quotes, links, math formulas, etc.

=== Fonts

This is normal text. This is normal text.

*This is bold text.* *This is bold text.*

_This is italic text._ _This is italic text._

Install the CMU Serif font for better (LaTeX-like) display effects.

=== Environments

==== Headings

Level 1 headings use Chinese/Roman numerals (depending on the document language), and other levels use Arabic numerals.

==== Images

The image environment will automatically number the images, as shown below:

#figure(
  image("pic/pic.jpg", width: 50%),
  caption: "Scattered Treasure",
)

==== Tables

Thanks to the `tablem` package, you can write tables in Markdown style, as shown below:

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #figure(
    three-line-table[
      | Name | Age | Gender |
      | --- | --- | --- |
      | Zhang San | 18 | Male |
      | Li Si | 19 | Female |
    ],
    caption: [`three-line-table` table example],
  )
  ```
][
  #figure(
    three-line-table[
      | Name | Age | Gender |
      | --- | --- | --- |
      | Zhang San | 18 | Male |
      | Li Si | 19 | Female |
    ],
    caption: [`three-line-table` table example],
  )
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #figure(
    tablem[
      | Name | Age | Gender |
      | --- | --- | --- |
      | Zhang San | 18 | Male |
      | Li Si | 19 | Female |
    ],
    caption: [`tablem` table example],
  )
  ```
][
  #figure(
    tablem[
      | Name | Age | Gender |
      | --- | --- | --- |
      | Zhang San | 18 | Male |
      | Li Si | 19 | Female |
    ],
    caption: [`tablem` table example],
  )
]

You can choose `numbering: none,` to make the table unnumbered, just like the tables in the previous chapters did not enter the full text table counter.

==== Math Formulas

Math formulas have inline and block modes.

Inline formula: $a^2 + b^2 = c^2$.

Block formula:
$
  a^2 + b^2 = c^2 \
  1 / 2 + 1 / 3 = 5 / 6
$
are numbered.

Thanks to the `physica` package, Typst's simple math input method is greatly expanded while still retaining its simplicity:
$
  &div vb(E) &=& rho / epsilon_0 \
  &div vb(B) &=& 0 \
  &curl vb(E) &=& -pdv(vb(B),t) \
  &curl vb(B) &=& mu_0 (vb(J) + epsilon_0 pdv(vb(E),t))
$

#newpara()

=== Lists

Typst provides a simple environment for lists, as shown:

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  - First item
  - Second item
  - Third item
  ```
][
  - First item
  - Second item
  - Third item
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  +  First item
  3. Second item
  +  Third item
  ```
][
  + First item
  3. Second item
  + Third item
]

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  / First item: 1
  / Second item: 2
  / Third item: 23
  ```
][
  / First item: 1
  / Second item: 2
  / Third item: 3
]

#newpara()

=== Quotes

#grid(columns: (1fr, 1fr), align: (horizon, horizon))[
  ```typst
  #quote(attribution: [*Einstein*], block: true)[
    God does not play dice with the universe.
  ]
  ```
][
  #quote(attribution: [*Einstein*], block: true)[
    God does not play dice with the universe.
  ]
]

#newpara()

=== Links

#grid(columns: (1fr, 1fr), align: (horizon, horizon + center))[
  ```typst
  #link("https://www.google.com/")[Google]
  ```
][
  #link("https://www.google.com/")[Google]
]

#newpara()

=== Hyperlinks and Citations

Use `<label>` and `@label` to achieve hyperlinks and citations.

== `#newpara()` Function

Due to the design, some modules do not automatically wrap. This is necessary, for example, if the explanation of the above math formula does not wrap.

But sometimes we need to wrap, and this is where the `#newpara()` function comes in.

Unlike the official `#parbreak()` function, the `#newpara()` function inserts a blank line between paragraphs, so it will start a new natural paragraph in any scenario.

Whenever you feel the need to wrap, you can use the `#newpara()` function.

== Countblock

Countblock is a counter module provided by Scripst to count specific elements in a document.

The global variable `cb` stores all available counters, and you can add a counter using the `add_countblock` function.

Default countblocks are initialized as follows:
```typst
#let cb = (
  "thm": ("Theorem", rgb("#817ffaa5")),
  "def": ("Definition", rgb("#72ab68ab")),
  "prob": ("Problem", rgb("#ac2df653")),
  "prop": ("Proposition", rgb("#6f68abab")),
  "note": ("Note", rgb("#464040ad")),
  "cau": ("⚠️", rgb("#f62d2d53")),
)
```
These counters are pre-initialized and ready for use.

#countblock("note", cb, count: false)[
  Since Typst functions do not support pointers or references, passed variables cannot be modified. Instead, the function must return a modified value to be passed to the next function. Currently, no better solution has been found.
]

#newpara()

=== Creating and Registering a Countblock

You can add (or override) a counter using `add_countblock` and register it using `register_countblock`:
```typst
#let cb = add_countblock("test", "This is a test", teal)
#show: register_countblock.with("test")
```
After registration, the `countblock` function can be used to count elements with this counter.

#let cb = add_countblock("test", "This is a test", teal)
#show: register_countblock.with("test")

=== Using Countblock

A `countblock` can be created using:
```typst
#countblock(
  name,
  subname,
  count: true,
  cb: cb,
)[
  ...
]
```
Where `name` is the counter name, `subname` specifies the entry name, `count` determines if counting is enabled, and `cb` is the counter list. For example:
```typst
#countblock("thm", subname: "Fermat's Little Theorem", cb)[
  If $p$ is a prime number, then for any integer $a$, the number $a^p - a$ is an integer multiple of $p$.
  $
    a^p eq.triple a (mod p)
  $
]
#proof[Omitted.]
```
This creates a theorem block with numbering:

#countblock("thm", subname: [_Fermat's Little Theorem_], cb)[
  If $p$ is a prime number, then for any integer $a$, the number $a^p - a$ is an integer multiple of $p$.
  $
    a^p eq.triple a (mod p)
  $
]
#proof[Omitted.]

You can also encapsulate it as another function:
```typst
#let test = countblock.with()
```
For the newly created `test` counter, use `countblock` to count:
```typst
#countblock("test", cb)[
  1 + 1 = 2
]

#test[
  1 + 2 = 3
]
```
#let test = countblock.with("test", cb)
#countblock("test", cb)[
  1 + 1 = 2
]
#test[
  1 + 2 = 3
]

Default counters can also be used directly:
```typst
#definition(subname:[...])[]
#theorem(subname:[...])[]
#proposition(subname:[...])[]
#problem(subname:[...])[]
#note[]
#caution[]
#proof[]
```

#definition[

  This is a definition. Please understand it.
]

#theorem[

  This is a theorem. Please prove it.
]

#proposition[

  This is a proposition. Please prove it.
]

#proof[
  It is obvious.
]

#problem[

  This is a problem. Please solve it.
]

#note(count: false)[

  This is a note. Please take note of it.
]

#caution(count: false)[
  This is a caution. Please be careful with it.
]

#newpara()

These counters follow this numbering logic:
- If there are no sections, there is a single counter.
- If sections exist, the counter follows the format *SectionNumber.CurrentCountInSection*.

*Thus, you can register and use any number of counters.*

== Conclusion

This document demonstrated the usage of Scripst, including template parameters and their effects.

We hope this guide helps you better utilize Typst and Scripst.

Your suggestions and improvements for Scripst are always welcome, including code contributions.

Thank you for supporting Typst and Scripst!
