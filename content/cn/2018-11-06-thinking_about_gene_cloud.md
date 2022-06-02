---
title: 聊一聊生信云（计算）
author: Jianfeng Li
date: '2018-11-06'
slug: thinking_about_gene_cloud
categories:
  - thinking
tags:
  - bioinformatics cloud
---

生信云（计算）作为生物信息学发展的产物，它在生物信息学整个学科发展中起到了举足轻重的作用。生物信息学领域科研人员日常进行的数据分析工作已经和生信云紧紧联系在一起。在可以预见的几十年内，生信云将会成为云计算领域中消耗资源最多、影响力最大的方向之一。

生信云一直是我比较感兴趣的方向，2018年11月初有机会到杭州华为云走一趟，让我更想专门聊一聊生信云。这篇文章主要来源于我日常在生信云方向上的一些阅读和思考。

## 云

我们最早接触“云”这个概念（**图一**），大多是飘在天空上的白色物质（水蒸气），如云朵、云彩等。比如《西游记》中孙悟空踩着的筋斗云。

柯林斯词典“云”的注解：

- A cloud is a mass of water vapour that floats in the sky. Clouds are usually white or grey in colour.
- A cloud of something such as smoke or dust is a mass of it floating in the air.
- If you say that something clouds your view of a situation, you mean that it makes you unable to understand the situation or judge it properly.
- If you say that something clouds a situation, you mean that it makes it unpleasant.
- If your eyes or face cloud or if sadness or anger clouds them, your eyes or your face suddenly show sadness or anger.
- If glass clouds or if moisture clouds it, tiny drops of water cover the glass, making it difficult to see through.
- Cloud-based technology allows you to use programs and information that are stored on the internet rather than on your own computer.
- ......

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/cloud.jpg)

**图1** 云（Clouds）

时至今日，“云”一词已经不再只是“白云”（**图一**），已经华丽变身为互联网行业、甚至是普罗大众都耳熟能详的计算机术语。

你对“云”有多少了解？

我理解的“云”，主要是指那些需要通过网络连接的远程服务器。用户通过网络连接远程服务器，就可以利用那些不在本地设备（比如个人PC、手机等）上的数据和程序，完成更复杂的计算或者任务。

## 云计算

> 云计算是可配置式计算机系统资源和更高水平服务的共享池，可以通过最少的管理工作快速配置，并通常通过互联网连接。云计算依赖于资源共享来实现一致性和规模经济，类似于公用事业。---维基百科

“云计算”是一个真正的网红词汇，早在2011年，就已经在互联网上被使用超过4000多万次。“云计算”最早是在1996年被提出。你可以想象当时的场景，在美国得克萨斯州一间小办公室（半导体制造商Compaq Computer公司），一小群技术极客正在策划互联网业务的未来：“云计算”。转眼到2006年，亚马逊公司当时推出的弹性计算服务器，使得“云计算”真正的开始普及，并开始被广泛使用。

### 云计算服务模式

主要的云计算服务模式：

- 基础设施即服务（IaaS）
- 平台即服务（PaaS）
- 软件即服务（SaaS）
- 移动“后端”即服务（MBaaS）
- 无服务器计算
- 作为服务的功能（FaaS）

详细信息参见：[Wiki百科](https://en.wikipedia.org/wiki/Cloud_computing)。

### 云计算部署类型

主要的云计算部署类型：

- 私有云
- 公共云
- 混合云
- 其他（社区云、分布式云、多声道、大数据云、HPC云）

私有云是专为单个组织运营的云基础架构，无论是内部管理还是第三方管理。如果服务是通过公开网络，则被称为“公共云”。公共云服务可能是免费的（比如一些商业公司提供的免费存储空间或者计算资源）。

混合云是两个或多个云（私有云，社区云或公共云）的组合，它们保持不同的实体但绑定在一起。组织/用户可以将敏感的客户端数据存储在私有云，不敏感的数据存储在公共云，私有云的应用程序也可以单向和托管在公共云服务器上的应用程序进行互联通讯。

医院大多会选择私有云或混合云进行部署云计算资源，病人相关的敏感数据大多会存放在严格保护的医院内部私有云上并完成数据分析过程。不过，当高通量测序技术真正成为临床检测中的常规技术之后，这些基因数据对存储和计算的资源需求将会远远超出目前各个医院所采购/将要采购的私有云硬件设施。在国外，部分Top级医院已经开始利用公共云存放、计算和共享病人脱敏的测序数据（如全基因组等）：大型生信云平台（**图二**）。

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/sjcloud.png)

**图二** 美国圣述德儿童医院 St. Jude Cloud （共享超过5000例儿童癌症全基因组、6000例外显子、1500例RNA-seq数据)，`DOI: 10.1158/1538-7445.AM2018-922`

## 生信云

