---
title: 生信分析流程构建的几大流派
author: Jianfeng Li
date: '2018-11-16'
slug: pipelines-styles
categories:
  - tutorial
tags:
  - bioinformatics cloud
---

## 导言

构建生信分析流程是生物信息学从业人员必备的技能之一，对该项能力的评估常常是各大公司招录人员的参考项目之一。


在进行[ngsjs](https://github.com/ngsjs/ngsjs)项目时，我做了一张示意图来表示一些高通量测序数据分析项目重现性的要点（**图一**）。

> ngsjs: A set of command line tools, NGS data analysis workflows, and R shiny plugins/R markdown document for exploring next-generation sequencing data.

一个好的生物信息分析流程可以让你事倍功半，有效减负，同时也有利于他人重复你的数据分析结果。

<p align="center">
  <img 
      alt="Best practice of reproducible NGS data analysis projects"
      src="https://raw.githubusercontent.com/Miachol/ftp/master/files/images/ngsjs/reproducible_NGS_data_analysis_projects_best_practice.jpg"
  />
  <b>图一</b> 高通量测序数据分析项目重现性的要点
</p>

其中，使用统一的管道（pipeline）、工作流程（workflow）就是其中最重要的一环。

根据生信信息学数据分析流程（管道、工作流程序）构建的风格和方式，大致有以下几大流派（注1）：

- **脚本语言流**
- **Common Workflow language 语言流**
- **Makefile流**
- **配置文件流**
- **Jupyter notebook和R markdown流**
- ......

**注1：** 围棋比赛中常用“流派”来形容各具特色的棋手/派系，[参见资料](https://zhidao.baidu.com/question/128619435.html)，深度学习派代表[AlphaGo](https://zh.wikipedia.org/wiki/AlphaGo)现在在围棋届已经一骑绝尘。

## 生信分析流程构建的几大流派

### 脚本语言流

脚本语言流的主要是通过简单的脚本语言（如shell，R，Python，Perl）运行各类命令行脚本/程序。常见的几种工作模式：

1. 单个脚本就是一整个流程
2. 多个脚本组成一个流程
3. 封装成可以输入参数的命令行程序
4. 封装成函数/模块/包（包含示例文件、文档和测试）

前两种（1和2）是大多数生物信息学初学者（不具备封装和打包能力）最早开始接触生信分析流程的方式。后两种（3和4）是专业人员开发新工具、新流程的必备技能。

这里使用[htslib.org](http://www.htslib.org/workflow/)所给`WGS/WES Mapping to Variant Calls (v1.0)`作为工作模式`1，2`的示例（已略去注释）：

```bash
# mapping
bwa index <ref.fa>
bwa mem -R '@RG\tID:foo\tSM:bar\tLB:library1' <ref.fa> <read1.fa> <read1.fa> > lane.sam
samtools fixmate -O bam <lane.sam> <lane_fixmate.bam>
samtools sort -O bam -o <lane_sorted.bam> -T </tmp/lane_temp> <lane_fixmate.sam>

# Improvement
java -Xmx2g -jar GenomeAnalysisTK.jar -T RealignerTargetCreator -R <ref.fa> -I <lane.bam> -o <lane.intervals> --known <bundle/b38/Mills1000G.b38.vcf>
java -Xmx4g -jar GenomeAnalysisTK.jar -T IndelRealigner -R <ref.fa> -I <lane.bam> -targetIntervals <lane.intervals> --known <bundle/b38/Mills1000G.b38.vcf> -o <lane_realigned.bam>

java -Xmx4g -jar GenomeAnalysisTK.jar -T BaseRecalibrator -R <ref.fa> -knownSites >bundle/b38/dbsnp_142.b38.vcf> -I <lane.bam> -o <lane_recal.table>
java -Xmx2g -jar GenomeAnalysisTK.jar -T PrintReads -R <ref.fa> -I <lane.bam> --BSQR <lane_recal.table> -o <lane_recal.bam>

java -Xmx2g -jar MarkDuplicates.jar VALIDATION_STRINGENCY=LENIENT INPUT=<lane_1.bam> INPUT=<lane_2.bam> INPUT=<lane_3.bam> OUTPUT=<library.bam>

samtools merge <sample.bam> <library1.bam> <library2.bam> <library3.bam>
samtools index <sample.bam>

java -Xmx2g -jar GenomeAnalysisTK.jar -T RealignerTargetCreator -R <ref.fa> -I <sample.bam> -o <sample.intervals> --known >bundle/b38/Mills1000G.b38.vcf>
java -Xmx4g -jar GenomeAnalysisTK.jar -T IndelRealigner -R <ref.fa> -I <sample.bam> -targetIntervals <sample.intervals> --known >bundle/b38/Mills1000G.b38.vcf> -o <sample_realigned.bam>

samtools index <sample_realigned.bam>

# Variant Calling
bcftools mpileup -Ou -f <ref.fa> <sample1.bam> <sample2.bam> <sample3.bam> | bcftools call -vmO z -o <study.vcf.gz>

bcftools mpileup -Ob -o <study.bcf> -f <ref.fa> <sample1.bam> <sample2.bam> <sample3.bam>
bcftools call -vmO z -o <study.vcf.gz> <study.bcf>

tabix -p vcf <study.vcf.gz>

bcftools stats -F <ref.fa> -s - <study.vcf.gz> > <study.vcf.gz.stats>
mkdir plots
plot-vcfstats -p plots/ <study.vcf.gz.stats>

bcftools filter -O z -o <study_filtered..vcf.gz> -s LOWQUAL -i'%QUAL>10' <study.vcf.gz>
```

工作模式`3`和`4`是开发生物信息工具的标准方式。很多生物信息学分析工具本身就是涉及到各类复杂计算和命令的集成式流程，如：

- [deepvariant](https://github.com/google/deepvariant)：A universal SNP and small-indel variant caller using deep neural networks. *Nat Biotechnol*. 2018 Nov;36(10):983-987. doi: 10.1038/nbt.4235. Epub 2018 Sep 24.
- [DeepSVR](https://github.com/griffithlab/DeepSVR)：A deep learning approach to automate refinement of somatic variant calling from cancer sequencing data. *Nat Genet*. 2018 Nov 5. doi: 10.1038/s41588-018-0257-y.
- [diseasequest](https://github.com/FunctionLab/diseasequest-docker/)：An integrative tissue-network approach to identify and test human disease genes. *Nat Biotechnol*. 2018 Oct 22. doi: 10.1038/nbt.4246.
- [bcbio-nextgen](https://github.com/bcbio/bcbio-nextgen)：Validated, scalable, community developed variant calling, RNA-seq and small RNA analysis.
- [chipseq_pipeline](https://github.com/kundajelab/chipseq_pipeline)：The AQUAS pipeline implements the ENCODE (phase-3) transcription factor and histone ChIP-seq pipeline specifications (by Anshul Kundaje).
- [deepTools](https://github.com/deeptools/deepTools)：Tools to process and analyze deep sequencing data. *Nucleic Acids Research*. 2016 Apr 13:gkw257.
- ......

使用和开发这类工具/流程的主要原因：

- 只需要掌握原生编程语言的语法和命令行工具的用法就可以开始构建工具/流程
- 其他流程化语言/框架也可以直接调用这些脚本/函数/模块/包/命令行程序
- 封装和打包可以减少代码的冗余程度、降低维护难度
- 通过使用各类编程语言自带的包管理器解决依赖问题，便于其他用户安装和调用

我目前主要是R语言、Python写命令行程序、函数、R包/模块，同时用CRAN、PyPI以及GitHub分发。

同时，因为R语言目前还没有提供一个原生机制直接部署命令行可执行程序（Python、Node包均提供），我现在做了两手准备：

- 在[ngstk](https://github.com/JhuangLab/ngstk)R包中增加`rbin`函数、以及[ngsjs](https://github.com/ngsjs/ngsjs)增加`rbin`命令行程序一键收集R包中`inst/bin`下面的文件。
- 以[npm包](https://www.npmjs.com/)的形式开发相应的R命令行程序，参见正在开发中的[ngsjs](https://github.com/ngsjs/ngsjs)包，初期目标是开发、收集200+和数据分析相关的命令行程序。
  
目前的体验来看，JavaScript提供的[npm](https://www.npmjs.com/)和[yarn](https://www.yarnpkg.com/zh-Hans/)包管理工具速度非常快和方便，很适合R语言用户同时使用（只需要会写一个package.json文件即可）。

### Common Workflow language（CWL）语言

Common Workflow language语言流是近几年兴起的，专门用于数据分析流程构建的一类语言/工具。

这类语言/工具最核心的部分：定义每一个计算过程（脚本）的输入和输出，然后通过连接这些输入和输出，构成数据分析流程（**图二**，**图三**）（如[Galaxy](https://galaxyproject.org/), [wdl](https://github.com/openwdl/wdl)，[cromwell](https://github.com/broadinstitute/cromwell)，[nextflow](https://github.com/nextflow-io/nextflow)，[snakemake](https://snakemake.readthedocs.io/en/stable/)，[bpipe](http://docs.bpipe.org/)等）。

<p align = "center">
<img src = "https://raw.githubusercontent.com/nextflow-io/cwl2nxf/master/docs/CWL_graph.png" />
<p align = "center"><b>图二</b> CWL流程示意图一 </p>
</p>

<p align = "center">
<img src = "https://raw.githubusercontent.com/peterjc/galaxy_blast/master/workflows/blast_top_hit_species/blast_top_hit_species.png" />
<p align = "center"><b>图三</b> CWL流程示意图二 </p>
</p>

示例项目：

- [chip-seq-pipeline2](https://github.com/ENCODE-DCC/chip-seq-pipeline2)：ENCODE Transcription Factor and Histone ChIP-Seq processing pipeline （[chipseq_pipeline](https://github.com/kundajelab/chipseq_pipeline)的WDL版）.
- [ngsjs-wkfl-wdl](https://github.com/ngsjs/ngsjs-wkfl-wdl/tree/master/workflow/github): A library of next-generation sequencing data analysis workflow (WDL).
- [biowdl](https://github.com/biowdl): BioWDL is a collection of pipelines and workflows usable for a variety of sequencing related analyses. They are made using WDL and closely related to BIOPET.
- [snakemake-workflows](https://github.com/inodb/snakemake-workflows): An experimental repo for common snakemake rules and workflows.
- ......

使用和开发这类工具的主要原因：

- 程序每一步的输入输出参数一目了然
- 有图形化流程设计器的支持
- 自带日志和运行状态监控功能
- ......

扩展阅读：

- [A review of bioinformatic pipeline frameworks](https://doi.org/10.1093/bib/bbw020). Brief Bioinform. 2017 May 1;18(3):530-536. doi: 10.1093/bib/bbw020.
- [Data Harmonization for a Molecularly Driven. 
Health System](https://doi.org/10.1016/j.cell.2018.08.012). *Cell*. 2018 Aug 23;174(5):1045-1048. doi: 10.1016/j.cell.2018.08.012.

### Makefile流

Makefile流主要是基于软件开发工具[Makefile](https://zh.wikipedia.org/wiki/Makefile)的rule、target语法运行流程。在[snakemake](https://snakemake.readthedocs.io/en/stable/)工具出现之后（使得数据分析流程支持CWL），使用`Makefile`式Rule文件构建生物信息学分析流程的用户迅速增加。

[pyflow-ATACseq](https://github.com/crazyhottommy/pyflow-ATACseq)项目提供的ATAC-seq数据分析流程（**图四**）：

<p align = "center">
<img src = "https://raw.githubusercontent.com/crazyhottommy/pyflow-ATACseq/master/rule_diagram.png
" />
<p align = "center"><b>图四</b> ATAC-seq Snakemake示例流程图 </p>
</p>

**snakemake示例文件**：

```Makefile
rule targets:
    input:
        "plots/dataset1.pdf",
        "plots/dataset2.pdf"

rule plot:
    input:
        "raw/{dataset}.csv"
    output:
        "plots/{dataset}.pdf"
    shell:
        "somecommand {input} {output}"
```

### 配置文件流

配置文件流（和CWL不冲突）主要是基于JSON、YAML、TOML等类型的配置文件，然后开发相应的解析器解析和执行流程。如[Galaxy](https://usegalaxy.org/)、华为公司最近开源的[Kubegene](https://github.com/kubegene/kubegene)（基于谷歌开发并开源的容器调度技术[kubernetes](https://github.com/kubernetes/kubernetes)）、[bashful](https://github.com/wagoodman/bashful)的流程文件。

很多计算机软件自动测试流程和构建工具也主要基于配置文件来构建和执行：如[circleci](https://circleci.com/)、[travis](https://www.travis-ci.org/)。

这里给出一个基于配置文件的工具示例（图五）：

<p align = "center">
<img src = "https://raw.githubusercontent.com/wagoodman/bashful/master/doc/demo.gif" />
<p align = "center"><b>图五</b> bashful执行输出 </p>
</p>

**bashful 输入文件格式及部分字段：**
```yaml
config:
    show-failure-report: false
    show-summary-errors: true
    max-parallel-commands: 6
    show-task-times: true

x-reference-data:
  all-apps: &app-names
    - some-lib-4
    - utilities-lib
    - important-lib
    - some-app1
    - some-app3

tasks:

  - name: Cloning Repos
    parallel-tasks:
      - name: "Cloning <replace>"
        cmd: example/scripts/random-worker.sh 2 <replace>
        ignore-failure: true
        for-each: *app-names

  - name: Building Repos
    parallel-tasks:
      - name: "Building <replace>"
        cmd: example/scripts/random-worker.sh 1 <replace>
        ignore-failure: true
        for-each: *app-names
```

复杂度较高的生物信息学流程/工具一般至少会提供一个配置文件来管理参数。用户目前也大多接受使用配置文件统一管理变量。

命令行参数也常常结合配置文件同时使用，这么做的主要原因：

- 可以有效减少动态更新和管理配置文件的次数
- 通过命令行修改参数也更加透明和便于日志记录

### **Jupyter notebook和R markdown流**

[Jupyter notebook](http://jupyter.org/)和[R markdown](https://rmarkdown.rstudio.com/)分别由Python语言和R语言社区贡献，均可以用于整合文档、代码、以及代码的输出，构建动态、交互式文档和报告系统。

这两个工具已经风靡全世界的数据科学社区，同时也占据了生物信息分析流程中的下游统计分析、建模、以及可视化。

这两个工具兴起的主要原因：

- 机器学习、高通量测序数据等数据科学的兴起
- 大量机器学习、生物信息学分析项目经常需要同时查看文档、即时查看输出、调试代码、进行可视化、撰写报告等
- 高质量可视化视图的兴起（颜值的时代）
- 已有工具使用起来有诸多不便之处，使用门槛相对较高

**Jupyter notebook示例（图六）：**

<p align = "center">
<img src = "https://www.dataquest.io/blog/content/images/interface-screenshot.png" />
<p align = "center"><b>图六</b> Jupyter notebook </p>
</p>

**R markdown示例（图七）：**

<p align = "center">
<img src = "https://rosannavanhespenresearch.files.wordpress.com/2016/02/rcode-example.png" />
<p align = "center"><b>图七</b> R markdown </p>
</p>

以R语言为例，在一个R包开发过程中，常常集成R markdown文件来动态更新文档、教程和项目主页。

比如其中我开发的两个项目[configr](https://github.com/Miachol/configr)（**图八**）、[BioInstaller](https://github.com/JhuangLab/BioInstaller)（**图九**）：

<p align = "center">
<img src = "https://raw.githubusercontent.com/Miachol/ftp/master/files/images/configr.png" />
<p align = "center"><b>图八</b> configr 说明文档 </p>
</p>

<p align = "center">
<img src = "https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller.png" />
<p align = "center"><b>图九</b> BioInstaller 项目主页</p>
</p>

相关的R包：

- [blogdown](https://github.com/rstudio/blogdown)：辅助个人博客创建和维护
- [bookdown](https://github.com/rstudio/bookdown)：辅助数据科学书籍的构建
- [xaringan](https://github.com/yihui/xaringan)：辅助创作Web PPT
- [pkgdown](https://github.com/r-lib/pkgdown)：一键生成R项目主页
- [shiny](https://github.com/rstudio/shiny)：辅助R markdown构建更复杂的交互式文档
- [future](https://github.com/HenrikBengtsson/future)：简化R语言用户的并行化操作

我在这里设想了一个R markdown的应用场景：

- 用户使用R markdown通过链接数据库、访问网页APIs的方式提交数据分析任务
- 构建文档即重新检查数据分析进程和状态、生成相应的运行状态可视化、表格等监控结果
- 完成上游数据分析之后可以直接开始进行下游个性化的数据统计分析和可视化、同时撰写结题报告
- 同时使用Shiny应用/其他通过网页服务展示分析结果

### 其他

软件和科学社区一直会有新的工具、思想、范式出现，生物信息学数据分析流程也不例外，我在这篇文章中所列的几种方式只能大致涵盖目前比较主流的几种方式。

还有一些”非主流“流程构建方式：

- **博导流：** ”A同学你过来一下，我们讨论一下你的课题，你可能需要写一个Pipeline，输入病人DNA、RNA的测序fastq文件、表型数据，输出所有可以完成的生物信息数据分析结果“
- **AI流：** **你好，Siri，帮我写一个Pipeline，输入...；输出....
- **公式流**

```python
output (multi_omics) ~ input(2 * DNA@wgs@fq + 2 * DNA@wes@fq + DNA@chip_seq + 2 * RNA@rnaseq@fq + n * RNA@scrna + ...)
output (paper) ~ input(patient@survive + patient@habits_and_customs + mutation@proteinpaint + mutation@stats + exp@diff + exp@splicing + exp@rna_editing + factors@regression + factors@correlation + ...)
```
