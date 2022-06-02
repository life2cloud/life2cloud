---
title: 肿瘤驱动基因和显著突变基因识别的方法学总结
author: Jianfeng Li
date: '2018-01-07'
slug: jcb-review-smg
categories: 
  - Journal Club
tags: 
  - cancer
  - review
  - bioinformatics
---

## 文献标题

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-06-JCB-review-SMG/fig1.png'>
<br/>
<b>Advances in computational approaches for prioritizing 
driver mutations and significantly mutated genes
in cancer genomes</b>
</div>

## PMID

26307061

## 发表日期

2016-7-17

## 关键词

- review
- driver mutations
- methods

## 概括

- 大量的体细胞突变数据被各国家、国际肿瘤项目产生，如何识别其中的驱动基因突变和显著突变基因（SMGs）仍然是一个很大的挑战
- 这篇文章对2016年以前通过利用全基因组、全外显子组、全转录组数据进行癌症驱动基因和SMGs识别方法进行了一个全面的汇总和总结
- 通过整合功能基因组学和全基因组测序数据研究非编码区基因突变对于精准医疗有非常重要的意义

## 好词好句

### 单词

- pinpointing driver mutations and cancer genes
- national and international cancer genome projects
- monumental challenge （持久战）
- tissue-specific gene regulatory mechanisms
- aforementioned 上述的
- multidomains of data
- decipher 解释
- pathway-related or protein–protein interaction (PPI)-based databases 
- functional roles of disease-causing variants
- experimental and literature-derived （基于实验或者文献的）
- Random Forest classifier
- Hidden Markov model-based
- supporting vector machine (SVM)-based tool
- nuclear magnetic resonance and X-ray 核磁共振和X射线
- Protein Data Bank (PDB)
- posttranslational modification (PTM) 翻译后修饰
- phosphorylation sites, protein pockets and protein–ligand binding sites
- high anticancer drug resistance risk
- feedback or crosstalk mechanisms within cellular networks
- Bayes inference statistical framework
- druggable mutations
- hub genes (在基因网络中处于高级别的节点)
- network topology
- elucidate 阐明
- noninvasive非侵害性的

### 句子

- Cancer is often driven by the accumulation of genetic alterations, including single nucleotide variants, small insertions or deletions, gene fusions, copy-number variations, and large chromosomal rearrangements.
- Studies of genome sequences have revealed that proteincoding genes account for <2% of the human genome.
- These data not only allow for, but also call for, the development of methods and tools that can efficiently detect cancer-related mutations and genes.
- In response to the large volume of mutations being generated from massively parallel sequencing projects, it is urgently needed to find highly efficient ways to prioritize driver mutations that can be further selected for experimental validation and clinical applications.
- Building a gold-standard positive data set (experimentally validated
functional mutations) is always a difficult task for machine
learning-based tool development.
- They found that no algorithm was able to accurately predict SNVs that should be
taken forward for further experimental or clinical testing, while combination of different tools could modestly improve accuracy and significantly reduce false-negative predictions.
- They observed the expected patterns that protein domain mutations (e.g. both known and new cancer hotspot mutations in kinase domains) are recurrently mutated in both oncogenes and tumor suppressor genes.
- Cells consist of various molecular structures that form complex, plastic and dynamic networks
- Thus, developing an integrative framework by incorporating somatic mutations, structural variations, gene expression and methylation into the improved knowledge of the human interactome would provide a more comprehensive catalog of significantly mutated networks or pathways in cancer.
- Combining two or more methods by their complementary biological hypotheses may
improve the prediction accuracy of each individual tool.
- The genomics landscape of individual tumors enables systematic investigation of antitumor immunotherapeutic responses driven by somatic mutations.

## 笔记

### 有用的数据库

本文作者总结了一系列与SMGs识别相关的数据资源：

- 体细胞突变数据 （Somatic mutation data）
- 通路注释 (Pathway annotations)
- 蛋白相互作用网路数据库 (PPIs)

详细表格见Figures&Tables


### 识别肿瘤驱动基因的方法学分类

本文作者将用于识别肿瘤驱动基因和SMGs的算法和工具分为了以下五类：

- Mutation frequency based
- Functional impact based
- Structural genomics based
- Network or pathway based
- Data integration based

另外，从原始测序数据得到基因突变结果的分析方法到目前为止已经有很多，如GATk、Varscan2等，但是要同时保证高精确度和高敏感度仍然非常困难，作者认为整合多个算法和工具是非常重要的，有助于弥补各类算法各自的缺陷。

