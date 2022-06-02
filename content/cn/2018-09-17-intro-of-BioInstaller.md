---
title: BioInstaller：一次Shiny应用开发的尝试
author: Jianfeng Li
date: '2018-09-17'
slug: intro-of-bioinstaller
categories: 
  - tutorial 
tags: 
  - BioInstaller
  - bioinformatics
---

## 简介

一年多以前，我开始提交第一个[BioInstaller](https://github.com/JhuangLab/BioInstaller)的Commit，现在已经迭代到了`v0.3.6`。当时启动这个项目纯粹只是想有一个自己的工具来管理和下载一些生物信息资源，比如参考基因组、基因突变检测和注释的软件以及相关的注释数据库等。后来，本着学习[Shiny](http://shiny.rstudio.com/)的目的，就给BioInstaller开发了Shiny图形界面以及一些相关的基础设施（队列管理、任务提交、插件系统、变量管理等）。

![](https://raw.githubusercontent.com/JhuangLab/BioInstaller/develop/man/figures/design_of_bioInstaller.jpg)

希望在以下几个方面对大家会有所帮助：

- 生物信息资源的部署，整合了conda, spack以及自定义的部署脚本或者函数，而且提供了这些应用的Shiny接口
- 生物信息资源的收集，基于最简单的TOML格式文件，收集整理了数百种生物信息学工具、脚本还有数据库。
- 生物信息资源的分享，建立了一个公共的[GitHub仓库](https://github.com/JhuangLab/BioInstaller/issues/11)；通过TOML格式的文件，用户可以在BioInstaller建立的Shiny平台上分享他们的数据资源以及数据分析插件。
- 数据分析Pipeline的构建，提供了丰富的TOML格式的数据文件，你在构建Pipeline时可以直接在线获取或者拷贝这些文件，整合入你的Pipeline中，比如[ANNOVAR](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/db/db_annovar.toml)的突变注释数据库的相关信息。
- Shiny应用的构建：你可以直接使用BioInstaller的Shiny而不用再去开发一些基础功能，比如文件上传与管理、插件系统、任务队列和提交等等。你只需要为你的核心功能构建一个TOML格式的数据分析插件即可（核心功能可以由一个R函数或者R命令封装）。
- 可重现的数据分析：我们提供一整套用于可重现的数据分析方式，输出文件和日志可追溯、提供整合Shiny，[Opencpu](https://www.opencpu.org/)和[Rstudio](https://www.rstudio.com/)服务的Docker容器。

这个R包仍然在不断完善和迭代，希望可以给大家提供一个免费、开源的的Shiny分析环境。

## 未来的开发方向

因为我一个人的时间不一定可以持续并且快速的迭代开发，我列了一些主要需要被提升的功能，如果你感兴趣，你也可以贡献你的代码：

- 任务管理以及队列系统的进一步完善和提高（参考Galaxy）
- 更多的数据分析和可视化插件（比如WES/RNA-seq/Chip-seq/ATAC-seq等）
- Shiny插件管理界面（现在是通过修改YAML格式的文件）
- 基于TOML文件对生物信息资源的进一步收集、分类以及镜像化
- ......

如果你有任何的建议除了去项目主页发起[issue](https://github.com/JhuangLab/BioInstaller/issues/new)之外，可以直接在我的这篇博客进行评论，这些信息会存储在博客论坛的GitHub [issues](https://github.com/Miachol/life2cloud-comments/issues)。

## 英文简介

The increase in bioinformatics resources such as tools/scripts and databases poses a great challenge for users seeking to construct interactive and reproducible biological data analysis applications.

R language, as the most popular programming language for statistics, biological data analysis, and big data, has enabled diverse and free R packages (>14000) for different types of applications. However, due to the lack of high-performance and open-source cloud platforms based on R (e.g., Galaxy for Python users), it is still difficult for R users, especially those without web development skills, to construct interactive and reproducible biological data analysis applications supporting the upload and management of files, long-time computation, task submission, tracking of output files, exception handling, logging, export of plots and tables, and extendible plugin systems.

The collection, management, and share of various bioinformatics tools/scripts and databases are also essential for almost all bioinformatics analysis projects.

Here, we established a new platform to construct interactive and reproducible biological data analysis applications based on R language. This platform contains diverse user interfaces, including the R functions and R Shiny application, REST APIs, and support for collecting, managing, sharing, and utilizing massive bioinformatics tools/scripts and databases.

**Feature**:

  - Easy-to-use
  - User-friendly Shiny application
  - An integrative platform of databases and bioinformatics resources
  - Open source and completely free
  - One-click to download and install bioinformatics resources (via R, Shiny or Opencpu REST APIs)
  - More attention for those software and database resources that have not been
    by other tools
  - Logging
  - System monitor
  - Task submission
  - Long-time computation
  - Parallel tasks

**Field**

  - Quality Control
  - Alignment And Assembly
  - Alternative Splicing
  - ChIP-seq analysis
  - Gene Expression Data Analysis
  - Variant Detection
  - Variant Annotation
  - Virus Related
  - Statistical and Visualization
  - Noncoding RNA Related Database
  - Cancer Genomics Database
  - Regulator Related Database
  - eQTL Related Database
  - Clinical Annotation
  - Drugs Database
  - Proteomic Database
  - Software Dependence Database 
  - [Bioinformatics-Resources](https://github.com/JhuangLab/Bioinformatics-Resources)
  - ......

## Shiny UI overview

```
# install the latest developmental version
# then start the BioInstaller R Shiny application
# the document is still under construction
BioInstaller::web(auto_create = TRUE)
```

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview1.jpg)

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview2.jpg)

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview3.jpg)

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview4.jpg)

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview5.jpg)

## Installation

### CRAN

``` r
#You can install this package directly from CRAN by running (from within R):
install.packages('BioInstaller')
```

### Github

``` bash
# install.packages("devtools")
devtools::install_github("JhuangLab/BioInstaller")
```

## Contributed Resources

  - [GitHub resource](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/github/github.toml)
  - GitHub resource [meta information](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/github/github_meta.toml)
  - [Non GitHub resource](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/nongithub/nongithub.toml)
  - Non Github resource [meta infrmation](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/nongithub/nongithub_meta.toml)
  - [Database](https://github.com/JhuangLab/BioInstaller/tree/master/inst/extdata/config/db)
  - [Web Service](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/web/web_meta.toml)
  - [Docker](https://github.com/JhuangLab/BioInstaller/blob/master/inst/extdata/config/docker/docker.toml)

## Support Summary

**Quality Control:**

  - FastQC, PRINSEQ, SolexaQA, FASTX-Toolkit ...

**Alignment and Assembly:**

  - BWA, STAR, TMAP, Bowtie, Bowtie2, tophat2, hisat2, GMAP-GSNAP,
    ABySS, SSAHA2, Velvet, Edean, Trinity, oases, RUM, MapSplice2,
    NovoAlign ...

**Variant Detection:**

  - GATK, Mutect, VarScan2, FreeBayes, LoFreq, TVC, SomaticSniper,
    Pindel, Delly, BreakDancer, FusionCatcher, Genome STRiP, CNVnator,
    CNVkit, SpeedSeq ...

**Variant Annotation:**

  - ANNOVAR, SnpEff, VEP, oncotator ...

**Utils:**

  - htslib, samtools, bcftools, bedtools, bamtools, vcftools, sratools,
    picard, HTSeq, seqtk, UCSC Utils(blat, liftOver), bamUtil, jvarkit,
    bcl2fastq2, fastq\_tools ...

**Genome:**

  - hisat2\_reffa, ucsc\_reffa, ensemble\_reffa ...

**Others:**

  - sparsehash, SQLite, pigz, lzo, lzop, bzip2, zlib, armadillo, pxz,
    ROOT, curl, xz, pcre, R, gatk\_bundle, ImageJ, igraph ...

**Databases:**

  - ANNOVAR, blast, CSCD, GATK\_Bundle, biosystems, civic, denovo\_db,
    dgidb, diseaseenhancer, drugbank, ecodrug, expression\_atlas,
    funcoup, gtex, hpo, inbiomap, interpro, medreaders, mndr, msdd,
    omim, pancanqtl, proteinatlas, remap2, rsnp3, seecancer,
    srnanalyzer, superdrug2, tumorfusions, varcards ...

## Docker

You can use the BioInstaller in Docker since v0.3.0. Shiny application was supported since v0.3.5.

``` bash
docker pull bioinstaller/bioinstaller
docker run -it -p 80:80 -p 8004:8004 -v /tmp/download:/tmp/download bioinstaller/bioinstaller
```

Service list:

- http://localhost/ocpu/ Opencpu service
- http://localhost/shiny/BioInstaller Shiny service
- http://localhost/rstudio/ Rstudio server (opencpu/opencpu)
