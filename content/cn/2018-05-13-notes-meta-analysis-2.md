---
title: Meta分析读书笔记 （二）
author: Jianfeng Li
date: '2018-05-13'
slug: note-meta-analysis-2
categories: bioinformatics 
tags: 
  - meta
---

## CRAN Task View: Meta-Analysis

### 简介

#### CRAN task views
CRAN task [Views](https://cran.r-project.org/web/views/) 是一个由R语言社区成员提供的按功能分类的R包合集，如贝叶斯、时间序列、生存等。如果你想快速安装某个类型的R包合集可以用下面的命令（ctv包为必须）：

```r
# To automatically install these views, the ctv package needs to be installed, e.g., via
install.packages("ctv")
library("ctv")
# and then the views can be installed via install.views or update.views (which first assesses which of the packages are already installed and up-to-date), e.g.,
install.views("Econometrics")
# or
update.views("Econometrics")
```
#### CRAN Task View: Meta-Analysis

其中[CRAN Task View: Meta-Analysis](https://CRAN.R-project.org/view=MetaAnalysis
) 则主要是介绍了一些用于Meta分析的R包（99个）。主要包括以下主题：

- 单因素Meta分析
- 多因素Meta分析
- 诊断性试验Meta分析
- Meta回归
- 单个病例数据
- 网络Meta分析
- 遗传学
- 接口
- 模拟
- 其他

其中单因素Meta分析又包括：

数据准备、匹配模型、可视化、异质性分析、模型评价、小样本偏倚估计、无偏倚研究、其他研究设计、显著值Meta分析

### 单因素Meta分析

### 附录

- aggregation
- altmeta
- bamdit
- bayesmeta
- bmeta
- bspmma
- CAMAN
- CIAAWconsensus
- clubSandwich
- compute.es
- ConfoundedMeta
- CopulaREMADA
- CPBayes
- CRTSize
- diagmeta
- dosresmeta
- ecoreg
- effsize
- epiR
- esc
- etma
- exactmeta
- extfunnel
- forestmodel
- forestplot
- gap
- gemtc
- getmstatistic
- gmeta
- hetmeta
- ipdmeta
- joineRmeta
- joint.Cox
- MAc
- MAd
- mada
- MAVIS
- MendelianRandomization
- meta (core)
- meta4diag
- MetaAnalyser
- MetABEL
- metaBMA
- metacart
- metacor
- metafor (core)
- metaforest
- metafuse
- metagear
- metagen
- metagen
- MetaIntegrator
- metaLik
- metaMA
- metamisc
- metansue
- metap
- MetaPath
- MetaPCA
- metaplotr
- metaplus
- MetaQC
- metaRNASeq
- metaSEM
- metasens
- MetaSKAT
- metatest
- Metatron
- metavcov
- metaviz
- mmeta
- MultiMeta
- mvmeta
- mvtmeta
- netmeta
- nmaINLA
- nmathresh
- pcnetmeta
- pimeta
- psychmeta
- psychometric
- PubBias
- RandMeta
- ratesci
- RBesT
- RcmdrPlugin.EZR
- RcmdrPlugin.RMTCJags
- revtools
- rma.exact
- rmeta
- robumeta
- SAMURAI
- SCMA
- selectMeta
- seqMeta
- surrosurv
- TFisher
- weightr
- xmeta