我认为不只是不同算法，而应该再包括整合不同类型的测序数据（如捕获测序、转录组测序，甚至CHIP-seq都可以被用来检测突变），每一种测序方法也是会有各自的局限性的，要想更好的检测基因突变，适度的使用多种测序方法并结合利用多种突变检测算法将是未来的一个重要方向。

#### Mutation frequency based

这种类型的算法大多基因突变频率：

- MuSiC 是一个突变分析Pipeline，并整合了测序数据和临床数据，有研究组用这个工具分析了卵巢癌找到了12个SMGs
- ContrastRank 则是重点比较了肿瘤组织和正常组织的基因突变率。
- OncodriveCLUST 重点分析获得功能（GoF）的基因突变，它使用了在编码区的丧失功能的基因突变作为背景
- MutSigCV 使用了基因表达数据和replication timing information

#### Functional impact based

这类算法大多与基因功能相关，预测异常对基因及其蛋白质功能的影响。

- Sorting Intolerant from Tolerant (SIFT) 基于蛋白质序列的保守程度
- Polymorphism Phenotyping v2 (PolyPhen-2) 整合了8种基于序列的和3种基于结构的特性
- MutationAssessor 使用了熵理论去定义进化保守模式（多物种），只能用于错义点突变（limited to nonsynonymous SNVs）
- OncodriveFM 使用SIFT、PolyPhen-2和MutationAssessor去识别低频的SMGs
- MutationTaster 可以用来评估突变对疾病的影响（使用进化保守性、丧失功能突变、蛋白质功能改变），不能评估跨越外显子和内含子的INDEL（>12碱基对）
- CHASM使用49个预测性特征训练随机森林数模型，用来预测错误突变的功能影响
- FATHMM基于Hidden Markov model（HMM）从passenger突变中识别驱动基因突变（整合同源序列和保守结构域）
- CanDrA 基于supporting vector machine (SVM)算法，整合了由10种不同功能预测算法产生的95 个结构和进化特征


#### Structural genomics based

基于结构的分析算法大多基于SNV，比较少的考虑到其他类型的变异（如融合基因），该类方法的限制在于不是所有的蛋白质都有其明确的结构域信息。

- MESA，突变富集分析（mutation set enrichment analysis）使用了两种模型——MSEA-domain 和MSEA-clust。 MSEA-domain是基于蛋白编码区的热点突变谱，MSEA-clust则是去基因组上找潜在的突变热点区域
- ActiveDriver 认为基因突变更容易改变磷酸化位点，从8种肿瘤类型中的800个肿瘤样本中识别出了ASF1, FLBN, GRM1等SMGs （Clinical Proteomic Tumor Analysis Consortium产生了大量磷酸化相关的数据）
- SGDriver 利用蛋白质结构信息（蛋白质配体结合位点）筛选潜在耐药突变。
- CanBind 利用核酸、小分子、离子和肽结合位点突变筛选SMGs
- Identification Protein Amino acid Clustering（iPAC）在三维结构上寻找非随机突变（识别出了已知的和新的SMGs）
- eDriver 比较体细胞突变在不同结构域的分布

#### Network or pathway based

基于网络和通路分析的算法可以很好的对肿瘤中突变产生的突变效应有一个很好的评估。

不过，由于目前技术的限制，仍然只能覆盖潜在PPI中的20-30%，而且其中很多分析出来的网络和通路与样本有密切关系（组织类型、细胞组成、生理状态）。

- PARADIGM 整合了CNV和基因表达数据分析在肿瘤中一致的通路。
- PARADIGM-SHIFT是PARADIGM的扩展，可以预测突变对下游基因的影响（置信传播算法，belief-propagation algorithm），包括了获得功能和丧失功能的突变
- TieDIE 使用网络扩散方法预测基因突变对基因表达的影响，还可以识别出与体细胞突变引起的表达谱改变的通路
- DriverNet 通过对基因突变对基因表达网络的影响进行建模预测驱动基因突变，它的一个好处是可以识别罕见的驱动基因突变
- VarWalker 它使用有重新开始的随机走动算法整合了大尺度癌症基因组数据到PPI网络中
- Network-based stratification (NBS) 基于网络算法的用于识别单个肿瘤数据中的亚组
- DawnRank 使用了PageRank算法？
- HotNet 基于基因组交互网络，使用网络扩散方法检测显著突变的通路
- HotNet2 使用孤立的热扩散过程来检测子网络（克服已有单个基因、通路、网络方法的限制），而且可以用来识别那些罕见突变构成的子网络

#### Data integration based

整合体细胞突变、结构变异、基因表达、甲基化谱来构建网络分析方法是一个重要的研究方向。

人的15%基因组都有CNV变化，至关重要。