生信云是云计算市场中必不可少且增长速度最快的部分之一，是云计算行业最具实际应用价值的方向之一：承担**人类疾病数据的存储、数据挖掘和知识转化**。

生信云主要面向的是生物学、医学等生命科学领域，涉及到生物信息学数据存储和分析的各个方面，比如基因序列数据的压缩技术、基因序列的质量控制、比对、组装、查询、基因组序列和结构变异的检测和注释、mRNA转录本定量、融合基因检测、可变剪接检测、基因组/转录组/表观组关联分析等等。**图三**和**图四**从[Omictools](http://omictools.com)截取了一部分生物信息学分析应用。

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/omictools_dna_sequence.png)

**图三** Omictools DNA 序列分析应用

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/omictools_rna_transcription.png)

**图四** Omictools RNA 数据分析应用

### 用户的生信云需求

用户在生信云上的需求非常广泛，其中数据存储/管理、数据分析应用是用户两个最主要的应用层需求方面。

- 如何快速、便宜地上传/存储/分析/下载自己的测序数据（这一需求已经限制了大多数生信云应用和平台的普及和推广）
- 如何快速获取公开的或者授权获取的测序数据资源以及下游分析结果、数据库整合应用（基于公共云平台的吸引力之一）
- 数据的压缩、临床样本库管理系统、生物信息学项目管理系统、数据托管系统、临床知识库管理系统（数据存储和管理）
- 基于容器化的生信数据分析Pipeline、临床检测报告系统等（数据分析应用）
- 其他：公共数据爬取应用、个性化云可视化平台......

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/omictools_sequence_compress.png)

**图五** Omictools 基因序列压缩应用

### 生信云生态

生信云生态是生信云技术发展所依赖的土壤。和自然生态、社会生态一样，生信云的发展、进步离不开一个良性发展的“生态系统”，好的生信云生态将有利于整个行业的发展。

### 建设生信云生态的意义：

1. 有利于让用户建立开放科学的思想、促进生信大数据的积累和共享（数据共享是一个大趋势，顶级英文杂志大多会要求共享原始数据。
）
2. 减少生信数据的资源浪费（如数据的冗余存储）
3. 满足用户的个性化需求、促进知识挖掘和转化
4. 简化生信数据的再利用和重分析过程
5. 促进生物医学的知识挖掘和转化速度
6. ......

下面列了一些比较大型、免费的数据/分析软件共享仓库：

- [dbGaP](https://www.ncbi.nlm.nih.gov/gap)
- [GEO](https://www.ncbi.nlm.nih.gov/geo)
- [EGA](https://www.ebi.ac.uk/ega)
- [DDJB](https://www.ddbj.nig.ac.jp)
- [GSA](http://bigd.big.ac.cn/gsa/)
- [GitHub](https://github.com/)
- [Zenodo](https://zenodo.org)

这些数据库/网站已经极大的改善了生物组学数据/工具的共享和分发。不过，目前科研人员利用这些平台的数据/软件仍然需要拷贝/下载到自己的服务器上。期待在未来，这些数据可以同步、分散存放在全球按国家/地区建设的几大数据中心（公共云），科研人员通过公共云平台进行数据挖掘，减少数据传输的外网带宽占用，减少原始数据的存储硬盘消耗。

除了数据共享和数据的存储，数据分析流程的质量控制以及数据的重分析也都是我们必须要面对的问题。

有多少研究组/机构会对自己的生物信息学分析流程进行质量控制和管理？使用标准化，经过质量控制的数据分析流程对最终结果的重现性和准确性至关重要。

有多少研究组/机构会有计划地、系统地、规范地重分析自己几年前的数据（特别是疾病相关的数据）？综合的数据重分析和再利用有利于验证之前的分析结果和发现新的知识，比如TCGA项目组开展的[Pan-cancer项目](https://lif2cloud.com/cn/2017/12/jcb-tcga-pan-cancer-project/)就是肿瘤学数据重分析项目最好的例子。

### 建设生信云生态面临的挑战、困难以及可能的解决方案

- 开放科学思想在国内不是那么深入人心（可能需要大范围建立科研协作组；科研协作组内共享数据，统一数据质量控制和分析流程）
- 公共云的网络传输速度和价格是否已经符合大面积推广生信云的要求？（5G通讯技术；电信网络扩容（数据中心间建立专网））
- 生信云推广前期的种子用户是哪些（医院、科研单位、商业公司）？可以负担起昂贵的公共云费用（存储和网络通讯费）的用户量目前仍然较少（国家定向减免、补贴与医学研究相关的重大基础设施和网络通讯费；商业公司参与实际科研项目、共享数据和专利产权）
- 如何说服机构的生物信息学负责人/行政领导人参与到生信云生态的建设，用户/机构大多持有仪器采购观念、数据独享观念（国家层面的统筹规划和协调、重点项目的示范作用）
- ......

