---
title: SCI论文插图的那些事
author: Jianfeng Li
date: '2017-07-21'
slug: sci-figures
categories:
  - tutorial
tags:
  - plot
  - sci
---


## SCI 插图入门

### SCI插图的整体要求


SCI杂志种类很多，对插图的要求也各有不同，但是以下几条是通用的：

1. 插图尺寸要符合SCI期刊要求
2. 同篇文稿插图中文字须统一字号及字体
3. 须提交SCI期刊指定文件类型的插图
4. 插图文件命名须符合SCI期刊要求
5. 插图分辨率须符合SCI期刊要求
6. 同篇文稿插图中的线条（描边）粗细须统一
7. 须提交SCI期刊指定颜色模式的插图
8. 插图文件体积须符合SCI期刊要求

听说如果大家的插图做到了上面的要求，杂志编辑会这么给你打分：

![Score](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-21-sci-figures/1.png)

### 编辑插图常用的软件

- **位图编辑类**：Adobe Photoshop（PS）或GIMP(免费软件)
- **矢量绘图类**：Adobe Illustrator（AI）或 CorelDRAW
- **图表制作类**：Graphpad、Origin、SigmaPlot、SPSS、Excel、R Language
- **PDF虚拟打印机**：Adobe Acrobat Professional、PdfFactory
我目前画图的组合，一般是R语言+AI+Ps的组合

### 插图文件的格式


插图文件格式主要有两种：

TIFF和EPS,与之对应的就是位图和矢量图。相机拍出来的都是位图，用函数生成的图都是矢量图

**TIFF格式**：

位图。如使用Photoshop编辑的插图，导出tiff格式图片时请拼合图层（不懂图层概念的同学可以自行百度一下，后面的PS专题，小编会进行介绍）

**EPS格式**：

矢量图。其中可嵌入位图。


补充知识：位图就是由一个一个独立的像素点构成，比如我们用相机拍的自拍，小编放大过自己的自拍，结果被一堆马赛克吓死了；矢量图里面的所有线条都是一个一个的函数，所以无论怎么放大都是不会出现马赛克的！

### 插图文件名的格式

**插图文件名**：

Fig1.tiff、Fig2.tiff...Fig1.eps、Fig2.eps...Figure 1.tiff、Figure 2.tiff(多个图片拼合成一张的，是算做一个图的)，另外个别期刊要求将文稿第一作者或者通讯作者的姓氏与fig组合命名，比如Smith_fig1.tiff。

### SCI插图颜色模式

- **RGB颜色模式**；
- **CMYK色彩模式**；
- **灰度模式**；

大部分SCI期刊都接受RGB颜色模式的插图文件，少数期刊要求作者在出版印刷前提交CMYK颜色模式的插图文件，颜色模式的转换建议在PS等位图编辑软件上进行。此外建议大家作图前先参考待投稿期刊投稿要求中对插图颜色模式的具体规定。

### 字体

**字体**：

Arial 或 Times New Roman（部分期刊也接受Helvetica、Courier等字体）

**字体大小**：

大部分SCI期刊对插图中文字号的要求在 6-12 pt 之间

### 线条粗细及颜色

**线条（描边）粗细**：线条粗细应在 0.2-1.5 pt 之间，过细或者过粗均不美观。

**线条（描边）颜色**：SCI期刊对于线条颜色没有严格规定，黑、白、灰较常见， 如非特殊，一般不建议使用彩色。

### 插图无损压缩及文件大小要求

**插图无损压缩：**

绝大多数SCI期刊都要求作者提交 TIFF格式 的插图文件，因为TIFF文件格式有种神奇能力：无损压缩属性。无论TIFF插图中的内容是位图还是线图，均可以通过LZW无损压缩方式对文件体积压缩，但原图像像素信息及品质丝毫不受损失，为止众多SCI期刊（包括顶级期刊《Nature》）均建议作者通过插图编辑软件（PS或GIMP）对TIFF格式的插图进行LZW压缩处理。

**文件大小**：

由于绝大多数SCI期刊采用网络投稿系统，鉴于网络投稿系统服务器空间和网速的限制，多数杂志建议作者提交的文件大小须控制在 10MB（10240KB）以内。使用LZW压缩过的文件尽量不要超过10MB，如果超过10MB说明版面过大，尽量进行分拆或重新制作。

**插图尺寸**

绝大多数SCI期刊对于插图排版的规格有三种版式：单栏图、1.5栏图、双栏图，三种插图对于插图的宽度设置各不相同，而在两边留白和高度上的要求则没有差别。

<div align=center>
<img src= https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-21-sci-figures/2.png>
</div>

**单栏图**, 一般由一个或多个小图构成，插图总宽度一般为 8~9 cm ，插图左右留白须适度，尽量少留白，SCI期刊对于插图高度的限制较为宽松，但一般不超过 24 cm 。

<div align=center>
<img src= https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-21-sci-figures/3.png>
</div>

**1.5栏图**, 一般由一个或多个小图构成，插图总宽度一般为 11.4~14 cm，插图左右留白须适度，尽量少留白，同样，高度一般不超过 24 cm 。

<div align=center>
<img src= https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-21-sci-figures/4.png>
</div>

**双栏图**, 一般由一个或多个小图构成，插图总宽度一般为 17.1~19 cm，插图左右留白须适度，尽量少留白，同样，高度一般不超过 24 cm 。

来源 | 多译插图规范手册2014版
