---
title: 整合基因组和转录组分析等位基因表达(正常人群)
author: Jianfeng Li
date: '2018-02-03'
slug: jcb-allelic-expression-analysis
categories: 
  - Journal Club
tags: 
  - RNA-seq
  - bioinformatics
---

## 文献标题

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig1.png'>
<br/>
<b>Tools and best practices for data processing in allelic expression analysis
in cancer genomes</b>
</div>

## PMID

26381377

## 发表日期

2015-9-17

## 关键词

- integrating genome and transcriptome data
- allelic expression analysis
- methods

## 概括

博德研究所在GATK中开发的一个新的工具，用于分析RNA-seq的等位基因表达，使用了1000 Genome Project 和Geuvadis project的类原始淋巴细胞系(lymphoblastoid cell lines)RNA-seq数据。

本文的作者重点评估了等位基因表达数据分析的质量控制及其对最终结果的影响，并且提出了一系列举措进行校正，同时总结了一系列用于等位基因表达数据分析的软件和算法。

他们提出影响最终分析结果的因素主要来源于技术错误（如低质量的或被重复计数的RNA-seq reads、基因型错误、比对错误、样本准备和测序导致的测序错误、总测序深度的变化）。

## 好词好句

### 单词

- biological phenomena 生物学现象
- small insertions or deletions (indels)
- cis-regulatory variation
- nonsense-mediated decay
- heterozygous sites
- mimic 模仿，模拟
- heterozygous single-nucleotide polymorphisms (het-SNPs)
- protein-truncating variant
- reference/non-reference read counts
- no alien reads get erroneously assigned to a locus
- uniquely mapping reads should be used
- caveat 预告、警告
- allelic mapping bias
- simulated data 仿真数据
- loci with homology 同源基因位点
- particularly problematic 特别有问题
- flanking variant (e.g. other unknown resource)
- allelic imbalance
- imprinting?
- more subtle bias
- expression quantitative trait loci (eQTL)
- genotyping error
- negligible 微不足道的
- arrays and modern sequencing data
- imputed data
- binomial testing 二项检验
- overdispersed 分散的

### 句子

- We analyze the properties of allelic expression read count data and technical sources of error, such as low-quality or double-counted RNA-seq reads, genotyping errors, allelic mapping bias, and technical covariates due to sample preparation and sequencing, and variation in total read depth.
- Standard RNAsequencing (RNA-seq) data capture Allelic expression (AE) only when higher expression of one parental allele is shared between individual cells, as opposed to random monoallelic expression of single cells that typically cancels out when a pool of polyclonal cells is analyzed.
- RNA-seq studies with shorter or single-end RNA-seq reads are more susceptible to these problems
- Mapping bias varies depending on the specific alignment software used
- In genotype data that has passed normal quality control (QC), including Hardy-Weinberg equilibrium test, genotype error will lead to rare cases of monoallelic expression per site, not shared across many individuals.
- RNA-seq has become a mature and highly reproducible technique, but it is not immune to technical covariates such as the laboratory which experiments were performed in, aspects of library construction and complexity and sequencing metrics.
- When appropriate measures are taken, AE analysis is an extremely robust approach that suffers less from technical factors than gene expression studies.

## 笔记

### 什么是单等位基因表达？

有时细胞只采用了常染色体基因的一个拷贝（激活两个等位基因中的一个），这种现象被称为单等位基因表达， 这种随机现象在成熟细胞中更为常见。

### 什么是无义突变介导的降解（nonsense-mediated decay）？

也就是当基因组发生无义突变后，其表达的mRNA更容易被降解，从而导致RNA-seq中测序得到的reads中未发生无义突变的reads数增多。

### 什么等位基因表达（AE）分析？

在杂合位点定量分析二倍体中各单倍体的表达差异，比如顺式元件的变异（对调控基因表达有重要作用），无义突变介导的mRNA降解以及印记 (imprinting)。

### 提供的工具？

GATK3.4中新增加的 `ASEReadCounter`

### 质控的主要方面？

- 去重
- 测序质量
- 测序深度
- 比对软件会影响比对引入的错误 (去掉一些可以同时比对到多个地方的reads)
- Hardy-Weinberg equilibrium test （基因型错误主要会发生在单个个体上，而不会在整体中产生），去除假的杂合位点，不过基因型错误很难和那些真实就发生了严重的单等位基因表达的情况区分出来
- 样本质量也很重要（实际情况下，很多都会出现样本弄错的情况），使用DNA-RNA异质性的一致性可以进行部分评估
- 不同实验室、不同测序仪器等等和测序实验相关的部分都可能引入错误

### Pairwise distance

The distance between two samples was calculated as follows:

Pairwise distance = Total number of sites with significant AE in only one sample/Total number of shared sites

### Units of AE

For a single variant:

Reference ratio = Reference reads/Total reads

Allelic expression (effect size) = |0.5 – Reference ratio|

### Figures&Tables

#### Figure 1

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig2.png'>
<br/>
</div>

#### Figure 2

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig3.png'>
<br/>
</div>

#### Figure 3

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig4.png'>
<br/>
</div>

#### Figure 4

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig5.png'>
<br/>
</div>

#### Figure 5

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig6.png'>
<br/>
</div>

#### Figure 6

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig7.png'>
<br/>
</div>

#### Figure 7

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-07-JCB-allelic-expression-analysis/fig8.png'>
<br/>
</div>
