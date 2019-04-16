---
title: Pecan Data Portal 系列教程（一）
author: Jianfeng Li
date: '2017-08-22'
slug: pecan_data_portal_1
categories:
  - tutorial
tags:
  - web
  - visualization
  - bioinformatics
---

## 引言

你正在阅读的是一个系列教程，本系列教程主要讲述了在生物信息学分析过程中常用到的一个数据库/可视化工具——[Pecan Data Portal](https://pecan.stjude.org/home)。在阅读过程中，请带着以下几个问题进行阅读：

- Pecan Data Portal 是一个怎样的工具？
- 它能够被用来做哪些事情？
- 我们应该如何使用它？有哪些小技巧？
- 它有什么优点和缺点？
- 如果你是开发者，你想增加或改进什么功能？

本系列教程将会被拆分为三个部分，分别对以上的五个问题进行相应的介绍或讨论

- 第一部分主要对 Pecan Data Portal 相关的背景及功能做一些介绍
- 第二部分着重对上述第三个问题——**我们该如何使用它**，进行手把手教学
- 第三个部分则是偏讨论性质，在这一部分你可以和他人分享你的意见。设计这一部分的目的是让我们在学会使用一个工具的同时，培养发现并提出问题的能力，这将大大有利于我们以后的学习和科研工作。

以下概念或者内容将有助于你更快地学习和使用 **Pecan Data Portal**：

- 基因的结构
- 基因突变及其类型
- 获得功能与丧失功能的基因突变
- 蛋白质结构域
- 基因芯片和RNA-seq
- FPKM值
- 转录本的概念

以上内容可以查阅百度、谷歌以及本书其他章节，本文将不会深入讲解这些基本概念。

## 简介

### 圣犹大儿童研究医院

圣犹大儿童研究医院（St.Jude Children’s Research Hospital）在全世界享誉盛名，是最早开始利用高通量测序手段研究肿瘤的医院之一。知名的测序项目, [TARGET](https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000471.v15.p7) 中很多样本都是出自这个医院。

特别地，他们是最早在急性淋巴细胞白血病中开展大规模测序项目的研究小组之一，从得到的数据中发现了很多分子标志，并开发了一些治疗药物，为急性淋巴细胞白血病（ALL）生存率的提高做出了重大贡献。

出自圣犹大儿童研究医院课题组与测序相关的部分文章：

- Northcott P A, Buchhalter I, Morrissy A S, et al. The whole-genome landscape of medulloblastoma subtypes[J]. <b>Nature</b>, 2017, 547(7663): 311.
- Liu Y, Easton J, Shao Y, et al. The genomic landscape of pediatric and young adult T-lineage acute lymphoblastic leukemia[J]. <b>Nature genetics</b>, 2017, 49(8): 1211.
- Faber Z J, Chen X, Gedman A L, et al. The genomic landscape of core-binding factor acute myeloid leukemias[J]. <b>Nature genetics</b>, 2016, 48(12): 1551.
- Zhang, Jinghui, et al. "Deregulation of DUX4 and ERG in acute lymphoblastic leukemia." <b>Nature genetics</b>, 48.12 (2016): 1481-1489.
- Holmfeldt L, Wei L, Diaz-Flores E, et al. The genomic landscape of hypodiploid acute lymphoblastic leukemia[J]. <b>Nature genetics</b>, 2013, 45(3): 242-252.
- Zhang J, Ding L, Holmfeldt L, et al. The genetic basis of early T-cell precursor acute lymphoblastic leukaemia[J]. <b>Nature</b>, 2012, 481(7380): 157.
- Mullighan C G, Zhang J, Kasper L H, et al. CREBBP mutations in relapsed acute lymphoblastic leukaemia[J]. <b>Nature</b>, 2011, 471(7337): 235.
- Mullighan C G, Goorha S, Radtke I, et al. Genome-wide analysis of genetic alterations in acute lymphoblastic leukaemia[J]. <b>Nature</b>, 2007, 446(7137): 758.

从2016年开始，他们新发表的与测序相关的文章可视化结果可以在[studies](https://pecan.stjude.org/studies)查阅。

如果你想从事或者正在从事高通量数据分析工作，我想你需要先了解一下你所在的领域有哪些知名的研究所或医院开展过或正在开展大规模测序、他们的数据是否公开、需要哪些程序才可以申请到相关数据、有没有你可以直接用于分析他们数据的工具。

### St. Jude PeCan Data Portal

#### 概况

[PeCan Data Portal](https://pecan.stjude.org/home)的核心工具[ProteinPaint](https://pecan.stjude.org/proteinpaint)于2016年在Nature Genetics上发表，它的主要目的就是为圣犹大儿童研究医院及其合作者进行的基因突变测序项目提供一个交互式的数据可视化工具：

##### 数据概况

在PeCan Data Portal上提供可视化的数据概况：

- <b>3310</b>个样本
- <b>3156</b>个病人
- <b>17</b>种疾病类型（血液肿瘤、脑瘤、实体瘤)
- <b>12520</b>个基因
- <b>35077</b>个基因变异信息（大多数为体细胞突变）

##### 数据来源

他们的数据来源很丰富，北美为主，还包括欧洲、南美洲、日本、澳大利亚、中国、新加坡。

##### 如何引用

- Zhou X, Edmonson M N, Wilkinson M R, et al. Exploring genomic alteration in pediatric cancer using ProteinPaint[J]. <b>Nature genetics</b>, 2016, 48(1): 4-6.

这篇文章现在谷歌学术显示引用13次 （2017年8月22日），你可以查询相关作者的其他文章进行学习，我相信能够开发出PeCan Data Portal的人在高通量测序数据分析上的造诣都不会太低。

#### 主要功能

通过阅读下面的文字和图片资料，你将可以了解PeCan Data Portal及其提供的工具适用于哪些类型的数据、画哪些类型的图。

PeCan Data Portal主要支持八种与基因突变/基因表达数据可视化相关的工具，如果你想进行下面的可视化，请确保你的数据中至少包含以下信息：

- 基因名字：如TP53、DUX4
- 基因突变信息: SNVs和INDELs需要氨基酸改变（形如**p.R175H**）及其对应的转录本编号；融合基因需要5'以及3'基因的染色体坐标及基因的方向；CNV需要有Gain和Loss的信息
- 如果你想使用与UCSC上类似的自定义Track功能，请准备好bigWig(numeric)、标准的bigWigs、JSON-BED、VCF等格式的文件

##### 基因突变模式图

什么是基因突变模式图？

对于有外显子、全基因组数据分析经验的人来说，肯定不会陌生。通常意义上的基因突变模式图就是通过一维序列展示基因、蛋白，然后将发生基因突变的位点标记在基因序列或者蛋白序列上，在蛋白序列上我们可以再将一些已知的结构域(区间)用不同的颜色标记出。另外一种是三维模式图，它与一维突变模式图相比，包含了基因的三维结构。

PeCan Data Portal提供的ProteinPaint工具目前只能用来画**一维的基因突变模式图**，这也是这个工具的核心功能之一，效果图见图一，[点击试用](https://pecan.stjude.org/proteinpaint/TP53)。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig1.png">
<p><b>图一</b> 基因突变模式图</p>
</div>

ProteinPaint的基因突变模式图可以说是目前市面上最好看的一种，支持SNVs、INDELs、以及融合基因的蛋白编码区的可视化，配色极佳，如果你想自己开发相关工具，可以参考该工具使用的颜色主题。

**常见基因组异常类型：**

- Missense (错义突变)
- Frameshift（框移突变，包括插入和缺失）
- Nonsense（无义突变）
- Splice（剪接位点突变）
- Splice region （剪接区突变）
- ProteinIns（非框移插入）
- ProteinDel（非框移缺失）
- UTR_3
- UTR_5
- Intron
- Intergenic
- Fusion transcript（融合基因）
- CNV （拷贝数变异）

**Tips：**

- 注意一下Somatic突变（体细胞突变）和Germline突变（生殖细胞突变）的差异，前者主要存在于肿瘤组织和正常组织的配对研究，特异发生在肿瘤组织中的基因变异我们常称作Somatic突变。而那些在正常对照组织中出现的变异，我们则称为Germline突变，它是可遗传的，一般常见于各类遗传病研究中。
- ProteinPaint蛋白质结构域的数据主要来自[NCBI CDD](https://www.ncbi.nlm.nih.gov/Structure/cdd/cdd.shtml)和[Pfarm](http://pfam.xfam.org/)数据库，如果你觉得他们的结构域不是你想要的，你也可以添加自己设定的结构域信息。
- 除了圣犹大儿童研究医院自己课题组的数据之外，ProteinPaint已经内置了最新版COSMIC数据库和ClinVar数据库，非常方便用户来进行整合分析。


##### 融合基因模式图

什么是融合基因模式图？

和基因突变模式图类似，融合基因模式图也是用来展示基因组变异（结构）的一种方式，它可以清晰的显示出两个基因发生融合的位点，以及各自结构域和基因序列的保留状况。

- 效果图见图二（融合前）和图三（融合后）：

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig2.png">
<p><b>图二</b> 融合基因模式图（融合前）</p>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig3.png">
<p><b>图三</b> 融合基因模式图（融合后）</p>
</div>

融合基因是一种广泛存在于各类肿瘤中的分子异常形式，属于结构变异，目前主要是通过全基因组或RNA-seq数据进行检测（如果你感兴趣可以搜索与融合基因检测的相关方法学文献）。

##### 基因突变热图

什么是基因突变热图？

基因突变热图可以用来直观展示基因变异频率在整体样本中的分布情况，同时可以和一些临床指标进行关联展示，几乎所有大样本WES或WGS测序项目的文章中你都可以看到基因突变热图，它是我们了解某一疾病中基因突变概况（profile）的最直观的方式之一，一般一行代表一个基因，一列代表一个样本。

- 图四是2016年发表在Nature Genetics的[某篇](https://www.nature.com/ng/journal/v48/n12/full/ng.3691.html)文章中的[基因突变热图](https://pecan.stjude.org/proteinpaint/study/HM.BALL.DUX4-ERG..Mullighan%2520DUX4%2520ERG)。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig4.png">
<p><b>图四</b> 基因突变热图</p>
</div>

**Tips：**

- 基因突变热图大致由两个区域构成，一部分为病人数据的一些临床和基本资料（比如是否死亡、数据类型、性别、年龄等等）、另外一部分为病人的基因突变数据
- 基因突变热图上的每一个方格对应一个病人的一个基因，在这个基因上面可以同时发生多种类型的基因突变
- 一般情况下我们会对样本按照表达谱或者已知的亚型进行分组，并将基因按照功能进行分组

##### 突变频率图

基因突变频率是我们研究某一疾病基因变异数据时经常关注的一个问题，如果基因突变发生频率较高，重现次数较多，那么这个基因突变极有可能是该疾病中普遍存在的一种分子标志以及驱动性事件（SNVs、INDELs、Fusions、CNVs）。

- 图五是使用2016年发表在Nature Genetics上的[某篇](https://www.nature.com/ng/journal/v48/n12/full/ng.3691.html)文章数据画的的基因突变频率图
- 图六是一篇2017年发表在Nature Genetics上的[某篇](http://www.nature.com/ng/journal/v49/n8/full/ng.3909.html?foxtrotcallback=true)文章的正图。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig5.png">
<p/><b>图五</b> 基因突变频率图-DUX4_ERG<p/>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig6.png">
<p><b>图六</b> 基因突变频率图-T-ALL</p>
</div>

除了上面这种，另外还可以用柱状图来展示基因突变频率（目前PeCan Data Portal还不支持），如图六-2, 节选至[某篇](http://www.nature.com/ng/journal/v49/n8/full/ng.3900.html?foxtrotcallback=true)文章。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig6-2.png">
<p><b>图六-2</b> 基因突变频率图-T-ALL</p>
</div>


##### 基因功能组突变频率图

基因功能组(Function group)就是将候选基因根据其主要功能分组，然后得到各个功能组在样本中的基因突变分布情况。

常见的基因功能分组：转录因子（Transcription factors ，TFs）、信号分子（Signaling）、表观修饰因子（Epigenetic modifier）、肿瘤抑制因子（Tumor suppressor）、细胞周期相关（Cell cycle）等。

- 图七是2016年发表在Ebiomedcine上[某篇](http://www.ebiomedicine.com/article/S2352-3964(16)30181-5/fulltext)文章的附图的a部分。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig7.png">
<p><b>图七</b> 基因功能组突变频率图</p>
</div>

##### 丝带图

丝带图用的比较少，见图八，在文章正图中很少看到，是一种用于展示疾病或样本分组与基因及其功能组之间的关系的可视化方式。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig8.png">
<p><b>图八</b> 基因功能组突变丝带图</p>
</div>

##### 基因表达相关的可视化

**Boxplot**

ProteinPaint为Pecan Data Portal提供了一个用于查看基因表达水平的Boxplot功能，如图九，上半部分,节选至[ProteinPatin](http://www.nature.com/ng/journal/v48/n1/full/ng.3466.html)，当鼠标移至对应变异位点时，右边的表达水平Boxplot中对应的样本会出现红圈，从而查看有该变异位点的样本在所有样本中基因表达水平的分布情况。

在2017年工具的作者又提供了部分基因芯片得到的基因表达水平，如图九,右下半部分。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig9.png">
<p><b>图九</b> Boxplot</p>
</div>

Boxplot有助于交互式的查看基因突变与其基因表达量的关系，比如癌基因一般是通过基因突变获得功能，使其过量表达而发生作用。 当你在自己的数据中发现某个癌基因（促进细胞增殖、生长等）发生了基因突变，但是它的基因表达量不高，那么其对于该癌基因的激活作用可能就要做进一步探讨了。

##### 基因组范围的可视化

如图十所示，Pecan Data Portal提供[基因组坐标可拖拽式](https://pecan.stjude.org/proteinpaint/study/retina2017)可视化工具，他们使用这个工具展示了人和小鼠视网膜相关的数据（WGBS, ChIPSEQ, chromHMM），并包含了hg19和mm9版本的视网膜RNA表达水平，详细信息可以[参考原文](http://linkinghub.elsevier.com/retrieve/pii/S0896627317303483)。

<div align=center>
<img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-08-22-pecan-data-portal/fig10.png">
<p><b>图十</b> retina2017</p>
</div>

基因组范围的可视化相比于之前的基因突变模式图，它可以切换基因组坐标，而且也支持自定义的track和数据。

#### 相关阅读材料

在之前的文字中有许多与基因组学、转录组学相关的参考文献可供你阅读，或者你也可以在[Pubmed](https://www.ncbi.nlm.nih.gov/pubmed)搜索其他与基因组学、转录组学相关的文献。

下面是一些有用的链接：

**基因测序原始数据仓库**

- [TCGA](https://cancergenome.nih.gov/)
- [EGA](https://www.ebi.ac.uk/ega/home)
- [dbGaP](https://www.ncbi.nlm.nih.gov/gap)
- [DDBJ](http://www.ddbj.nig.ac.jp/)
- [GEO](https://www.ncbi.nlm.nih.gov/geo/)

**在线分析及可视化工具**

- [UCSC](http://genome.ucsc.edu/)
- [Ensembl](http://www.ensembl.org/index.html)
- [cbioPortal](http://www.cbioportal.org/)
- [iCoMut](http://firebrowse.org/iCoMut/?cohort=LAML)
- [Galaxyproject](https://www.galaxyproject.org/)
- [DAVID](https://david.ncifcrf.gov/)
- [Oncoprinter](http://www.cbioportal.org/oncoprinter.jsp)
- [MutationMapper](http://www.cbioportal.org/mutation_mapper.jsp)

**蛋白质结构域相关数据库**

- [CDD](https://www.ncbi.nlm.nih.gov/Structure/cdd/cdd.shtml)
- [UniProt](http://www.uniprot.org/)
- [Pfam](http://pfam.xfam.org/)
- [SMART](http://smart.embl-heidelberg.de/help/smart_glossary.shtml)

**蛋白质-蛋白质相互作用网络**

- [STRING](https://string-db.org/)


### 小结

通过阅读以上内容我相信你对于[PeCan Data Portal](https://pecan.stjude.org/home)及其工具[ProteinPaint](https://pecan.stjude.org/proteinpaint)已经有了一定了解，如果在阅读完以上材料后，想继续学习如何使用这个工具，你可以选择:

- 阅读[官方文档](https://docs.google.com/document/d/1JWKq3ScW62GISFGuJvAajXchcRenZ3HAvpaxILeGaw0/edit)，然后自学，我猜是最好的方式之一，你将会得到极大的锻炼
- [阅读系列文章之（二）](https://life2cloud.com/cn/2017/08/pecan_data_portal_2/)