- Diver Oncogene and Tumor Suppressor (DOTS)-Finder 整合三个信息：突变位置、功能影响、突变频率
- SVMerge 整合多种已有算法用来检测结构变异和断点
- CONEXIC 通过整合CNV和基因表达数据识别驱动基因突变
- Helios 通过整合基因组数据和RNA干扰数据在大片段重复扩展区域识别SMGs （RSF-1-mediated
tumorigenesis and metastasis in vivo.）
- OncoIMPACT 基于表型影响，预测病人特异的驱动基因突变 

### 遇到的挑战

- 如果在取样时不纯，有可能会导致大量的肿瘤异常信号被掩盖
- 测序技术的限制，不同的测序技术有各自的优势和长处，但是往往不能100%覆盖所有异常，所以通过整合各种类型的技术和手段对同一特征进行分析是非常重要的

### 突变检测的准确度

- 不同的突变检测算法检出率在0.559-0.994之间
- 精确度在0.101-0.997

### 同义突变对肿瘤的影响

本文作者提到有研究表明靠近剪接位点的同义突变(synonymous)可能会使剪接位点失活，从而使基因丧失功能（TP53）。

### Figures&Tables

#### Figure 1

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-06-JCB-review-SMG/fig2.png'>
<br/>
<b>Fig 1</b>
</div>
<br/>

#### Table 1 Data resources

Data resources for development and evaluation of computational tools for prioritizing driver mutations and SMGs in cancer


##### Somatic mutation data

Name | Web site 
---|---
COSMIC | http://cancer.sanger.ac.uk/cosmic
TCGA | http://cancergenome.nih.gov
ICGC|  https://icgc.org
cBioPortal | http://www.cbioportal.org
Cancer3D | http://www.cancer3d.org
dSysMap | http://dsysmap.irbbarcelona.org
ENCODE | https://www.encodeproject.org
NIH Epigenome Roadmap | http://www.roadmapepigenomics.org
FANTOM5 | http://fantom.gsc.riken.jp/5/
GTEx | http://www.gtexportal.org/

##### Pathway annotations

Name | Web site 
---|---
WikiPathways | http://www.wikipathways.org/
KEGG | http://www.genome.jp/kegg/
Reactome | http://www.reactome.org
Pathway Common | http://www.pathwaycommons.org/
PID | http://pid.nci.nih.gov

##### PPIs

Name | Web site 
---|---
BioGRID | http://thebiogrid.org
HPRD | http://www.hprd.org
MINT | http://mint.bio.uniroma2.it/mint/
IntAct | http://www.ebi.ac.uk/intact/
STRING | http://string-db.org
PINA | http://cbg.garvan.unsw.edu.au/pina/
PhosphoSitePlus | http://www.phosphosite.org/
Phospho.ELM | http://phospho.elm.eu.org
PTMcode | http://ptmcode.embl.de
KinomeNetworkX | http:// bioinfo.mc.vanderbilt.edu/kinomenetworkX/
Interactome3D | http://interactome3d.irbbarcelona.org
3did | http://3did.irbbarcelona.org
Instruct | http://instruct.yulab.org

#### Table 2 Computational approaches

Summary of computational approaches and tools for identifying driver mutations and SMGs in cancer genomes

##### Mutation frequency based

Name |  Brief description |Inventor institute | Year
---|---|---|---
MuSiC | A pipeline for determining the mutational significance in cancer. | Washington University | 2012
MutSigCV | An integrative approach that corrects for variants using patient-specific mutation frequency and spectrum, and gene-specific background mutation model derived from gene expression and replication timing information. | The Broad Institute | 2013
OncodriveCLUST | Identifying genes with a significant bias toward mutation clustering in specific protein regions using silent mutations as a background mutation model. | Universitat Pompeu Fabra,Spain | 2013
ContrastRank | A method based on estimating the putative defective rate of each gene in tumor against normal and samples from the 1000 Genomes Project data.| University of Alabama at Birmingham | 2014

##### Functional impact based

