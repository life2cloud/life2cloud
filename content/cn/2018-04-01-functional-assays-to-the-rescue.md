---
title: 'Variant Interpretation: Functional Assays to the Rescue'
date: '2018-04-01'
slug: functional-assays-to-the-rescue
categories: 
  - Journal Club
tags: 
  - cancer
  - bioinformatics
  - functional assay
---

## 文献标题

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-10-JCB-AMJHG-functional-assays-to-the-rescue/fig1.png'>
<br/>
<b>Variant Interpretation: Functional Assays to the Rescue</b>
</div>

## PMID

28886340

## 发表日期

2017-09-07

## 关键词

- variant interpretation
- functional assays

## 概括


## 好词好句

### 单词

- co-segregation studies 共分离分析（家系）
- pathogenicity 致病性
- multiplex assays of variant effect (MAVEs)
- ubiquitous普遍存在的
- was deemed causal 被视为因果关系
- plurality of variants 多数
- Variants of Uncertain Significance (VUSs)
- laudable 值得赞赏的
- post hoc 因果颠倒
- one-at-a-time
- heuristic 启发式的
- massively parallel reporter assays (MPRA)
- self-transcribing active regulatory region sequencing (STARR-seq)
- deep mutational scanning (DMS)
- splicing assays
- lipodystrophy 脂肪代谢障碍
- generalizable 可概括的
- steady-state 稳定状态
- genetic complementation 遗传学互补
- deciphering the regulatory grammar 解密
- noteworthy adaptation 改编
- unification 联合
- error-estimation methods 错误评估方法
- unmanageable 难操作的
- epistatic 上位的
- perturbations 扰动的
- virtuous cycle 良性循环
- puzzle 迷
- aimed at aiding clinical decisions
- unanticipated 意料之外的
- nascent 初期的
- inadvertently 疏忽的
- insurmountable 不能克服的
- attribution 归因
- three-prongedapproach 三者结合的方法
- synergistically 协同作用地
- clinicians and clinical laboratories 临床医生和临床实验室

### 句子

- However, our inability to interpret the clinical consequences of genetic variants discovered by sequencing remains a critical roadblock to the progress of precision medicine.
- A recent evaluation of predictor performance on 21 human disease-associated genes revealed that at sensitive thresholds detecting 90% of pathogenic variation, false predictions are made 30% of the time
- Functional data constitute one of the strongest types of evidence for classifying a variant as pathogenic or benign, so functional assays represent a viable strategy for overcoming the VUS challenge.
- Our proposed heuristic for clinical importance combines an assessment of whether knowledge of pathogenic variants in the functional element is actionable, the likelihood that the effect of a large number of VUSs will be clarified, and the feasibility of applying MAVEs.
- BRCA2 also has 326 variants with conflicting reports of clinical significance. The promoter and distal elements that regulate BRCA2 expression can be interrogated via MPRA, and existing low-throughput functional assays for BRCA2 transcript splicing and protein function could be multiplexed.
- Variants are synthesized, introduced into a model system, and selected for a phenotype of interest.
- The most effective way to prevent erroneous variant interpretations owing to noisy data is through proper experimental design and quantification of the uncertainty associated with each measurement. Inclusion of appropriate positive and negative controls in these assays can also assist in reducing background noise.
- For example, sequencing of trios with Mendelian disease, comparison of tumor and normal tissue, GWASs, eQTL analyses, and various functional genomics efforts have all helped to reveal an astonishing number of these relationships.

## 笔记

### 变异效应的多重分析

在临床应用中，基因变异的临床注释现在还只占已知异常的很少一部分，为了加速基因变异的临床相关注释，需要对基因变异效应进行多维度的功能试验和效应预测（分子和细胞表型），结合深度学习和临床知识建立一个可操作的查询表，来为临床预防、治疗提供参考。

### 表达数量性状位点 （eQTL）

> 百度百科：

