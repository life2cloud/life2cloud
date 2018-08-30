---
title: "Usage of configr"
author: "Jianfeng Li"
date: "2017-11-22"
slug: usage-of-configr
categories:
  - tutorial
tags:
  - configr
  - configuration file
---

configr is an integrated parser package that json, ini, yaml and toml format files can now be processed. The vignette will walk you through the basics of using configr to extend existing parser in R.

## Built-in examples of configuration file

Example of json, ini, yaml, toml can be used follow the instructions below.


```r
library(configr)
config.json <- system.file("extdata", "config.json", package = "configr")
config.ini <- system.file("extdata", "config.ini", package = "configr")
config.yaml <- system.file("extdata", "config.yaml", package = "configr")
config.toml <- system.file("extdata", "config.toml", package = "configr")
```

## Check the configuration file type

`is.json.file`, `is.ini.file`, `is.yaml.file` and `is.toml.file` can be used to check the configuration file type. If input file were coincident with required, it will return TRUE. `get.config.type` will using above functions and get the file type name: json, ini, yaml, toml or FALSE.


```r
is.json.file(config.json)
#> [1] TRUE
is.toml.file(config.toml)
#> [1] TRUE
is.ini.file(config.ini)
#> [1] TRUE
is.yaml.file(config.yaml)
#> [1] TRUE
get.config.type(config.json)
#> [1] "json"
get.config.type(config.yaml)
#> [1] "yaml"
get.config.type(config.ini)
#> [1] "ini"
get.config.type(config.toml)
#> [1] "toml"
```

## Get the configuration section names

