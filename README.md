## Scripst

**Scripst** 是一个基于 **Typst** 的模板包，提供了一套简约高效的文档模板，适用于日常文档、作业、笔记、论文等场景。

## 📑 目录

- [Scripst](#scripst)
- [📑 目录](#-目录)
- [🚀 特性](#-特性)
- [📦 安装](#-安装)
  - [安装 Typst](#安装-typst)
  - [下载 Scripst 模板](#下载-scripst-模板)
    - [方法 1：手动下载](#方法-1手动下载)
    - [方法 2：使用 Typst 本地包管理](#方法-2使用-typst-本地包管理)
- [📄 使用 Scripst](#-使用-scripst)
  - [引入 Scripst 模板](#引入-scripst-模板)
  - [创建 `article` 文档](#创建-article-文档)
- [🔧 模板参数](#-模板参数)
- [✨ 模板效果示例与说明](#-模板效果示例与说明)
  - [article 文档](#article-文档)
  - [book 文档](#book-文档)
  - [report 文档](#report-文档)
- [📜 贡献](#-贡献)
- [📌 字体](#-字体)
- [📦 依赖](#-依赖)
- [🎯 TODO](#-todo)
---

## 🚀 特性

- 高扩展性：模块化设计，便于对模板进行扩展
- 多语言设计：针对不同语言进行本地化设计
- 支持自定义countblock：方便生成定理、题目等其他计数器以及样式

![Demo0](./previews/article-1.png)
![Demo1](./previews/article-12.png)
![Demo2](./previews/article-9.png)

## 📦 安装

### 安装 Typst

确保已安装 Typst，可以使用以下命令进行安装：

```bash
sudo apt install typst # Debian/Ubuntu
sudo pacman -S typst # Arch Linux
winget install --id Typst.Typst # Windows
brew install typst # macOS
```

或参考 [Typst 官方文档](https://github.com/typst/typst) 了解更多信息。

### 下载 Scripst 模板

#### 方法 1：手动下载
1. 访问 [Scripst GitHub 仓库](https://github.com/An-314/scripst)
2. 点击 `<> Code` 按钮
3. 选择 `Download ZIP`
4. 解压后，将模板文件放入你的项目目录

**目录结构建议**
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
若模板存放于 `src/` 目录下，引入方式：
```typst
#import "src/main.typ": *
```

#### 方法 2：使用 Typst 本地包管理
将 Scripst 存放至：
```
~/.local/share/typst/packages/local/scripst/1.1.0                 # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0                      # Windows
~/Library/Application Support/typst/packages/local/scripst/1.1.0  # macOS
```

```bash 
cd {data-dir}/typst/packages/local/scripst
git clone https://github.com/An-314/scripst 1.1.0
```
其中`data-dir`为Typst的数据目录，如上述Linux系统中的`~/.local/share/typst`，Windows系统中的`%APPDATA%\typst`，macOS系统中的`~/Library/Application Support/typst`。

然后在 Typst 文件中直接引入：
```typst
#import "@local/scripst:1.1.0": *
```
即可使用 Scripst 模板。

使用 `typst init` 快速创建项目：
```bash
typst init @local/scripst:1.1.0 project_name
```

---

## 📄 使用 Scripst

### 引入 Scripst 模板
在 Typst 文件开头引入模板：
```typst
#import "@local/scripst:1.1.0": *
```

### 创建 `article` 文档
```typst
#show: scripst.with(
  title: [Scripst 的使用方法],
  info: [这是文章的模板],
  author: ("作者1", "作者2", "作者3"),
  time: datetime.today().display(),
  abstract: [摘要内容],
  keywords: ("关键词1", "关键词2", "关键词3"),
  contents: true,
  content_depth: 2,
  matheq_depth: 2,
  lang: "zh",
)
```

---

## 🔧 模板参数

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `template` | `str` | `"article"` | 选择模板 (`"article"`, `"book"`, `"report"`) |
| `title` | `content`, `str`, `none` | `""` | 文档标题 |
| `info` | `content`, `str`, `none` | `""` | 文档副标题或补充信息 |
| `author` | `array` | `()` | 作者列表 |
| `time` | `content`, `str`, `none` | `""` | 文档时间 |
| `abstract` | `content`, `str`, `none` | `none` | 文档摘要 |
| `keywords` | `array` | `()` | 关键词 |
| `preface` | `content`, `str`, `none` | `none` | 前言 |
| `font_size` | `length` | `11pt` | 字体大小 |
| `contents` | `bool` | `false` | 是否生成目录 |
| `content_depth` | `int` | `2` | 目录深度 |
| `matheq_depth` | `int` | `2` | 数学公式编号深度 |
| `lang` | `str` | `"zh"` | 语言 (`"zh"`, `"en"`, `"fr"` 等) |

---

## ✨ 模板效果示例与说明

### article 文档

![Article Page 1](./previews/article-1.png) ![Article Page 2](./previews/article-2.png)  
[Aritcle 示例](./docs/builds/article.pdf)

### book 文档

![Book Page 1](./previews/book-1.png) ![Book Page 2](./previews/book-2.png)  
[Book 示例](./docs/builds/book.pdf)

### report 文档

![Report Page 1](./previews/report-1.png) ![Report Page 2](./previews/report-2.png)  
[Report 示例](./docs/builds/report.pdf)

## 📜 贡献

欢迎提交 Issue 或 Pull Request！如果有改进建议，欢迎加入讨论。

- **GitHub 仓库**：[Scripst](https://github.com/An-314/scripst)
- **问题反馈**：提交 Issue 进行讨论

## 📌 字体

本项目依赖以下字体：
- 主要字体：[CMU Serif](https://en.wikipedia.org/wiki/Computer_Modern), [Consolas](https://en.wikipedia.org/wiki/Consolas)
- 备选字体：[Linux Libertine](https://en.wikipedia.org/wiki/Linux_Libertine)
- 以及simsun, SimHei, KaiTi等中文字体
请确保已安装该字体，或根据需要进行替换。

## 📦 依赖

对于部分内容，Scripst 引用了以下 Typst 包：

- [tablem](https://typst.app/universe/package/tablem)
- [physica](https://typst.app/universe/package/physica)

## 🎯 TODO

- [ ] 利用locale进行多语言支持