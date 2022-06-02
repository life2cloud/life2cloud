---
title: "Write Your Own Configuration File (BioInstaller)"
author: "Jianfeng Li"
date: "2018-08-13"
categories:
  - tutorial
tags:
  - BioInstaller
---



Configuration files in BioInstaller are important. We used these configuration files to stored the software and databases URL, the script of installation, and other useful information.

Most of the configuration files are parsed by [configr](https://github.com/Miachol/configr). Compared with original configr package syntax `#R# R CMD #R#` is a different point. It can be used to mark those R format command.

## github.toml, nongithub.toml and db.toml

Built-in configuration files: `github.toml`, `nongithub.toml` and `db.toml (db_annovar.toml/db_main.toml, nongithub.toml format)` can be used to download and install several software and database. `install.bioinfo(show.all.names = TRUE)` can be used to get all of avaliable softwares and databases existed in github.toml and nongithub.toml.

### Softwares and databases deposited on Github 

Variables to control the download and installation steps of software and databases deposited on github:

- If you set `use_git2r` to `false`, BioInstaller will use the [git](https://en.wikipedia.org/wiki/Git) of your system.
- If you set `use_git2r` to `false` and setted `recursive_clone` to `true`, BioInstaller will run this command `git clone --recursive https://path/repo`
- You can use the `before_install` stored the pre-installation steps
- The `install` mainly be used to store the installation steps. Besides, you can use your own installation script and setted it to `#R# system('/path/yourscript')#R#`
- The `make_dir` is the compile directory of software and database. Because the workdir of R default will be set to `download.dir`, and need be changed to `make_dir` finish `install` steps.

```toml
[bwa]
github_url = "https://github.com/lh3/bwa"
after_failure = "echo 'fail!'"
after_success = "echo 'successful!'"
make_dir = ["./"]
bin_dir = ["./"]

[bwa.before_install]
linux = ""
mac = ""

[bwa.install]
linux = "make"
mac = "make"
```

Github software version control can be done by `git2r` package and github tag [API](https://developer.github.com/v3). Source URL of software or files deposited in github can be found by `github_url` in `github.toml`.

### Softwares and databases of non-github

Variables to control the download and installation steps of software and databases not be deposited on github:

- `github_url` be replaced by `source_url`
- If you want to download multiple files in the source_url, you need to set `url_all_download` to `true`.
- [rvest](https://cran.r-project.org/package=rvest) and [RCurl](https://cran.r-project.org/package=RCurl) packages can be used to parse the version information of software or databases of non-github.
- If you don't want to use the built-in version reorder function, you need to set `version_order_fixed` to `true`. Optional, if the file count of source code was only one, you can set `url_all_download` to `false` and writing multiple URL. It will help you to avoid the invalid URL caused download fail.

```toml
[gmap]
# {{version}} will be parsed to your install.bioinfo `version` parameter
# or the newest version parsed from fetched data.
source_url = "http://research-pub.gene.com/gmap/src/{{version}}.tar.gz"
after_failure = "echo 'fail!'"
after_success = "echo 'successful!'"
make_dir = ["./"]
bin_dir = ["./"]

[gmap.before_install]
linux = ""
mac = ""

[gmap.install]
linux = "./configure --prefix=`pwd` && make && make install"
mac = ["sed -i s/\"## CFLAGS='-O3 -m64' .*\"/\"CFLAGS='-O3 -m64'\"/ config.site",
"./configure --prefix=`pwd` && make && make install"]
```

Version control of non-github software and databases need a function parsing URL and use `{{version}}` to replace in the `source_url`.

Besides, BioInstaller uses [configr](https://github.com/Miachol/configr) `glue` to reduce the length of files name. It can help you to use less word to store more files name.


```r
library(configr)
library(BioInstaller)
blast.databases <- system.file("extdata", "config/db/db_blast.toml", 
  package = "BioInstaller")

read.config(blast.databases)$db_blast_nr$source_url
#> [1] "!!glue ftp://ftp.ncbi.nih.gov/blast/db/nr.{ids=sprintf('%02d', 0:68);rep(ids, 2)}.tar.gz{c(rep('', length(ids)), rep('.md5', length(ids)))}"
x <- read.config(blast.databases, glue.parse = TRUE)$db_blast_nr$source_url
length(x)
#> [1] 138
head(x)
#> [1] "ftp://ftp.ncbi.nih.gov/blast/db/nr.00.tar.gz"
#> [2] "ftp://ftp.ncbi.nih.gov/blast/db/nr.01.tar.gz"
#> [3] "ftp://ftp.ncbi.nih.gov/blast/db/nr.02.tar.gz"
#> [4] "ftp://ftp.ncbi.nih.gov/blast/db/nr.03.tar.gz"
#> [5] "ftp://ftp.ncbi.nih.gov/blast/db/nr.04.tar.gz"
#> [6] "ftp://ftp.ncbi.nih.gov/blast/db/nr.05.tar.gz"
mask.github <- tempfile()
file.create(mask.github)
#> [1] TRUE
install.bioinfo(nongithub.cfg = blast.databases, github.cfg = mask.github, 
  show.all.names = TRUE)
#> Warning in fetch.config(github.cfg): Configuration file /
#> var/folders/nc/yl5qhkkn6vxf_m7s_yz2kzvh0000gn/T//RtmpScC4De/
#> file452022b0ef38 is empty, please check the links.
#>  [1] "db_blast_env_nr"                 
#>  [2] "db_blast_est_human"              
#>  [3] "db_blast_est_mouse"              
#>  [4] "db_blast_est_others"             
#>  [5] "db_blast_gss"                    
#>  [6] "db_blast_htgs"                   
#>  [7] "db_blast_human_genomic"          
#>  [8] "db_blast_landmark"               
#>  [9] "db_blast_mouse_genomic"          
#> [10] "db_blast_nr"                     
#> [11] "db_blast_nt"                     
#> [12] "db_blast_other_genomic"          
#> [13] "db_blast_pataa"                  
#> [14] "db_blast_patnt"                  
#> [15] "db_blast_pdbaa"                  
#> [16] "db_blast_pdbnt"                  
#> [17] "db_blast_ref_prok_rep_genomes"   
#> [18] "db_blast_ref_viroids_rep_genomes"
#> [19] "db_blast_ref_viruses_rep_genomes"
#> [20] "db_blast_refseq_genomic"         
#> [21] "db_blast_refseq_protein"         
#> [22] "db_blast_refseq_rna"             
#> [23] "db_blast_refseqgene"             
#> [24] "db_blast_sts"                    
#> [25] "db_blast_swissprot"              
#> [26] "db_blast_taxdb"                  
#> [27] "db_blast_tsa_nr"                 
#> [28] "db_blast_tsa_nt"                 
#> [29] "db_blast_vector"
```

## Reading from BIO_SOFTWARES_DB_ACTIVE database

To resolve some software dependence, BioInstaller using the `{{key:value}}` format expression, and get its value from B`BIO_SOFWARES_DB_ACTIVE` database.

For example, `htslib` is the dependence of Pindel, and we use `./INSTALL {{htslib:source.dir}}` as the install step of Pindel. In the session of R, the value of `{{htslib:source.dir}}` will be replaced by the real value stored in `BIO_SOFTWARES_DB_ACTIVE` or `db` in `install.bioinfo` function.

## Parsing from `install.bioinfo` parameter `extra.list`

To improve the flexibility of configuration templet, BioInstall using the `{{parameters}}` format expression to get the function `install.bioinfo` parameter `extra.list`. Noteably,  the `name`, `version`, `os.version`, `destdir` were default pass to `extra.list`.

For example, source_url of `GMAP` need the `version` value, and we use `source_url = "http://research-pub.gene.com/gmap/src/{{version}}.tar.gz"` as the download URL. In the session of R, the `{{version}}` will be replaced by the `version` parameter value of `install.bioinfo` (if the version were `NULL`, it will be set to be the newest version).

## More operation of configuration file

[configr](https://github.com/Miachol/configr) was another package to parse the configuration file. More examples can be found in [here](https://github.com/Miachol/configr).