Section names of configuration file can be get using `eval.config.sections`. Python package [ConfigParser](https://pypi.python.org/pypi/configparser) `sections` inspired us to add this function.


```r
eval.config.sections(config.ini)
#> [1] "default"            "comments"          
#> [3] "extra_list_parse"   "other_config_parse"
#> [5] "rcmd_parse"         "bash_parse"        
#> [7] "mulitple_parse"     "glue_parse"
eval.config.sections(config.toml)
#> [1] "bash_parse"         "comments"          
#> [3] "default"            "extra_list_parse"  
#> [5] "glue_parse"         "mulitple_parse"    
#> [7] "other_config_parse" "title"
```

## Read the configuration file

`read.config` can read a configuration file in R and as a list object that can pass parameter to inner read function (fromJSON/read.ini/yaml.load_file/parseToml) accordingly.


```r
# Read in R as a list (JSON/INI/YAML/TOML be suported)
# fromJSON/read.ini/readLines/yaml.load parameters can be
# automatch by parameter name (encoding .etc.)
read.config(file = config.toml)
#> List of 8
#>  $ bash_parse        :List of 2
#>   ..$ parsed: chr "bash"
#>   ..$ raw   : chr "#>#echo bash#<#"
#>  $ comments          :List of 1
#>   ..$ version: chr "0.2.3"
#>  $ default           :List of 1
#>   ..$ debug: chr "{{debug}} {{debug2}}"
#>  $ extra_list_parse  :List of 2
#>   ..$ parsed: chr "1"
#>   ..$ raw   : chr "{{yes}}"
#>  $ glue_parse        :List of 4
#>   ..$ parsed_1: chr [1:10] "1" "2" "3" "4" ...
#>   ..$ parsed_2: int [1:10] 1 2 3 4 5 6 7 8 9 10
#>   ..$ raw_1   : chr "!!glue {1:10}"
#>   ..$ raw_2   : chr "!!glue_numeric {1:10}"
#>  $ mulitple_parse    :List of 2
#>   ..$ parsed: chr "configr, configr, yes, 1, config, config, no, 0"
#>   ..$ raw   : chr "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr',"| __truncated__
#>  $ other_config_parse:List of 2
#>   ..$ parsed: chr "yes no"
#>   ..$ raw   : chr "{{key:yes_flag}} {{key:no_flag}}"
#>  $ title             : chr "TOML Example"
```

`eval.config` return a value or a list object containing the file path, config group, filetype as the attribute.


```r
# Get the same obj with config package, only get the 'default
# or R_CONFIG_ACTIVE config sets' in config.cfg or
# R_CONFIGFILE_ACTIVE
eval.config(file = config.yaml)
#> $debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> attr(,"config")
#> [1] "default"
#> attr(,"configtype")
#> [1] "yaml"
#> attr(,"file")
#> [1] "/home/ljf/Rlibrary/configr/extdata/config.yaml"

# Read designated section
eval.config(file = config.json, config = "comments")
#> $version
#> [1] "0.2.3"
#> 
#> attr(,"config")
#> [1] "comments"
#> attr(,"configtype")
#> [1] "json"
#> attr(,"file")
#> [1] "/home/ljf/Rlibrary/configr/extdata/config.json"

# Read designated section with its one value
eval.config(file = config.ini, config = "comments", value = "version")
#> [1] "0.2.3"
```

`eval.config.merge` will merge multiple sections (equal to `config` in `eval.config` function) and reduce the layer of configuration file.


```r
eval.config.merge(file = config.json, sections = c("default", 
  "comments"))
#> $debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> $version
#> [1] "0.2.3"
#> 
#> attr(,"config")
#> [1] "default"  "comments"
#> attr(,"configtype")
#> [1] "json"
#> attr(,"file")
#> [1] "/home/ljf/Rlibrary/configr/extdata/config.json"
eval.config.merge(file = config.toml, sections = c("default", 
  "comments"))
#> $debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> $version
#> [1] "0.2.3"
#> 
#> attr(,"config")
#> [1] "default"  "comments"
#> attr(,"configtype")
#> [1] "toml"
#> attr(,"file")
#> [1] "/home/ljf/Rlibrary/configr/extdata/config.toml"
```

`fetch.config` can parse configuration files from internet and local that merged the files and return a list.


```r
links <- c("https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_annovar.toml", 
  "https://raw.githubusercontent.com/JhuangLab/BioInstaller/master/inst/extdata/config/db/db_main.toml", 
  system.file("extdata", "config.toml", package = "configr"))
x <- fetch.config(links)
x[c(1:5, length(x))]
#> $db_annovar_1000g
#> $db_annovar_1000g$buildver_available
#> $db_annovar_1000g$buildver_available$`1000g`
#> [1] "hg18"
#> 
#> $db_annovar_1000g$buildver_available$`1000g2010`
#> [1] "hg18"
#> 
#> $db_annovar_1000g$buildver_available$`1000g2012apr`
#> [1] "hg19" "hg18"
#> 
#> $db_annovar_1000g$buildver_available$`1000g2012jul`
#> [1] "hg18"
#> 
#> $db_annovar_1000g$buildver_available$`1000g2014oct`
#> [1] "hg38" "hg19" "hg18"
#> 
#> $db_annovar_1000g$buildver_available$`1000g2015aug`
#> [1] "hg38" "hg19"
#> 
#> $db_annovar_1000g$buildver_available$other
#> [1] "hg19"
#> 
#> 
#> $db_annovar_1000g$description
#> [1] "alternative allele frequency data in 1000 Genomes Project"
#> 
#> $db_annovar_1000g$source_url
#> [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.zip"
#> 
#> $db_annovar_1000g$version_available
#>  [1] "1000g2015aug" "1000g2014oct" "1000g2014sep"
#>  [4] "1000g2014aug" "1000g2012apr" "1000g2012feb"
#>  [7] "1000g2011may" "1000g2010nov" "1000g2012apr"
#> [10] "1000g2010jul" "1000g2010"    "1000g"       
#> 
#> $db_annovar_1000g$version_newest
#> [1] "1000g2015aug"
#> 
#> 
#> $db_annovar_1000g_sqlite
#> $db_annovar_1000g_sqlite$buildver_available
#> [1] "hg19"
#> 
#> $db_annovar_1000g_sqlite$install
#> [1] "#R#for(i in c('all', 'afr', 'eas', 'eur', 'sas', 'amr')) {\\n  x <- set.1000g.db(sprintf('{{version}}_%s', i), '{{buildver}}', \\\"sql\\\");\\n  params <- list(sql.file = x, sqlite.path = str_replace(x, '.sql$', ''));\\n  do.call(sql2sqlite, params)\\n}\\n#R#"
#> 
#> $db_annovar_1000g_sqlite$source_url
#> [1] "http://bioinfo.rjh.com.cn/download/annovarR/humandb/{{buildver}}_{{version}}.tar.gz"
#> 
#> $db_annovar_1000g_sqlite$version_available
#> [1] "1000g2015aug"
#> 
#> $db_annovar_1000g_sqlite$version_newest
#> [1] "1000g2015aug"
#> 
#> 
#> $db_annovar_avsift
#> $db_annovar_avsift$buildver_available
#> [1] "hg19" "hg18"
#> 
#> $db_annovar_avsift$decompress
#> [1] TRUE TRUE
#> 
#> $db_annovar_avsift$description
#> [1] "whole-exome SIFT scores for non-synonymous variants (obselete and should not be uesd any more)"
#> 
#> $db_annovar_avsift$source_url
#> [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.gz"    
#> [2] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.idx.gz"
#> 
#> $db_annovar_avsift$version_available
#> [1] "avsift"
#> 
#> $db_annovar_avsift$version_newest
#> [1] "avsift"
#> 
#> 
#> $db_annovar_avsnp
#> $db_annovar_avsnp$buildver_available
#> $db_annovar_avsnp$buildver_available$avsnp138
#> [1] "hg19"
#> 
#> $db_annovar_avsnp$buildver_available$avsnp142
#> [1] "hg38" "hg19"
#> 
#> $db_annovar_avsnp$buildver_available$avsnp144
#> [1] "hg38" "hg19"
#> 
#> $db_annovar_avsnp$buildver_available$avsnp147
#> [1] "hg38" "hg19"
#> 
#> $db_annovar_avsnp$buildver_available$avsnp150
#> [1] "hg38" "hg19"
#> 
#> 
#> $db_annovar_avsnp$decompress
#> [1] TRUE TRUE
#> 
#> $db_annovar_avsnp$description
#> $db_annovar_avsnp$description$avsnp138
#> [1] "dbSNP138 with allelic splitting and left-normalization"
#> 
#> $db_annovar_avsnp$description$avsnp142
#> [1] "dbSNP142 with allelic splitting and left-normalization"
#> 
#> $db_annovar_avsnp$description$avsnp144
#> [1] "dbSNP144 with allelic splitting and left-normalization (http://annovar.openbioinformatics.org/en/latest/articles/dbSNP/#additional-discussions)"
#> 
#> $db_annovar_avsnp$description$avsnp147
#> [1] "dbSNP147 with allelic splitting and left-normalization"
#> 
#> 
#> $db_annovar_avsnp$source_url
#> [1] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.gz"    
#> [2] "http://www.openbioinformatics.org/annovar/download/{{buildver}}_{{version}}.txt.idx.gz"
#> 
#> $db_annovar_avsnp$version_available
#> [1] "avsnp150" "avsnp147" "avsnp144" "avsnp142" "avsnp138"
#> 
#> $db_annovar_avsnp$version_newest
#> [1] "avsnp150"
#> 
#> 
#> $db_annovar_avsnp_sqlite
#> $db_annovar_avsnp_sqlite$buildver_available
#> [1] "hg19"
#> 
#> $db_annovar_avsnp_sqlite$install
#> [1] "#R#sql2sqlite('{{buildver}}_{{version}}.sqlite.sql', sqlite.path = '{{buildver}}_{{version}}.sqlite')#R#"
#> 
#> $db_annovar_avsnp_sqlite$source_url
#> [1] "http://bioinfo.rjh.com.cn/download/annovarR/humandb/{{buildver}}_{{version}}.sqlite.sql.gz"
#> 
#> $db_annovar_avsnp_sqlite$version_available
#> [1] "avsnp147"        "avsnp147.common" "avsnp144"       
#> [4] "avsnp142"        "avsnp138"       
#> 
#> $db_annovar_avsnp_sqlite$version_newest
#> [1] "avsnp147"
#> 
#> 
#> $title
#> [1] "TOML Example"
```

## Converting and writing configuration file

`convert.config` will read a configuration file and write a configuration file with appointed file type (json. ini, yaml). Moreover, `write.config` is similar to `convert.config` but using the list object rather than a file.


```r
# Convert YAML configuration file to JSON format
out.json <- tempfile(, fileext = ".json")
convert.config(file = config.yaml, out.file = out.json, convert.to = "JSON")
#> [1] TRUE
get.config.type(out.json)
#> [1] "json"

# Generate a JSON format configuration file
list.test <- list(a = c(123, 456))
out.fn <- sprintf("%s/test.json", tempdir())
write.config(config.dat = list.test, file.path = out.fn, write.type = "json")
#> [1] TRUE
get.config.type(out.fn)
#> [1] "json"

# Generate a YAML format configuration file with defined
# indent
write.config(config.dat = list.test, file.path = out.fn, write.type = "yaml", 
  indent = 4)
#> [1] TRUE
get.config.type(out.fn)
#> [1] "yaml"

# Generate a YAML format configuration file with defined
# indent and pointed sections write.config(config.dat =
# list.test, file.path = out.fn, write.type = 'yaml',
# sections = 'a', indent = 4) get.config.type(out.fn)
```

## Configr specific extra parse

configr own several userful extra parse function, you can use the `parse.extra` to finish these work for any list object. Of course, `read.config`, `eval.config` and `eval.config.merge` can directly using `parse.extra` by passing parameters to `parse.extra`.

- `extra.list` can be used to parse the value of `{{debug}}` to `self` if you setted `extra.list = list(debug = 'self')`
- `other.config` can be used to parse the value of `{{key:yes_flag}}` to `yes` if you setted `other.config = system.file('extdata', 'config.other.yaml', package='configr')` which content can be founded below.
- `rcmd.parse` can be used to parse the value of `@>@str_replace('config','g$','gr')@<@` to `configr` if you setted `rcmd.parse = TRUE`.
- `bash.parse` can be used to parse the value of `#>#echo bash#<#` to `bash` if you setted `bash.parse = TRUE`.
- `glue.parse` can be used to paste the value of `!!glue {1:5}` to `["1", "2", "3", "4", "5"]`; `!!glue_numeric {1:5}` to [1, 2, 3, 4, 5] 

**Note:** `glue.parse` using the `glue` package `glue` function to do that. Just like glue('{1:5}') and be processed by unname(unlist(x)). 
The `!!glue` can be changed if you setted `glue.flag`. It is a remarkable fact that only contain the `glue.flag` character be parsed and the order of item will be changed if the `glue` result were multiple values. e.g. `['{a}', '!!glue {1:5}', '{{a}}']` will be parsed to `['{a}', '1', '2', '3', '4', '5', '{{a}}']`


```r
other.config <- system.file("extdata", "config.other.yaml", package = "configr")

read.config(file = other.config)
#> $key
#> $key$test_parse
#> [1] 123
#> 
#> $key$test_parse2
#> [1] 234
#> 
#> $key$yes_flag
#> [1] "yes"
#> 
#> $key$no_flag
#> [1] "no"
#> 
#> 
#> $`samtools@1.3.1`
#> $`samtools@1.3.1`$source_dir
#> [1] "/tmp"

config.1 <- read.config(file = config.json)
config.1$default
#> $debug
#> [1] "{{debug}} {{debug2}}"
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"))$default
#> $debug
#> [1] "self self2"

sections <- c("default", "other_config_parse")
config.1[sections]
#> $default
#> $default$debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "{{key:yes_flag}} {{key:no_flag}}"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"), other.config = other.config)[sections]
#> $default
#> $default$debug
#> [1] "self self2"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "yes no"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"

sections <- c("default", "other_config_parse", "rcmd_parse")
# The followed two line command will return the same value
config.1[sections]
#> $default
#> $default$debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "{{key:yes_flag}} {{key:no_flag}}"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
#> 
#> 
#> $rcmd_parse
#> $rcmd_parse$raw
#> [1] "@>@ Sys.Date() @<@"
read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"), other.config = other.config, rcmd.parse = T)[sections]
#> $default
#> $default$debug
#> [1] "self self2"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "yes no"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
#> 
#> 
#> $rcmd_parse
#> $rcmd_parse$raw
#> [1] "2017-11-22"
parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2"), 
  other.config = other.config, rcmd.parse = T)[sections]
#> $default
#> $default$debug
#> [1] "self self2"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "yes no"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
#> 
#> 
#> $rcmd_parse
#> $rcmd_parse$raw
#> [1] "2017-11-22"


sections <- c("default", "other_config_parse", "rcmd_parse", 
  "mulitple_parse")
config.1[sections]
#> $default
#> $default$debug
#> [1] "{{debug}} {{debug2}}"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "{{key:yes_flag}} {{key:no_flag}}"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
#> 
#> 
#> $rcmd_parse
#> $rcmd_parse$raw
#> [1] "@>@ Sys.Date() @<@"
#> 
#> 
#> $mulitple_parse
#> $mulitple_parse$raw
#> [1] "@>@str_replace('config','g$','gr')@<@, #>#echo configr#<#, {{key:yes_flag}}, {{yes}}, @>@str_replace('configr','r','')@<@, #># echo config#<#, {{key:no_flag}}, {{no}}"
#> 
#> $mulitple_parse$parsed
#> [1] "configr, configr, yes, 1, config, config, no, 0"
parse.extra(config.1, extra.list = list(debug = "self", debug2 = "self2", 
  yes = "1", no = "0"), other.config = other.config, rcmd.parse = T, 
  bash.parse = T)[sections]
#> $default
#> $default$debug
#> [1] "self self2"
#> 
#> 
#> $other_config_parse
#> $other_config_parse$raw
#> [1] "yes no"
#> 
#> $other_config_parse$parsed
#> [1] "yes no"
#> 
#> 
#> $rcmd_parse
#> $rcmd_parse$raw
#> [1] "2017-11-22"
#> 
#> 
#> $mulitple_parse
#> $mulitple_parse$raw
#> [1] "configr, configr, yes, 1, config, config, no, 0"
#> 
#> $mulitple_parse$parsed
#> [1] "configr, configr, yes, 1, config, config, no, 0"

# glue parse
raw <- c("a", "!!glue{1:5}", "c")
list.raw <- list(glue = raw, nochange = 1:10)
list.raw
#> $glue
#> [1] "a"           "!!glue{1:5}" "c"          
#> 
#> $nochange
#>  [1]  1  2  3  4  5  6  7  8  9 10
expect.parsed.1 <- c("a", "1", "2", "3", "4", "5", "c")
expect.parsed.2 <- list(glue = expect.parsed.1, nochange = 1:10)
parse.extra(list.raw, glue.parse = TRUE, glue.flag = "!!glue")
#> $glue
#> [1] "a" "1" "2" "3" "4" "5" "c"
#> 
#> $nochange
#>  [1]  1  2  3  4  5  6  7  8  9 10
```

## Others
`config.section.del` can be used to delete a section of config, just do `config$section <- NULL`.


```r
config <- read.config(file = config.json, extra.list = list(debug = "self", 
  debug2 = "self2"), other.config = other.config)[sections]
names(config)
#> [1] "default"            "other_config_parse"
#> [3] "rcmd_parse"         "mulitple_parse"
config <- config.sections.del(config, "default")
names(config)
#> [1] "other_config_parse" "rcmd_parse"        
#> [3] "mulitple_parse"
```