> 数量性状基因座：控制数量性状的基因在基因组中的位置称数量性状基因座。常利用DNA分子标记技术对这些区域进行定位，与连续变化的数量性状表型有密切关系。

> 表达数量性状基因座（expression Quantitative Trait Loci,eQTL）是对上述概念的进一步深化，它指的是染色体上一些能特定调控mRNA和蛋白质表达水平的区域，其mRNA/蛋白质的表达水平量与数量性状成比例关系。eQTL可分为顺式作用eQTL和反式作用eQTL，顺式作用eQTL就是某个基因的eQTL定位到该基因所在的基因组区域，表明可能是该基因本身的差别引起的mRNA水平变化；反式作用eQTL是指某个基因的eQTL定位到其他基因组区域，表明其他基因的差别控制该基因mRNA水平的差异。

> 例如，水稻eQTL(表达数量性状基因座)SKC1基因的位点变异是水稻耐盐的主要基础之一，而且证实了关键基因的位点变异可能会在盐胁迫环境下增加产量的稳定性。

### variants of uncertain significance (VUSs)

就是通过分析病人的变异信息和临床特征没有找到明显关联性的基因变异，这些位点虽然没有显著关联性，但是并不代表这些变异位点没有发挥潜在的作用。

### ClinVar 数据库

> ClinVar 是一个公开的数据库，其中收集了与疾病相关的遗传变异。这一数据库由美国国立卫生研究院2013年为了生物技术信息开发而构建，来自美国联盟医疗体系（Partners Healthcare ）的临床遗传学家Heidi Rehm表示，到目前为止，已经从研究人员和其它数据库中获得了包含超过125,000份独特突变的临床注释。
> ClinVar 将基因突变对健康影响的多方面性质都考虑在内了，比如对于一个突变，这个研究组说它是良性，但另外一个研究组又认为它其实性质更加严重。而且 ClinVar 也有自己的分类，“可能致病性（likely pathogenic）”就是一种更清楚的定义和标准化。

### 临床注释为什么需要大量的功能试验研究？

大量的基因变异位点是罕见的（gnomAD数据库中99%的错义突变频率&lt;0.005），很难通过临床观测到的个体覆盖所有潜在的致病或与临床治疗相关的位点，只有2%可以被临床注释。

另外，很多的基因的功能元件还没有得到充分地研究，并不清楚在这些元件上发生异常会有哪些潜在的表型影响。

### Massively parallel reporter assays (MPRA)

用来大批量研究在增强子上的基因变异对其发挥作用的影响的一种方法。

### Self-transcribing active regulatory region sequencing (STARR-seq)
> 来源：https://en.wikipedia.org/wiki/STARR-seq
>
> STARR-seq (also known as self-transcribing active regulatory region sequencing) is a novel method to assay enhancer activity for millions of candidates from arbitrary sources of DNA. Being a highly reproducible technique, STARR-seq identifies the sequences that act as transcriptional enhancers in a direct, quantitative, and genome-wide manner.

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-10-JCB-AMJHG-functional-assays-to-the-rescue/fig4.png'>
<br/>
</div>

### 影响蛋白质发挥作用的因素

- 蛋白质的位置
- 蛋白质的稳定性
- 温度敏感性
- 聚合度
- 更新率

蛋白质复合物更难评估其稳定性

### 如何开展MAVEs

- 应该从绝大多数临床相关的功能元件收集疾病特异的MAVE数据集
- 疾病相关的功能元件应该进行分子和细胞的多维试验和分析
- 建立一个社区（自下而上，如临床一线的医生自发组织，或自上而下，如NIH等开展相关项目）

### Figures&Tables

#### Figure 1

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-10-JCB-AMJHG-functional-assays-to-the-rescue/fig2.png'>
<br/>
</div>

#### Figure 2

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-10-JCB-AMJHG-functional-assays-to-the-rescue/fig3.png'>
<br/>
</div>
