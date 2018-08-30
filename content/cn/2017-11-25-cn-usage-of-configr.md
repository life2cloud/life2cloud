---
title: "谈谈R包configr"
author: "Jianfeng Li"
date: '2017-11-25'
slug: cn-usage-of-configr
output: rmarkdown::md_document
categories: 
  - tutorial
tags: 
  - configuration file
  - configr
---

## 简介

[configr](https://github.com/Miachol/configr) 是我上传到[CRAN](https://cran.r-project.org/)的第一个R包，主要功能是解析和生成配置文件（json/ini/yaml/toml），分别用到了[jsonlite](https://github.com/jeroen/jsonlite)，[ini](https://github.com/dvdscripter/ini)， [yaml](https://cran.r-project.org/web/packages/yaml/index.html)和[RcppTOML](https://github.com/eddelbuettel/rcpptoml)。

configr是一个整合的并且进行了解析扩展的R包（开发动机主要是我比较烦记函数，另外解析配置文件之后很多参数还要做进一步处理），本教程将介绍常见的几种配置文件格式，以及configr的基本用法。


## 常见的配置文件类型

在生物信息学工具或者方法开发过程中，给用户提供一个简洁明了的配置文件进行自定义配置是一个非常好的选择。所以，为了更好的编写和解析配置文件，大家首先就要熟悉目前R语言中常用的配置文件解析工具，我下面列出了目前主要的几种配置文件格式供大家参考：

### json

```json
{
  "default": {
    "debug": "{{debug}} {{debug2}}"
  },
  "comments": {
    "version": "0.2.3"
  }
}
```
参考：[json.org](http://www.json.org/), [json examples](http://www.json.org/example.html), [json-wiki](https://en.wikipedia.org/wiki/JSON)

### ini

```ini
[default]
debug = {{debug}} {{debug2}}

[comments]
version = 0.2.3
```

参考：[ini-wiki](https://en.wikipedia.org/wiki/INI_file)

### yaml

```yaml

default:
  debug: '{{debug}} {{debug2}}'
comments:
  version: 0.2.3
```

参考：[yaml.org](http://www.yaml.org/), [yaml-wiki](https://en.wikipedia.org/wiki/YAML)

### toml

```toml

# This is a TOML document. Jianfeng.

title = "TOML Example"

[default]
debug = "{{debug}} {{debug2}}"

[comments]
version = "0.2.3"

[comments.ljf]
content = "Hello World!"
```

参考：[toml-github](https://github.com/toml-lang/toml), [toml-wiki](https://en.wikipedia.org/wiki/TOML)

### xml

```xml
<?xml version="1.0" encoding="ISO-8859-1"?>
<!--  Copyright w3school.com.cn -->
<note>
	<to>George</to>
	<from>John</from>
	<heading>Reminder</heading>
	<body>Don't forget the meeting!</body>
</note>
```

参考：[XML-wiki](https://en.wikipedia.org/wiki/XML)

## 用法

configr选择支持了json, ini, yaml, toml四种配置文件格式，下面将主要讲一下configr的基本用法，主要分为一下几块内容：配置文件格式识别、配置文件读取、配置文件的格式转换、配置文件扩展解析


### 格式识别


```r
# 获取R包configr中内置的四种配置文件
library(configr)
config.json <- system.file("extdata", "config.json", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")

# 配置文件格式识别相关函数
is.json.file(config.json)
```

```
## [1] TRUE
```

```r
is.toml.file(config.toml)
```

```
## [1] TRUE
```

```r
is.ini.file(config.ini)
```

```
## [1] TRUE
```

```r
is.yaml.file(config.yaml)
```

```
## [1] TRUE
```

```r
get.config.type(config.json)
```

```
## [1] "json"
```

```r
get.config.type(config.yaml)
```

```
## [1] "yaml"
```

```r
get.config.type(config.ini)
```

```
## [1] "ini"
```

```r
get.config.type(config.toml)
```

```
## [1] "toml"
```

### 配置文件读取


```r
# 获取配置文件中主键名称
eval.config.sections(config.ini)
```

```
## [1] "default"            "comments"          
## [3] "extra_list_parse"   "other_config_parse"
## [5] "rcmd_parse"         "bash_parse"        
## [7] "mulitple_parse"     "glue_parse"
```

```r
eval.config.sections(config.toml)
```

```
## [1] "bash_parse"         "comments"          
## [3] "default"            "extra_list_parse"  
## [5] "glue_parse"         "mulitple_parse"    
## [7] "other_config_parse" "title"
```

```r
# 读取配置文件生成R中的列表
# 注意：可以直接传递fromJSON/read.ini/readLines/yaml.load相关参数给read.config
read.config(file = config.toml)
```

```
## List of 8
##  $ bash_parse        :List of 2
##   ..$ parsed: chr "bash"
##   ..$ raw   : chr "#>#echo bash#<#"
##  $ comments          :List of 1
##   ..$ version: chr "0.2.3"
##  $ default           :List of 1
##   ..$ debug: chr "{{debug}} {{debug2}}"
##  $ extra_list_parse  :List of 2
##   ..$ parsed: chr "1"
##   ..$ raw   : chr "{{yes}}"
##  $ glue_parse        :List of 4
##   ..$ parsed_1: chr [1:10] "1" "2" "3" "4" ...
##   ..$ parsed_2: int [1:10] 1 2 3 4 5 6 7 8 9 10
##   ..$ raw_1   : chr "!!glue {1:10}"
##   ..$ raw_2   : chr "!!glue_numeric {1:10}"
##  $ mulitple_parse    :List of 2
##   ..$ parsed: chr "configr, configr, yes, 1, config, config, no, 0"
##   ..$ raw   : chr "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr',"| __truncated__
##  $ other_config_parse:List of 2
##   ..$ parsed: chr "yes no"
##   ..$ raw   : chr "{{key:yes_flag}} {{key:no_flag}}"
##  $ title             : chr "TOML Example"
```

```r
# Get the same obj with config package, only get the 'default
# or R_CONFIG_ACTIVE config sets' in config.cfg or
# R_CONFIGFILE_ACTIVE
eval.config(file = config.yaml)
```

```
## $debug
## [1] "{{debug}} {{debug2}}"
## 
## attr(,"config")
## [1] "default"
## attr(,"configtype")
## [1] "yaml"
## attr(,"file")
## [1] "/Library/Frameworks/R.framework/Versions/3.5/Resources/library/configr/extdata/config.yaml"
```

```r
# Read designated section
eval.config(file = config.json, config = "comments")
```

```
## $version
## [1] "0.2.3"
## 
## attr(,"config")
## [1] "comments"
## attr(,"configtype")
## [1] "json"
## attr(,"file")
## [1] "/Library/Frameworks/R.framework/Versions/3.5/Resources/library/configr/extdata/config.json"
```

```r
# Read designated section with its one value
eval.config(file = config.ini, config = "comments", value = "version")
```

```
## [1] "0.2.3"
```

```r
# eval.config.merge 可以合并几个主键并减少配置文件的层数
eval.config.merge(file = config.json, sections = c("default", 
  "comments"))
```

```
## $debug
## [1] "{{debug}} {{debug2}}"
## 
## $version
## [1] "0.2.3"
## 
## attr(,"config")
## [1] "default"  "comments"
## attr(,"configtype")
## [1] "json"
## attr(,"file")
## [1] "/Library/Frameworks/R.framework/Versions/3.5/Resources/library/configr/extdata/config.json"
```

```r
eval.config.merge(file = config.toml, sections = c("default", 
  "comments"))
```

```
## $debug
## [1] "{{debug}} {{debug2}}"
## 
## $version
## [1] "0.2.3"
## 
## attr(,"config")
## [1] "default"  "comments"
## attr(,"configtype")
## [1] "toml"
## attr(,"file")
## [1] "/Library/Frameworks/R.framework/Versions/3.5/Resources/library/configr/extdata/config.toml"
```

```r
# fetch.config可以导入http:// ftp://以及本地文件，
# 它会将这些文件进行收集和读取，然后生成一个合并的R列表对象
links <- c("https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml", 
  "https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml", 
  system.file("extdata", "config.toml", package = "configr"))
x <- fetch.config(links)
x[c(1:5, length(x))]
```

```
## $db_annovar_1000g
## $db_annovar_1000g$buildver_available
## $db_annovar_1000g$buildver_available$`1000g`
## [1] "hg18"
## 
## $db_annovar_1000g$buildver_available$`1000g2010`
## [1] "hg18"
## 
## $db_annovar_1000g$buildver_available$`1000g2012apr`
## [1] "hg19" "hg18"
## 
## $db_annovar_1000g$buildver_available$`1000g2012jul`
## [1] "hg18"
## 
## $db_annovar_1000g$buildver_available$`1000g2014oct`
## [1] "hg38" "hg19" "hg18"
## 
## $db_annovar_1000g$buildver_available$`1000g2015aug`
## [1] "hg38" "hg19"
## 
## $db_annovar_1000g$buildver_available$other
## [1] "hg19"
## 
## 
## $db_annovar_1000g$description
## [1] "alternative allele frequency data in 1000 Genomes Project"
## 
## $db_annovar_1000g$source_url
## [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.zip"
## 
## $db_annovar_1000g$version_available
##  [1] "1000g2015aug" "1000g2014oct" "1000g2014sep"
##  [4] "1000g2014aug" "1000g2012apr" "1000g2012feb"
##  [7] "1000g2011may" "1000g2010nov" "1000g2012apr"
## [10] "1000g2010jul" "1000g2010"    "1000g"       
## 
## $db_annovar_1000g$version_newest
## [1] "1000g2015aug"
## 
## 
## $db_annovar_1000g_sqlite
## $db_annovar_1000g_sqlite$buildver_available
## [1] "hg19"
## 
## $db_annovar_1000g_sqlite$install
## [1] "#R#for(i in c('all', 'afr', 'eas', 'eur', 'sas', 'amr')) {\\n  x <- set.1000g.db(sprintf('{{version}}_%s', i), '{{buildver}}', \\\"sql\\\");\\n  params <- list(sql.file = x, dbname = str_replace(x, '.sql$', ''));\\n  do.call(sql2sqlite, params)\\n}\\n#R#"
## 
## $db_annovar_1000g_sqlite$source_url
## [1] "http://bioinfo.rjh.com.cn/download/annovarR/humandb/{{buildver}}_{{version}}.tar.gz"
## 
## $db_annovar_1000g_sqlite$version_available
## [1] "1000g2015aug"
## 
## $db_annovar_1000g_sqlite$version_newest
## [1] "1000g2015aug"
## 
## 
## $db_annovar_abraom
## $db_annovar_abraom$buildver_available
## [1] "hg19" "hg38"
## 
## $db_annovar_abraom$description
## [1] "abraom: 2.3 million [Brazilian genomic variants](https://www.ncbi.nlm.nih.gov/pubmed/28332257)"
## 
## $db_annovar_abraom$source_url
## [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.gz"
## 
## $db_annovar_abraom$version_available
## [1] "abraom"
## 
## 
## $db_annovar_avsift
## $db_annovar_avsift$buildver_available
## [1] "hg19" "hg18"
## 
## $db_annovar_avsift$decompress
## [1] TRUE TRUE
## 
## $db_annovar_avsift$description
## [1] "whole-exome SIFT scores for non-synonymous variants (obselete and should not be uesd any more)"
## 
## $db_annovar_avsift$source_url
## [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.gz"    
## [2] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.idx.gz"
## 
## $db_annovar_avsift$version_available
## [1] "avsift"
## 
## $db_annovar_avsift$version_newest
## [1] "avsift"
## 
## 
## $db_annovar_avsnp
## $db_annovar_avsnp$buildver_available
## $db_annovar_avsnp$buildver_available$avsnp138
## [1] "hg19"
## 
## $db_annovar_avsnp$buildver_available$avsnp142
## [1] "hg38" "hg19"
## 
## $db_annovar_avsnp$buildver_available$avsnp144
## [1] "hg38" "hg19"
## 
## $db_annovar_avsnp$buildver_available$avsnp147
## [1] "hg38" "hg19"
## 
## $db_annovar_avsnp$buildver_available$avsnp150
## [1] "hg38" "hg19"
## 
## 
## $db_annovar_avsnp$decompress
## [1] TRUE TRUE
## 
## $db_annovar_avsnp$description
## $db_annovar_avsnp$description$avsnp138
## [1] "dbSNP138 with allelic splitting and left-normalization"
## 
## $db_annovar_avsnp$description$avsnp142
## [1] "dbSNP142 with allelic splitting and left-normalization"
## 
## $db_annovar_avsnp$description$avsnp144
## [1] "dbSNP144 with allelic splitting and left-normalization (http://annovar.openbioinformatics.org/en/latest/articles/dbSNP/#additional-discussions)"
## 
## $db_annovar_avsnp$description$avsnp147
## [1] "dbSNP147 with allelic splitting and left-normalization"
## 
## 
## $db_annovar_avsnp$source_url
## [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.gz"    
## [2] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.idx.gz"
## 
## $db_annovar_avsnp$version_available
## [1] "avsnp150" "avsnp147" "avsnp144" "avsnp142" "avsnp138"
## 
## $db_annovar_avsnp$version_newest
## [1] "avsnp150"
## 
## 
## $title
## [1] "TOML Example"
```

### 配置文件格式转换


```r
# Convert YAML configuration file to JSON format
out.json <- tempfile(fileext = ".json")
convert.config(file = config.yaml, out.file = out.json, convert.to = "JSON")
```

```
## [1] TRUE
```

```r
get.config.type(out.json)
```

```
## [1] "json"
```

```r
# Generate a JSON format configuration file
list.test <- list(a = c(123, 456))
out.fn <- sprintf("%s/test.json", tempdir())
write.config(config.dat = list.test, file.path = out.fn, write.type = "json")
```

```
## [1] TRUE
```

```r
get.config.type(out.fn)
```

```
## [1] "json"
```

```r
# Generate a YAML format configuration file with defined
# indent
write.config(config.dat = list.test, file.path = out.fn, write.type = "yaml", 
  indent = 4)
```

```
## [1] TRUE
```

```r
get.config.type(out.fn)
```

```
## [1] "yaml"
```

### 配置文件扩展解析

为了最大化利用配置文件，我定义了一些规则来进行扩展解析，也就是在jsonlite/ini/yaml/RcppTOML读取配置文件之后进行额外的解析和操作。

- `extra.list`可以用来替换配置文件中两个大括号括起来的值，比如`{{debug}}`会被替换为`extra.list = list(debug = 'self')`中的`self`
- `other.config`可以被用来联系两个配置文件，如果你设置`other.config = system.file('extdata', 'config.other.yaml', package='configr')`，它会在config.other.yaml中读取`key`并且获取`yes_flag`的值然后替换解析的配置文件中对应的`{{key:yes_flag}}`值。
- `rcmd.parse`可以被用来解析`@>@str_replace('config','g$','gr')@<@`，它可以将这一部分替换为R命令运行的结果。
- `bash.parse`可以被用来解析`#>#echo bash#<#`，它可以将这一部分替换为系统终端的命令运行结果.
- `glue.parse`使用了R包[glue](https://cran.r-project.org/web/packages/glue/index.html)进行相关解析，它会替换`!!glue {1:5}`变为["1", "2", "3", "4", "5"]; `!!glue_numeric {1:5}`变为`[1, 2, 3, 4, 5]`

下面是一些具体的实例供大家参考。


```r
other.config <- system.file("extdata", "config.other.yaml", package = "configr")

read.config(file = other.config)
```

```
## $key
## $key$test_parse
## [1] 123
## 
## $key$test_parse2
## [1] 234
## 
## $key$yes_flag
## [1] "yes"
## 
## $key$no_flag
## [1] "no"
## 
## 
## $`samtools@1.3.1`
## $`samtools@1.3.1`$source_dir
## [1] "/tmp"
```

```r
config.1 <- read.config(file = config.json)
config.1$default
```

```
## $debug
## [1] "{{debug}} {{debug2}}"
```

```r
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"))$default
```

```
## $debug
## [1] "self self2"
```

```r
sections <- c("default", "other_config_parse")
config.1[sections]
```

```
## $default
## $default$debug
## [1] "{{debug}} {{debug2}}"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "{{key:yes_flag}} {{key:no_flag}}"
## 
## $other_config_parse$parsed
## [1] "yes no"
```

```r
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"), other.config = other.config)[sections]
```

```
## $default
## $default$debug
## [1] "self self2"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "yes no"
## 
## $other_config_parse$parsed
## [1] "yes no"
```

```r
sections <- c("default", "other_config_parse", "rcmd_parse")
# The followed two line command will return the same value
config.1[sections]
```

```
## $default
## $default$debug
## [1] "{{debug}} {{debug2}}"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "{{key:yes_flag}} {{key:no_flag}}"
## 
## $other_config_parse$parsed
## [1] "yes no"
## 
## 
## $rcmd_parse
## $rcmd_parse$raw
## [1] "@>@ Sys.Date() @<@"
```

```r
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"), other.config = other.config, rcmd.parse = T)[sections]
```

```
## $default
## $default$debug
## [1] "self self2"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "yes no"
## 
## $other_config_parse$parsed
## [1] "yes no"
## 
## 
## $rcmd_parse
## $rcmd_parse$raw
## [1] "2018-07-26"
```

```r
parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)[sections]
```

```
## $default
## $default$debug
## [1] "self self2"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "yes no"
## 
## $other_config_parse$parsed
## [1] "yes no"
## 
## 
## $rcmd_parse
## $rcmd_parse$raw
## [1] "2018-07-26"
```

```r
sections <- c("default", "other_config_parse", "rcmd_parse", 
  "mulitple_parse")
config.1[sections]
```

```
## $default
## $default$debug
## [1] "{{debug}} {{debug2}}"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "{{key:yes_flag}} {{key:no_flag}}"
## 
## $other_config_parse$parsed
## [1] "yes no"
## 
## 
## $rcmd_parse
## $rcmd_parse$raw
## [1] "@>@ Sys.Date() @<@"
## 
## 
## $mulitple_parse
## $mulitple_parse$raw
## [1] "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #># echo config#<#, {{key:no_flag}}, {{no}}"
## 
## $mulitple_parse$parsed
## [1] "configr, configr, yes, 1, config, config, no, 0"
```

```r
parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2", 
  yes = "1", no = "0"), other.config = other.config, rcmd.parse = T, 
  bash.parse = F)[sections]
```

```
## $default
## $default$debug
## [1] "self self2"
## 
## 
## $other_config_parse
## $other_config_parse$raw
## [1] "yes no"
## 
## $other_config_parse$parsed
## [1] "yes no"
## 
## 
## $rcmd_parse
## $rcmd_parse$raw
## [1] "2018-07-26"
## 
## 
## $mulitple_parse
## $mulitple_parse$raw
## [1] "configr, #>#echo configr#<#, yes, 1, config, #># echo config#<#, no, 0"
## 
## $mulitple_parse$parsed
## [1] "configr, configr, yes, 1, config, config, no, 0"
```

```r
# glue parse
raw <- c("a", "!!glue{1:5}", "c")
list.raw <- list(glue = raw, nochange = 1:10)
list.raw
```

```
## $glue
## [1] "a"           "!!glue{1:5}" "c"          
## 
## $nochange
##  [1]  1  2  3  4  5  6  7  8  9 10
```

```r
expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)
parse.extra(list.raw, glue.parse = TRUE, glue.flag = "!!glue")
```

```
## $glue
## [1] "a" "1" "2" "3" "4" "5" "c"
## 
## $nochange
##  [1]  1  2  3  4  5  6  7  8  9 10
```
