#import "template.typ": *

#show: project.with(
  title: [模板的使用方法],
  info: [这是文章的模板],
  authors: (
    "AnZrew",
    "AnZreww",
    "AnZrewww",
  ),
  time: "这是一个时间",
  abstract: [这里是摘要。也可以不要这个摘要，`abstract`的缺省值是`none`，不需要的时候可以不写在函数里。逻辑是要显示`keywords`一定要有`abstract`；没有`keywords`也可以显示`abstract`。],
  keywords: (
    "用",
    `array`,
    "来",
    "输入",
    "关键词",
  ),
  contents:true,
)

选择`contents: true`来显示目录。

通过这样的方式创建一个`article`文件：
```typst
#import "template.typ": *

#show: project.with(
  title: [模板的使用方法],
  info: [这是文章的模板],
  authors: (
    "AnZrew",
    "AnZreww",
    "AnZrewww",
  ),
  time: "这是一个时间",
  abstract: [#lorem(100)],
  keywords: (
    "关键词1",
    "关键词2",
    "关键词3",
    "关键词4",
    "关键词5",
    "关键词6",
  ),
  contents:true,
)
```

= #lorem(3)

#lorem(30)

// 可以用`#let`来定义一些变量，然后在文章中使用
#let footnote1 = [
  《滕王阁序》，原题作《滕王阁诗序》，全名《秋日登洪府滕王阁饯别序》，初唐四杰之一王勃作品，作于唐高宗上元二年九月九日（675年10月3日），是古今传诵的骈文名篇。全篇773字，产生了40个成语，涉及37个典故。
]

豫章故郡，洪都新府。星分翼轸，地接衡庐。襟三江而带五湖，控蛮荆而引瓯越。物华天宝，龙光射牛斗之墟；人杰地灵，徐孺下陈蕃之榻。雄州雾列，俊采星驰。台隍枕夷夏之交，宾主尽东南之美。都督阎公之雅望，棨戟遥临；宇文新州之懿范，襜帷暂驻。十旬休假，胜友如云；千里逢迎，高朋满座。腾蛟起凤，孟学士之词宗；紫电青霜，王将军之武库。家君作宰，路出名区；童子何知，躬逢胜饯。#footnote[#footnote1]


== #lorem(3)

#lorem(30)

时维九月，序属三秋。潦水尽而寒潭清，烟光凝而暮山紫。俨骖𬴂于上路，访风景于崇阿；临帝子之长洲，得天人之旧馆。层峦耸翠，上出重霄；飞阁流丹，下临无地。鹤汀凫渚，穷岛屿之萦回；桂殿兰宫，即冈峦之体势。

+ #lorem(2)

  #lorem(30)

  #lorem(12)

+ #lorem(3)

  #lorem(5)$a^2+b^2=c^2$.#lorem(5)

  #set enum(numbering: "a)")

  + #lorem(3)

  + #lorem(5)

    - #lorem(5)
    - #lorem(5)

  + #lorem(5)

+ #lorem(4)

+ #lorem(5)

- #lorem(5)
- #lorem(5)
  
#lorem(30)

#figure(
  image("pic\散宝.jpg", width: 80%),
  caption: [
    你是一个散兵
  ],
)<lable>

披绣闼，俯雕甍，山原旷其盈视，川泽纡其骇瞩。闾阎扑地，钟鸣鼎食之家；舸舰弥津，青雀黄龙之舳。云销雨霁，彩彻区明。落霞与孤鹜齐飞，秋水共长天一色。渔舟唱晚，响穷彭蠡之滨；雁阵惊寒，声断衡阳之浦。

== #lorem(2)
=== #lorem(3)
==== #lorem(3)
#lorem(12)

$
a^2+b^2=c^2
$

其中$a$、$b$为直角三角形的两条直角边，$c$为斜边。

上面的是没有缩进的，也可以通过`#newpara()`来换行。另外，可以在局部利用`#set math.equation(numbering: none)`来取消公式的编号。

#pad[
#set math.equation(numbering: none)
$
a^2+b^2=c^2
$
]

#newpara()

遥襟甫畅，逸兴遄飞。爽籁发而清风生，纤歌凝而白云遏。睢园绿竹，气凌彭泽之樽；邺水朱华，光照临川之笔。四美具，二难并。穷睇眄于中天，极娱游于暇日。天高地迥，觉宇宙之无穷；兴尽悲来，识盈虚之有数。望长安于日下，目吴会于云间。地势极而南溟深，天柱高而北辰远。关山难越，谁悲失路之人？萍水相逢，尽是他乡之客。怀帝阍而不见，奉宣室以何年？

$
a^2+b^2=c^2
$

```cpp
#include <stdio.h>

int main() {
  printf("Hello, World!");
  return 0;
}
```
#newpara()

嗟乎！时运不齐，命途多舛。冯唐易老，李广难封。屈贾谊于长沙，非无圣主；窜梁鸿于海曲，岂乏明时？所赖君子见机，达人知命。老当益壮，宁移白首之心？穷且益坚，不坠青云之志。酌贪泉而觉爽，处涸辙以犹欢。北海虽赊，扶摇可接；东隅已逝，桑榆非晚。孟尝高洁，空余报国之情；阮籍猖狂，岂效穷途之哭！

= #lorem(5)

#lorem(10)

#figure(
  table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: horizon,
  [散兵：@lable], [*Area*], [*Parameters*],
  [Hello],
  $ pi h (D^2 - d^2) / 4 $,
  [
    $h$: height \
    $D$: outer radius \
    $d$: inner radius
  ],
  [_Bonjour_],
  $ sqrt(2) / 12 a^3 $,
  [$a$: edge length],
  ),
  caption: [你是一个表格]
)

勃，三尺微命，一介书生。无路请缨，等终军之弱冠；有怀投笔，慕宗悫之长风。舍簪笏于百龄，奉晨昏于万里。非谢家之宝树，接孟氏之芳邻。他日趋庭，叨陪鲤对；今兹捧袂，喜托龙门。杨意不逢，抚凌云而自惜；钟期既遇，奏流水以何惭？

呜乎！胜地不常，盛筵难再；兰亭已矣，梓泽丘墟。临别赠言，幸承恩于伟饯；登高作赋，是所望于群公。敢竭鄙怀，恭疏短引；一言均赋，四韵俱成。请洒潘江，各倾陆海云尔：


#quote(attribution: [王勃], block: true)[
  滕王高阁临江渚，佩玉鸣鸾罢歌舞。\
画栋朝飞南浦云，珠帘暮卷西山雨。\
闲云潭影日悠悠，物换星移几度秋。\
阁中帝子今何在？槛外长江空自流。
]


