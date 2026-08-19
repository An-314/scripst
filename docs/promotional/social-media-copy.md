# Scripst 宣传文案与视频大纲

## 小红书

### 标题备选

1. 我用 Typst 做课堂笔记：像 Markdown 一样写，排版却像 LaTeX
2. LaTeX 太重、Markdown 不够排版？试试 Typst + Scripst
3. 能跟上课堂速度的数学笔记工具，被我做成了 Typst 包

### 正文

如果你经常写数学、物理笔记，可能也遇到过这个问题：

- Markdown 足够轻，但复杂公式仍要嵌入 TeX，定理、习题和编号也不好统一；
- LaTeX 排版很强，但命令和环境偏重，本地工具链也比较庞大；
- 写课堂笔记时，我更希望输入、预览和修改能连成一个动作。

所以我现在主要使用 Typst，并编写了 Scripst。

Typst 有接近 Markdown 的轻量标记、专业的公式与页面排版、很快的增量编译，以及把依赖版本直接写进源码的现代包管理。以我的实际体验，它可以跟上数学和物理课堂的笔记速度。

Scripst 则在 Typst 上补充了：

- article / report / book 排版预设；
- 字体、间距、目录和链接等集中参数接口；
- 定义、定理、证明、习题、解答等内容块；
- Physica 的 ket、bra 等物理符号与 Tablem 三线表；
- 由 Ratchet 驱动的统一编号、重置和交叉引用。

图片里用同一份二能级量子力学笔记，对比了 Markdown、LaTeX 和 Typst + Scripst 的写法。最后一页不是效果图，而是 Scripst 的真实输出。

项目地址：https://github.com/An-314/scripst

欢迎试用，也欢迎告诉我你最希望增加哪一种学术写作功能。

### 推荐标签

#Typst #LaTeX #Markdown #学术写作 #数学笔记 #物理笔记 #开源项目 #效率工具 #大学生学习

### 配图顺序

1. `why-typst.png`
2. `syntax-comparison-1.png`
3. `syntax-comparison-2.png`
4. `syntax-comparison-3.png`
5. `syntax-comparison-4.png`

## X

### 中文单帖

我做了一个 Typst 学术写作包：Scripst。

像 Markdown 一样轻量，拥有接近 LaTeX 的排版能力；同时提供文章预设、定理/证明/习题块、Physica 物理符号、三线表，以及由 Ratchet 驱动的统一编号与引用。

图中是同一份量子力学笔记的 Markdown / LaTeX / Typst 对比。  
https://github.com/An-314/scripst

#Typst #LaTeX #OpenSource

### English post

I built Scripst for Typst: layout presets, theorem/problem blocks, physics notation, three-line tables, and Ratchet-powered numbering.

Here is the same quantum note in Markdown, LaTeX, and Typst:
https://github.com/An-314/scripst

#Typst #LaTeX #OpenSource

### 四帖 Thread 版本

1. 写数学和物理文档时，我一直想同时得到 Markdown 的轻便、LaTeX 的排版能力和足够快的实时预览。Typst 很接近这个目标，所以我在它上面做了 Scripst。🧵
2. Scripst 提供文章、报告和书籍预设，以及定义、定理、证明、习题、解答等内容块。字体、间距、目录和链接可以从统一接口调整。
3. Physica 提供 ket / bra 等物理符号，Tablem 提供三线表；Ratchet 则统一管理公式、图表和内容块的编号、重置与引用。
4. 下面是同一份二能级量子力学笔记在 Markdown、LaTeX 和 Typst + Scripst 中的写法，以及 Scripst 的真实输出。https://github.com/An-314/scripst

## B 站视频大纲

### 推荐标题

《像 Markdown 一样写，像 LaTeX 一样排：我做了一个 Typst 学术写作包》

### 建议时长

6-8 分钟。

### 0:00-0:25 开场钩子

- 画面：快速切换 Markdown、LaTeX、Typst 三份量子力学源码，再切到最终排版。
- 口播：写数学笔记时，Markdown 不够排版，LaTeX 又容易让写作被命令和编译打断。有没有一种工具能轻量输入，同时直接得到正式文档？
- 屏幕文字：Markdown-like syntax / LaTeX-quality output / instant preview。

### 0:25-1:15 为什么是 Typst

- 展示 `why-typst.png`。
- 介绍轻量标记、专业排版、增量编译和按版本声明依赖的包管理。
- 说明个人使用场景：数学与物理课堂笔记、作业、报告和讲义。
- 表述建议：这是个人工作流体验，不把所有 LaTeX 使用场景简单归结为“慢”。

### 1:15-2:40 同一份量子力学笔记，三种写法

- Markdown：展示公式仍需 TeX、复杂块和编号需要手工约定。
- LaTeX：展示 `itemize`、定理环境、`\frac{}{}`、`\mathrm{d}x`、`braket` 和 `booktabs`。
- Typst + Scripst：展示短公式语法、`definition`、`theorem`、`proof`、`problem`、`solution` 和 `three-line-table`。
- 画面使用三张语法对比图，停留时间要足够让观众阅读。

### 2:40-3:30 真实输出

- 展示 `syntax-comparison-4.png`。
- 强调彩色内容块和三线表不是后期绘制，而是当前版本直接编译的结果。
- 简短解释 ket、bra、braket 与规范微分符号。

### 3:30-4:45 Scripst 解决了什么

- 排版预设：article / report / book。
- 集中参数：字体、段落、目录、链接颜色等。
- 学术内容块：定义、定理、证明、例题、习题、解答、注记。
- Physica 与 Tablem：物理符号、三线表。
- Ratchet：统一编号深度、重置规则和交叉引用。

### 4:45-5:45 实时演示

- 左侧打开 Typst 源码，右侧打开 PDF 预览。
- 新增一个 `theorem`，修改标题或颜色参数，再添加对定理的引用。
- 展示保存后近乎即时的预览变化。
- 避免剪辑得太快，让观众看清实际输入量。

### 5:45-6:30 安装与最小示例

- 展示 Typst Universe 的包引用方式和版本号。
- 给出最短的 `#import`、`#show: scripst.with(...)` 与一个 `#theorem[...]`。
- 如果 Scripst 当前版本依赖特定 Ratchet 版本，在屏幕上明确标注。

### 6:30-7:00 结尾

- 总结：Typst 负责轻量语法、排版与编译体验；Scripst 负责可直接使用的学术写作系统。
- CTA：项目已开源，链接放在简介；欢迎提交 issue、模板示例或功能建议。
- 结尾画面：GitHub 地址、Typst Universe 页面和中英文宣传图。

### 建议素材

- 中英文 `why-typst` 海报。
- 中英文四页语法对比图。
- 15-20 秒真实 Typst 编辑与增量预览录屏。
- GitHub README、Typst Universe 页面、Ratchet 编号演示。
