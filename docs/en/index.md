<h1 align="center">
Scripst
</h1>

**Scripst** is a template package based on **Typst**, offering a set of simple and efficient document templates suitable for everyday documents, assignments, notes, papers, and other scenarios.

<div align="center">

![Version](https://img.shields.io/badge/version-1.1.0-limegreen.svg)
![License](https://img.shields.io/badge/license-MIT-greenyellow.svg)
[![Docs Online](https://img.shields.io/badge/docs-online-lawngreen.svg)](https://an-314.github.io/scripst/)


</div>

## 📑 Contents

- [📑 Contents](#-contents)
- [🚀 Features](#-features)
- [📦 Installation](#-installation)
  - [Install Typst](#install-typst)
  - [Download Scripst Template](#download-scripst-template)
    - [Method 1: Download Manually](#method-1-download-manually)
    - [Method 2: Use Typst Local Package Management](#method-2-use-typst-local-package-management)
- [📄 Using Scripst](#-using-scripst)
  - [Import Scripst Template](#import-scripst-template)
  - [Create `article` Document](#create-article-document)
- [🔧 Template Parameters](#-template-parameters)
- [✨ Template Examples and Explanations](#-template-examples-and-explanations)
  - [Article](#article)
  - [Book](#book)
  - [Report](#report)
- [📜 Contributing](#-contributing)
- [📌 Fonts](#-fonts)
- [📦 Dependencies](#-dependencies)
- [🎯 TODO](#-todo)
* * *

## 🚀 Features

* High Extensibility: Modular design, easy to extend the templates.
* Multilingual Design: Localization for different languages.
* Supports custom countblock: Convenient for generating theorems, problems, and other counters or styles.

![Demo0](./previews/article-1.png)
![Demo1](./previews/article-12.png)
![Demo2](./previews/article-9.png)

## 📦 Installation

### Install Typst

Make sure Typst is installed. You can install it using the following commands:

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

Or refer to the [Typst official documentation](https://github.com/typst/typst) for more information.

### Download Scripst Template

#### Method 1: Download Manually

1. Visit the [Scripst GitHub repository](https://github.com/An-314/scripst)
2. Click the `<> Code` button
3. Choose `Download ZIP`
4. After extraction, place the template files into your project directory.

**Suggested directory structure**
```plaintext
project/
├── src/
│   ├── main.typ
│   ├── components.typ
├── pic/
│   ├── image.jpg
├── main.typ
├── chap1.typ
├── chap2.typ
```

If the template is stored in the `src/` directory, import it like this:

```typst
#import "src/main.typ": *
```

#### Method 2: Use Typst Local Package Management

You can manually download Scripst and store it in:

```
~/.local/share/typst/packages/local/scripst/1.1.0                 # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0                      # Windows
~/Library/Application Support/typst/packages/local/scripst/1.1.0  # macOS
```

or using these commands:

```bash
cd {data-dir}/typst/packages/local/scripst
git clone https://github.com/An-314/scripst 1.1.0
```

Where `data-dir` refers to Typst's data directory, such as `~/.local/share/typst` for Linux, `%APPDATA%\typst` for Windows, and `~/Library/Application Support/typst` for macOS.

Then import directly in your Typst file:
```typst
#import "@local/scripst:1.1.0": *
```
Now you can use the Scripst template.

Use `typst init` to quickly create a project:

```bash
typst init @local/scripst:1.1.0 project_name
```

* * *

## 📄 Using Scripst

### Import Scripst Template

Import the template at the beginning of your Typst file:
```typst
#import "@local/scripst:1.1.0": *
```

### Create `article` Document

```typst
#show: scripst.with(
  title: [How to Use Scripst],
  info: [This is an article template],
  author: ("Author1", "Author2", "Author3"),
  time: datetime.today().display(),
  abstract: [Abstract content],
  keywords: ("Keyword1", "Keyword2", "Keyword3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "en",
)
```

* * *

## 🔧 Template Parameters

| Parameter | Type | Default Value | Description |
| --- | --- | --- | --- |
| `template` | `str` | `"article"` | Choose template (`"article"`, `"book"`, `"report"`) |
| `title` | `content`, `str`, `none` | `""` | Document title |
| `info` | `content`, `str`, `none` | `""` | Document subtitle or supplementary information |
| `author` | `array` | `()` | List of authors |
| `time` | `content`, `str`, `none` | `""` | Document date |
| `abstract` | `content`, `str`, `none` | `none` | Document abstract |
| `keywords` | `array` | `()` | Keywords |
| `preface` | `content`, `str`, `none` | `none` | Preface |
| `font_size` | `length` | `11pt` | Font size |
| `contents` | `bool` | `false` | Whether to generate a table of contents |
| `content_depth` | `int` | `2` | Table of contents depth |
| `matheq_depth` | `int` | `2` | Math equation numbering depth |
| `lang` | `str` | `"zh"` | Language (`"zh"`, `"en"`, `"fr"`, etc.) |

* * *

## ✨ Template Examples and Explanations

### Article 

![Article Page 1](./previews/article-1.png) ![Article Page 2](./previews/article-2.png)  
[Aritcle Demo](./docs/locale/builds/article-en.pdf) 

### Book

![Book Page 1](./previews/book-1.png) ![Book Page 2](./previews/book-2.png)  
[Book Demo](./docs/builds/book.pdf) *(Only in Simplified Chinese)*


### Report

![Report Page 1](./previews/report-1.png) ![Report Page 2](./previews/report-2.png)  
[Report Demo](./docs/builds/report.pdf) *(Only in Simplified Chinese)*

## 📜 Contributing

Feel free to submit issues or pull requests! If you have any improvement suggestions, join the discussion.

* **GitHub Repository**: [Scripst](https://github.com/An-314/scripst)
* **Issue Feedback**: Submit an issue to discuss

## 📌 Fonts

This project uses the following fonts by default:

* Primary fonts: [CMU Serif](https://en.wikipedia.org/wiki/Computer_Modern), [Consolas](https://en.wikipedia.org/wiki/Consolas)
* Alternative fonts: [Linux Libertine](https://en.wikipedia.org/wiki/Linux_Libertine)
* Chinese fonts such as SimSun, SimHei, KaiTi, etc. 

If using these default fonts, please make sure they are correctly installed. Otherwise, replace them if needed in `./src/configs.typ`.

## 📦 Dependencies

For certain content, Scripst uses the following Typst packages:

* [tablem](https://typst.app/universe/package/tablem)
* [physica](https://typst.app/universe/package/physica)

## 🎯 TODO

* [ ] Add `beamer` template