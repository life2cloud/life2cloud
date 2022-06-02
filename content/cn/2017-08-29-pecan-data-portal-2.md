---
title: Pecan Data Portal 系列教程（二）
author: Jianfeng Li
date: '2017-08-29'
slug: pecan_data_portal_2
categories:
  - tutorial
tags:
  - web
  - visualization
  - bioinformatics
---

## 引言

这是Pecan Data Portal系列教程的第二部分，这一部分主要将介绍Pecan Data Portal一系列可视化工具的使用，第一部分内容可以[点击这里](https://life2cloud.com/cn/2017/08/pecan_data_portal_1/)进行阅读。 （暂时未更新使用讲解，但你可以参考我提供的任务列表进行练习）

在这一部分中的每个小节，我将会首先布置一些任务（推荐你先自行进行尝试完成），然后，我会根据这些任务进行操作，并进行介绍。

使用Pecan Data Portal可视化功能的核心工具请[点击这里](https://pecan.stjude.org/pp)，接下来的操作大部分会在这个页面进行，如果你想将该工具嵌入你自己的网站中，你可以在你的网页代码中加入以下片段：

```html
<script src="https://pecan.stjude.org/pp/bin/proteinpaint.js" charset='utf-8'></script>

<div id=aaa style="margin:10px"></div>

<script>
runproteinpaint({
    host:'https://pecan.stjude.org/pp/',
    holder:document.getElementById('aaa'),
    genome:'hg19',
    gene:'TP53',
    dataset:'clinvar'
})
</script>
```

本教程所有用到的[示例数据](https://github.com/Miachol/Writing-material/tree/master/blog/data/2017-08-29-pecan-data-portal-2)、[脚本代码](https://github.com/Miachol/Writing-material/tree/master/blog/code/2017-08-29-pecan-data-portal-2)均可以在我的github主页找到，如果你想重复我讲述的操作，请将其下载并保存。

## 基因突变模式图

下面是本节的任务列表，通过下面的任务列表，你将学会使用ProteinPaint进行基因突变模式图的绘制，并对其他一些基因突变模式图绘制工具有所了解：

- **任务一：** 使用[ProteinPaint](https://pecan.stjude.org/pp)查看并了解[TP53](http://www.genecards.org/cgi-bin/carddisp.pl?gene=TP53I11)基因的主要结构域及其功能，并添加一个自定义结构域。
- **任务二：** 使用[ProteinPaint](https://pecan.stjude.org/pp)查看在COSMIC和ClinVar数据库中TP53的热点突变有哪些，分别属于哪些突变类型（无义突变、错义突变、框移突变等），并手动添加五个突变类型不一样的基因突变位点。
- **任务三：** 在基因突变模式图中显示RefGene、Genecode、RepeatMasker等track，并添加一条你自定义的track。
- **任务四：** 显示TP53所有转录本的蛋白质编码结构。
- **任务五：** 使用你自己的基因突变数据进行基因突变模式图的绘制，输入数据格式[参考](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.snvindel.txt).

## 融合基因模式图

- **任务一：** 使用[ProteinPaint](https://pecan.stjude.org/pp)查看ETV6-RUNX1的融合基因结构（融合前、融合后），并添加一个自定义断裂位点的融合基因（ETV6-RUNX1）。
- **任务二：** 在[ProteinPaint](https://pecan.stjude.org/pp)中只显示基因组结构，并只显示其中的一个融合基因位点。
- **任务三：** 阅读[CICERO文件格式](https://github.com/Miachol/Writing-material/raw/master/blog/learning/2017-08-29-pecan-data-portal-2/Fusion%20transcript%20data%20format%20by%20CICERO.pdf)，[Fusion Editor usage](https://github.com/Miachol/Writing-material/raw/master/blog/learning/2017-08-29-pecan-data-portal-2/Fusion%20Editor%20usage.pdf)了解Fusion Editor的功能和输入文件格式。
- **任务四：** 使用Fusion editor并使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/CICERO-demo.txt)数据查看其中的in-frame以及truncation的融合基因结构和其他信息。
- **任务五：** 使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.svfusion.txt)数据进行融合基因数据可视化。

## 基因突变热图

- **任务一：** 在[studies](https://pecan.stjude.org/studies)查看St. Jude Children's Research Hospital近两年的高通量测序文章基因突变热图可视化结果。
- **任务二：** 在[DUX_ERG](https://pecan.stjude.org/proteinpaint/study/HM.BALL.DUX4-ERG..Mullighan%2520DUX4%2520ERG)基因突变热图中调整基因功能组顺序、样本分组顺序。
- **任务三：** 在[DUX_ERG](https://pecan.stjude.org/proteinpaint/study/HM.BALL.DUX4-ERG..Mullighan%2520DUX4%2520ERG)基因突变热图中通过JSON格式的Schema调整显示样式。
- **任务四：** 使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.snvindel.txt)数据绘制基因突变热图，并在热图上添加Meta行（如样本分组）。

## 突变频率图

- **任务一：** 选择[studies](https://pecan.stjude.org/studies)中三个研究，将其基因突变频率进行可视化展示（分别查看其中最高频异常的基因突变模式图）、并下载其用于可视化的元数据。
- **任务二：** 使用Barplot进行展示展示上面得到的元数据。
- **任务三：** 使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.snvindel.txt)数据绘制突变频率图。

## 基因功能组突变频率图

- **任务一：** 选择[studies](https://pecan.stjude.org/studies)中三个研究，查看其基因功能组突变频率图（Pie Charts），并按照你自己的意愿对其样式进行更改。
- **任务二：** 使用AI对上面得到的基因功能组突变频率图进行修饰、美化。
- **任务三：** 使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.snvindel.txt)数据绘制基因功能组突变频率图。

## 丝带图

- **任务一：** 选择[studies](https://pecan.stjude.org/studies)中三个研究，查看其丝带图（Ribbon graph）。
- **任务二：** 使用[Demo](https://raw.githubusercontent.com/Miachol/Writing-material/master/blog/data/2017-08-29-pecan-data-portal-2/example.snvindel.txt)数据绘制丝带图。

## 基因表达相关的可视化

- **任务一：** 使用[ProteinPaint](https://pecan.stjude.org/pp)查看[JAK2](http://www.genecards.org/cgi-bin/carddisp.pl?gene=JAK2&search=growth/size/body)，和[PAX5](http://www.genecards.org/cgi-bin/carddisp.pl?gene=PAX5&keywords=PAX5)进行融合的样本中其JAK2的基因表达水平，并下载相应的FPKM数据。

## 基因组范围的可视化

- **任务一：** 查看[Retina2017](https://pecan.stjude.org/proteinpaint/study/retina2017)可视化结果，并添加Genecode、RepeatMasker以及自定义的track。
- **任务二：** 在[Retina2017](https://pecan.stjude.org/proteinpaint/study/retina2017)可视化结果中查看TP53、SIX6的基因表达水平及其与表观遗传学相关的Motif。
- **任务三：** 分别使用UCSC和ProteinPaint展示自定义的track.