Name |  Brief description |Inventor institute | Year
---|---|---|---
SIFT | A popular tool for predicting the biological effect of missense variations by using protein sequence homology. | J. Craig Venter Institute | 2009/2012 
PolyPhen-2 | A popular tool using eight sequence-based and three structure-based predictive features to build naı¨ve Bayes classifiers for predicting the functional impacts of protein sequence variants. | Harvard Medical School | 2010 
MutationTaster | A web-based tool comprising evolutionary conservation and splice-site change information for predicting the functional impacts of DNA sequencing alterations. It limits on alterations spanning an intron-exon border or indels at most 12 base pairs. | Charite-Universitatsmedizin Berlin, Germany | 2010 
MutationAssessor | Predicting functional impact scores based on evolutionary conservation patterns. |  Memorial Sloan-Kettering Cancer Center | 2011
Condel | A consensus deleteriousness score for assessing the functional impact of missense mutations. | Universitat Pompeu Fabra, Spain 2011
CHASM and SNVbox | Python and Cþþ programs for prioritizing cancer- related mutations using their tumorigenic impact. | Johns Hopkins University | 2011
OncodriveFM | An approach based on functional impact bias using three well-known methods. | Universitat Pompeu Fabra, Spain | 2012
PROVEAN |  A tool for predicting the functional effects of SNV and in-frame insertions and deletions. | J. Craig Venter Institute | 2012
CanDrA | A machine learning-based tool based on a set of 95 structural and evolutionary features. | The University of Texas MD Anderson Cancer Center | 2013 
FATHMM | A Hidden Markov model-based tool for functional analysis of driver mutations. | University of Bristol, UK | 2013
CRAVAT | A web-based toolkit for prioritizing missense mutations related to tumorigenesis. | Johns Hopkins University | 2013

##### Structural genomics based

Name |  Brief description |Inventor institute | Year
---|---|---|---
iPAC | An algorithmusing protein 3D structure information for predicting SMGs.| Yale University | 2013
ActiveDriver An approach for predicting SMGs harboring driver mutations significantly altering protein phosphorylation sites. University of Toronto, Canada | 2013
CanBind | A computational pipeline for predicting SMGs using protein–ligand binding site information. | Princeton University | 2014
MSEA | MSEA for predicting SMGs based on mutation hotspot patterns on protein domains or any genomic regions. | Vanderbilt University | 2014
eDriver | A method for predicting SMGs based on the mutation bias between protein domain or intrinsically disordered regions and other regions. | Sanford-Burnham Medical Research Institute | 2014
Protein-Pocket | A method for prioritizing SMGs harboring enriched mutations in its protein pocket regions.| Vanderbilt University | 2014
SGDriver | A method for prioritizing SMGs and druggable mutations in protein–ligand binding sites using a Bayes inference statistical framework. | Vanderbilt University | 2015
PARADIGM | A novel method for detecting consistent pathways in cancers by incorporating patientspecific genetic data into carefully curated NCI pathways. | University of California, Santa Cruz | 2010 
PARADIGM-SHIFT | A method for prioritizing downstream pathways altered by a mutation in cancer using a belief-propagation algorithm. | University of California, Santa Cruz | 2012
Personalized Pathway Enrichment | Map A personalized pathway enrichment method for identifying putative cancer genes and pathways from each individual genome.  | Vanderbilt University | 2012
DriverNet | A computational framework for identifying driver mutations by estimating their effect on mRNA expression networks. | British Columbia Cancer Agency, Canada | 2012
TieDIE | A network diffusion approach for identifying cancer mutated subnetworks. |  University of California, Santa Cruz | 2013
NBS | A somatic mutation network-based approach for stratifying tumor mutations.|  University of California, San Diego | 2013
DawnRank | A tool for prioritizing SMGs in a single patient based on the PageRank algorithm. | University of Illinois at Urbana-Champaign | 2014
VarWalker | A novel personalized mutation network analysis approach for prioritizing SMGs. | Vanderbilt University | 2014
HotNet2 | A new algorithm uses an insulated heat diffusing process to overcome the limitations of existing single-gene, pathway and network approaches for detecting mutated subnetworks in cancer. | Brown University | 2015

##### Data integration based

Name |  Brief description |Inventor institute | Year
---|---|---|---
CONEXIC | A computational framework that integrates copy number variants and gene expression changes for prioritizing SMGs. | Columbia University | 2010
CAERUS | An integrative approach for predicting SMGs using protein structural information, protein networks, gene expression and mutation data. | University of British Columbia, Canada | 2011 
MAXDRIVER | An integrated approach for predicting SMGs using the data from copy number variant regions of cancer genomes. | Chinese Academy of Sciences, China | 2013 
Helios | An algorithmpredicts SMGs by integrating genomic and functional RNAi screening data from primary tumors. | Columbia University | 2014 
DOTS-Finder | A functional and frequentist-based tool for predicting SMGs in cancer. | Istituto Italiano di Technologia, Italy | 2014 
OncodriverROLE  | A machine learning-based approach classifies SMGs into LoF and GoF. | Universitat Pompeu Fabra, Spain | 2014 
OncoIMPACT | An integrative framework for prioritizing SMGs based on their phenotypic impacts. | Genome Institute of Singapore, Singapore | 2015
