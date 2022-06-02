---
title: 浅谈Docker的使用
author: Jianfeng Li
date: '2017-07-25'
slug: talk-with-docker
categories:
  - tutorial
tags:
  - docker
---


## Docker与生物信息学

<div align=center>
<img src= https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-25-talk-with-docker/docker.jpg>
</div>

Docker是近年来新起的一种应用（计算机）分发工具，它极大的方便了人们获取、构建、发布软件应用。

在生物信息学领域，很重要的一环就是开发用于数据分析的工具或软件包。在没有Docker之前，人们总是要对各类软件的错综复杂的依赖问题头痛不已（事实上[Conda](https://conda.io/docs/intro.html)/[Bioconda](http://bioconda.github.io/)等目前被广泛应用的软件包管理工具总是会出现一些问题）。现在，Docker似乎为生物信息学相关从业人员提供了一个释放自己的途径，我相信在不久的将来，使用Docker进行生物信息学应用、软件的发布将成为共识。

## 目的

作为一名生物信息专业学生，Docker在很早之前就被我列入了必学的项目之一，现在我也逐渐开始将新开发的项目使用Docker进行打包。这篇博文主要目的在于记录一些最常用的一些Docker命令和学习资源，并谈谈我对Docker在生物信息学相关领域上应用的一些看法。

## Docker的常用命令

```bash
docker pull learn/tutorial # 可以跳过直接运行下一步
docker run learn/tutorial echo "hello word"
# 将容器的8080端口映射到宿主机80端口
docker run -p 80:8080 learn/tutorial echo "hello word"

# 在运行容器时将宿主机的/tmp/docker目录挂载到
# 容器的/tmp/docker （数据共享）
mkdir /tmp/docker
docker run -v /tmp/docker:/tmp/docker \
              learn/tutorial echo "hello word"

# 显示所有已经安装的Docker Image
docker images

# 显示所有正在运行的容器
docker ps

# 删除unstaged的image：
docker rmi -f $(docker images -q -f dangling=true)

# 删除停止的容器：
docker rm $(docker ps -a -q)

# 从Dockerfile build 容器：
# cd Docker directory
docker build -t life2cloud/gatk3:3.7-0 .

# 打标签：
docker tag ubuntu:15.10 yours_repo/ubuntu:v3

# Login and push your repo to docker hub
docker login

docker push yours_repo/ubuntu:v3
```
更多Docker的操作以及配置见[官方文档](https://docs.docker.com/engine/userguide/)
## Dockerfile

Dockerfile是一种用于自动化构建Docker Image的配置文件，它可以让其他用户知道自己正在使用的容器是如何构建的，自己有没有可修改或定制的地方。如果，你正在使用的Image是由其他用户通过交互式操作构建的:

```bash
docker run -t -i ubuntu:15.10 /bin/bash
root@0b2616b0e5a8:/# apt update;apt install r-base
docker commit -m "Added r-base" -a "Author" \
                 0b2616b0e5a8 yours_repo/r-base:latest
```

那么你是很难知道容器里做了哪些修改，有没有嵌入恶意代码，所以，我们需要一个文件记录用户所有的操作，并让其他用户可以便于查看或修改 ([详细讲解](https://docs.docker.com/engine/reference/builder/))：

```bash
FROM alpine

MAINTAINER life2cloud lee_jianfeng@sjtu.edu.cn

ENV version 0.7.15

RUN apk add --update --no-cache ncurses \
        && apk add --virtual=deps --update \
        --no-cache  musl-dev zlib-dev make gcc wget\
        && cd /tmp \
        && wget --no-check-certificate \
         https://github.com/lh3/bwa/archive/v${version}.tar.gz \
        && tar xzvf v${version}.tar.gz \
        && cd /tmp/bwa-${version} \
        && sed -i '1i#include <stdint.h>' kthread.c \
        && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.c  \
        && sed -i[.bak] "s/u_int32_t/uint32_t/g" *.h  \
        && make \
        && mv /tmp/bwa-${version}/bwa /usr/bin/ \
        && rm -rf /var/cache/apk/* \
        && rm -rf /tmp/* \
        && apk del deps

ENTRYPOINT ["/usr/bin/bwa"]

```

## Docker的大与小

Docker容器可大可小（alpine似乎正在成为一种最小化构建Docker容器的标准）：

- 用“小”容器够建不需要太多外界依赖数据的各类应用（BWA、SAMtools .etc），这些应用往往在编译或安装之后就可以开始使用；
- 还有一类就是各种大型的网页应用、依赖软件众多的Pipeline，这类软件应用配置起来最为麻烦，或许在一个容器内完成会更加方便（数据库除外）,或者是使用[compose](https://github.com/docker/compose)来进行组合多个容器构建应用。

## Docker的不便之处

- Docker运行需要ROOT权限（以后也一定需要），对于大多数非云计算的高性能计算而言，只能够使用conda等工具完成相应分析环境部署
- Docker容易带来一些额外的存储，如重复的依赖、重复的数据等等。特别地，如果软件开发人员不能够很好的拆分应用到不同容器中，将会带来很多冗余文件，对于硬盘紧张的用户来说可能压力会比较大

## 使用非ROOT用户使用docker

```bash
sudo groupadd docker
sudo gpasswd -a ${USER} docker
# sudo service docker restart
sudo systemctl restart docker
# 退出当前用户，重新登录
```

## Docker的一些常用链接
- [Docker Github](https://github.com/docker)
- [Docker Home](https://www.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Document](https://docs.docker.com/)
- [Moby Project](https://mobyproject.org/)
- [awesome-docker](https://github.com/veggiemonk/awesome-docker): A curated list of Docker resources and projects
- [compose](https://github.com/docker/compose): Define and run multi-container applications with Docker
- [docker菜鸟教程](http://www.runoob.com/docker/docker-tutorial.html)
- [Docker 的应用场景在哪里？](https://www.zhihu.com/question/22969309)
- [非常详细的 Docker 学习笔记](http://blog.csdn.net/zjin_hua/article/details/52041757)
