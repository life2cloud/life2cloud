---
title: 肿瘤驱动事件识别算法
author: Jianfeng Li
date: '2017-07-31'
slug: jcb-cancer-driver
categories:
  - Journal Club
tags:
  - cancer
  - driver mutation
  - algorithm
  - review
---


## 简介

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-31-jcb-nm-cancer-driver/cover.png'>
<br/>
“Comparison of algorithms for the detection of cancer drivers at subgene resolution”
</div>

这是一篇肿瘤生物学相关的文章，主要内容是比较了目前主要的肿瘤Driver事件识别算法，2017年发表于Nature Method。

要点：

- 没有决定哪一种算法最好，而是重点讨论了不同算法之间的差异，供用户参考选择
- 介绍了如何整合其他数据进行突变数据的深度解读
- 讨论了突变簇（有些基因可能更容易同时发生变异）对肿瘤生物学的一些新启示：更加微妙和连续
- 目前识别的人类蛋白质结构大约6100种，通过一些算法（如相似性，同源建模），可以识别的蛋白质结构可以扩展到13000种

目的：

- 读这篇文章的时候并不是想关注具体的算法设计，而是想知道现在有哪些driver事件、检测算法，以及各自的局限和优势。

## 学到的词汇

基础英语

- in favor of 赞成，以取代
- nuanced 有细微差别，微妙
- rationale 基本原理
- latent 潜在的，休眠的
- dubbed 配音; 给…起绰号( dub的过去式和过去分词 ); 把…称为; 复制;


专业英语

- cancer-driver
- average background mutation rate
- subgene-resolution algorithms
- driver and passenger genes （一种获得选择优势，一种产生特定类型的肿瘤）
- nonrandom distribution of mutations within proteins （热点突变、特定结构域）
- heterogeneous disease
- driver–passenger paradigm （一种疾病异质性假说，认为那些高频的变异是driver, 低频的一些变异是passenger-没那么重要）
- individual positions in the protein up to whole genes or pathways
- subgene level (同一基因的不同突变导致不同的表型)
- strengths and weaknesses based on their results
- different assumptions and technical choices of each method influence their results
- primary sequence （一级结构）
- 3D protein structures
- defined protein regions （如结构域、磷酸化位点、相互作用区）
- post-translational modification sites
- familial melanoma 家族性黑色素瘤
- variants of unknown significance (VUS)
- a continuum of cancer-promoting mutations
- mini-drivers: 参考文献-The mini-driver model of polygenic cancer evolution, 一组mini-drivers可以构成一个driver事件

## 主要知识点

- subgene driver-detection algorithms的主要目标：在肿瘤基因组中识别不是随机发生的那些突变簇
- 识别算法的分类（根据是否看高级结构、是否需要定义的一些区间分为四类）：
	1. **Type I** de novo linear clusters
	2. **Type II** de novo three-dimensional clusters (应用于3D结构已知的或者结构可以被很可信的预测的)
	3. **Type III** linear externally defined regions （应用于蛋白质功能区已知，似乎这一种目前应用最广泛）
	4. **Type IV** three-dimensional externally defined regions （目前只有e-Driver3D和CLUMPS的一个模块），这一类型将最大程度的利用已有的知识
- rely on whole-gene analysis (OncodriveFM and MutSigCV）, 与sub-gene概念相对
- **Type I:** Hotspot, NMC, Oncodrive，CLUST，MutSig-CL and iSIMPRe
- **Type II:** iPAC, GraphPAC, SpacePAC and CLUMPS
- **Type III:** e-Driver, ActiveDriver and LowMACA
- **Type IV:** e-Driver3D
- Structure-based methods have high precision but low recall
- Subgene algorithms are more likely to detect oncogenes
- Subgene methods identify new roles for known cancer genes
- 通过生殖系突变起作用的基因（CDK4，家族性黑素瘤）
- 体细胞突变会和生殖系变异有关联 （R24L，黑素瘤）
- 作者的结果支持 “Oncogene会更容易发生突变，Tumor suppressor (TSG)更容易发生丧失功能的突变”（有一篇文献对这个观点提出质疑：Comprehensive assessment of cancer missense mutation clustering in protein structures. Proc. Natl. Acad. Sci. USA. 2015）
- EGFR突变的位置可以影响EGFR的表达量和磷酸化水平
- 研究重要driver基因不同突变起到的作用是一个重要的研究方向
- Identification of significantly mutated regions across cancer types highlights a rich landscape of functional molecular alterations （一篇扩展阅读，非编码区driver识别 2016-NG）
- [ELIXIR data warehouse](http://elixir.bsc.es)

## 总结

本篇文章主要介绍了可以用于识别肿瘤driver事件的算法（主要分为四类），并且介绍了各类算法之间的一些差异和各自的优势和局限性

Type I 适用范围最广，只依赖于一维序列，统计模型等，Type IV需要的先验知识最多（如高级结构域、各类保守区、功能域、蛋白质相互作用区域等等），可以应用的基因数量有限（也反应出了解析蛋白质结构功能的重要性）。

对于肿瘤driver事件检测我觉得应该是一个系统工程，不能只靠某一维度或者是单一类型的算法（说不定肿瘤也会进化（非分子演化），不同时期，不同人群出现新的基因异常，情况就更复杂了）。

看完这篇文章之后，我对于肿瘤生物学又有了些不同的认识：

首先，使细胞获得选择性优势的基因是有限的，这部分基因在不同肿瘤中突变频率都是比较高的。通过大规模测序，发现那些高重现事件相对容易，如基因突变、融合基因（当然，我觉得不能只看突变频率，当达到一定量样本时，它们可能就是某一个亚型）。

然后，基因突变一定是要和其他数据相结合，如融合基因、CNV、染色体重排、基因表达量、基因功能、主要结构域、受哪些基因调控、调控哪些基因等，如果是单单看基因突变在人群中的频率的处理过于简单化。

最后，肿瘤的发生往往伴随的是一个基因表达网络的变化，同时，一系列携带有不同分子标志物的细胞通过协同作用巩固“利益共同体”（某些细胞可以负责产生土壤-肿瘤微环境，来保护肿瘤干细胞进行疯狂增殖以及产生耐药性）。

## 主图一览
<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-31-jcb-nm-cancer-driver/figure1.png'>
<br/>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-31-jcb-nm-cancer-driver/figure2.png'>
<br/>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-31-jcb-nm-cancer-driver/figure3.png'>
<br/>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-31-jcb-nm-cancer-driver/figure4.png'>
</div>

## 附录

论文原文：https://www.nature.com/nmeth/journal/v14/n8/full/nmeth.4364.html
