## Scripst

**Scripst** 是一个基于 **Typst** 的模板包，提供了一套简约高效的文档模板，适用于日常文档、作业、笔记、论文等场景。

## 📑 目录

- [Scripst](#scripst)
- [📑 目录](#-目录)
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
---

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
~/.local/share/typst/packages/local/scripst/1.1.0  # Linux
%APPDATA%\typst\packages\local\scripst\1.1.0       # Windows
```
然后在 Typst 文件中直接引入：
```typst
#import "@local/scripst:1.1.0": *
```

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
| `author` | `list` | `()` | 作者列表 |
| `time` | `content`, `str`, `none` | `""` | 文档时间 |
| `abstract` | `content`, `str`, `none` | `none` | 文档摘要 |
| `keywords` | `list` | `()` | 关键词 |
| `font_size` | `length` | `11pt` | 字体大小 |
| `contents` | `bool` | `false` | 是否生成目录 |
| `content_depth` | `int` | `2` | 目录深度 |
| `matheq_depth` | `int` | `2` | 数学公式编号深度 |
| `lang` | `str` | `"zh"` | 语言 (`"zh"`, `"en"`, `"fr"` 等) |

---

## ✨ 模板效果示例与说明

### article 文档

[Aritcle 示例](./docs/article.pdf)

### book 文档

[Book 示例](./docs/book.pdf)

### report 文档

[Report 示例](./docs/report.pdf)

## 📜 贡献

欢迎提交 Issue 或 Pull Request！如果有改进建议，欢迎加入讨论。

- **GitHub 仓库**：[Scripst](https://github.com/An-314/scripst)
- **问题反馈**：提交 Issue 进行讨论
