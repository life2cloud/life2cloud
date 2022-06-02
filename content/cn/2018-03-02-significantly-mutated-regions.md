---
title: 基因中不限肿瘤类型的显著突变区域
author: Jianfeng Li
date: '2017-09-07'
slug: jcb-significantly-mutated-regions
categories: 
  - Journal Club
tags: 
  - cancer
  - bioinformatics
---

## 文献标题

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig1.png'>
<br/>
<b>Identification of significantly mutated regions across cancer types highlights a rich landscape of functional molecular alterations</b>
</div>

## PMID

26691984

## 发表日期

2015-12-21

## 关键词

- significantly mutated regions
- across cancer types
- functional molecular alterations

## 概括

本文作者使用了21种肿瘤的4700多个肿瘤样本，以一种叫做基于密度聚类的方法（density-based clustering methods），尝试用空间聚类的方法将部分非编码区和编码区突变进行区间聚类，找到了许多肿瘤类型共有的以及特有的显著突变区间（SMRs），其中包括了许多非编码区和内含子区域的突变信息，并且分析了其与基因表达的关系，找到了一些与基因表达高度相关的SMRs。另外，作者特别强调了PIK3CA的突变，八种肿瘤中有6个SMRs都影响了PIK3CA.5和PIK3CA.6结构域，而PIK3CA.2和PIK3CA.3则是肿瘤类型特异的, 它影响了蛋白的adaptor-binding domain (ABD)和the linker region between the ABD and Ras-binding domain (RBD)。

In contrast, we observed cancer type–specific SMRs (PIK3CA.2 and PIK3CA.3) affecting an α-helical region between the adaptor-binding domain (ABD) and the linker region between the ABD and Ras-binding domain (RBD) of PIK3CA。

## 好词好句

### 单词

- inclusive of 将...包括在内
- density-based clustering methods
- variably sized significantly mutated regions (SMRs)
- a spectrum of 连续的，一连串的
- transcription factor binding sites and untranslated regions
- spatial clustering of alterations in molecular domains and at interfaces
- underscores 强调
- skewed 曲解的
- exon-proximal domains (±1,000 bp)
- reciprocal 相互的，互惠的
- leveraged 杠杆的
- elicit（引出） similar molecular profiles in distinct cancers
- interrogation 询问
- pleiotropy 基因多效性
- pathological variants
- functionally agnostic detection approaches
- elevated basal signaling activity
- replication timing and gene expression

### 句子

- In cancer, driver mutations alter functional elements of diverse nature and size.
- Systematic analyses of genomic regulatory activity in animals have identified substantial tissue and developmental stage specificity, suggesting that mutations in cancer type–specific regulatory features may be significant noncoding drivers of cancer.
- SMRs were associated with noncoding elements, protein structures, molecular
interfaces, and transcriptional and signaling profiles, thereby providing insight into the molecular consequences of accumulating somatic mutations in these regions.
- The identification of SMRs across multiple cancer types permitted a systematic analysis of differential mutation frequencies with subgenic and cancer type resolution.
- We next sought to identify SMRs that might affect the molecular interfaces of protein-protein and DNA-protein interactions, a recognized yet understudied mechanism of cancer driver mutation
- These findings underscore and extend recent associations between altered epigenetic regulation and histone alterations in tumorigenesis.
- We leveraged RNA sequencing (RNA-seq), RPPA and clinical data to ask whether
(i) SMR alterations associate with distinct molecular signatures or survival outcomes, (ii) SMR alterations correlate with similar molecular profiles in distinct cancers, and (iii) SMR alterations in the same gene associate with similar or different molecular signatures.
- These analyses identified previously unappreciated connections between recurrent somatic mutations and molecular signatures, which highlight recurrent GSK3 pathway alterations in endometrial cancer and recurrent mTOR as well as EIF4 and epidermal growth factor (EGF) pathway alterations in glioblastoma
- The identified SMRs also permitted interrogation of mutations in different regions of a given gene with respect to associated molecular signatures.
- This functional diversity underscores both the varied mechanisms of oncogenic misregulation and the advantage of functionally agnostic detection approaches. Notably, several of the most frequently altered SMRs lay within noncoding regions.
- Mutation models that account for cell type–specific expression and chromatin context at refined scales may require sequencing cohorts of matched normal tissue and increased sample sizes.
- Identify the spatial distribution of mutation recurrence in the genome, when combined with additional genomic, biophysical, structural or phenotypic information, often enhances mechanistic insights.

## 笔记

### 如何有效利用非编码区的突变信息

- 全基因组数据，部分外显子数据和转录组数据可以捕获一部分内含子区
- 先验知识（定义的功能区间如ETS结合区、剪接位点、启动子）

### 有哪几个方向去分析肿瘤基因突变

- 按基因
- 按肿瘤类型（多肿瘤整合分析）
- 按通路
- 按突变类型

### 作者用了哪些数据

~3 million previously identified somatic single-nucleotide variants (SNVs) from 4,735 tumors of 21 cancer types

### 什么是外显子临近区（exon-proximal domains）

外显子上下游1000bp, 包括内含子和UTR，本文作者找到了872个SMRs，横跨735个基因组区间

### 5' UTR 和启动子区的突变富集

ERG、FLI1、FEV是转录因子中21种肿瘤中显著突变区域最多的三个基因

### 肿瘤中最常见结构域上的突变

P53、Pkinase_Tyr、RAS

### PIK3CA的突变

six SMRs in PIK3CA across eight cancer types (Fig. 3b), with multiple cancer types displaying SMRs mapping to the helical (PIK3CA.5) and kinase (PIK3CA.6) domains.

In contrast, we observed cancer type–specific SMRs (PIK3CA.2 and PIK3CA.3) affecting an α-helical region between the adaptor-binding domain (ABD) and the linker region between the ABD and Ras-binding domain (RBD) of PIK3CA.

### SMRs与基因表达调控的关联性

Matched RNA-seq data for nine cancers showed that mutations in 30 distinct SMRs associated with ≥10 differentially expressed genes.

### 肿瘤类型与SMRs

NFE2L2 were associated with large, concordant transcriptomic changes in four distinct cancer types

### 同一基因上不同的SMRs对通路的影响

SMR-specific differences in ASNS levels and MAPK and MEK1 phosphorylation among samples with altered TP53 SMRs.

TP53不同的SMRs会对下游通路有潜在的不同影响

### Gini Coefficient 一般指基尼系数

赫希曼根据洛伦茨曲线提出的判断分配平等程度的指标。设实际收入分配曲线和收入分配绝对平等曲线之间的面积为A，实际收入分配曲线右下方的面积为B。并以A除以（A+B）的商表示不平等程度。这个数值被称为基尼系数或称洛伦茨系数。如果A为零，基尼系数为零，表示收入分配完全平等；如果B为零则系数为1，收入分配绝对不平等。收入分配越是趋向平等，洛伦茨曲线的弧度越小，基尼系数也越小，反之，收入分配越是趋向不平等，洛伦茨曲线的弧度越大，那么基尼系数也越大。另外，可以参看帕累托指数(是指对收入分布不均衡的程度的度量）。

### Figures&Tables

#### Figure 1

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig2.png'>
<br/>
</div>

#### Figure 2

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig3.png'>
<br/>
</div>

#### Figure 3

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig4.png'>
<br/>
</div>

#### Table 1

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig5.png'>
<br/>
</div>

#### Figure 5

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig6.png'>
<br/>
</div>

#### Figure 6

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-NG-significantly-mutated-regions/fig7.png'>
<br/>
</div>
