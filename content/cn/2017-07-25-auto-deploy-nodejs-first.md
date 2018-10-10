---
title: Node.js的一个实例：Webhook服务自动更新博客
author: Jianfeng Li
date: '2017-07-25'
slug: nodejs-auto-deploy-blog
categories:
  - tutorial
tags:
  - blog
  - nodejs
---

# Node.js 简介

<div align="center">
  <img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-25-auto-deploy-nodejs-first/nodejs.jpg">
</div>

> Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境； Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效； Node.js 的包管理器 npm，是全球最大的开源库生态系统 ---- Node.js 中文网

[Node.js](https://nodejs.org/en/) 是目前最火热的网页后台技术之一。它使用[JavaScript](https://en.wikipedia.org/wiki/JavaScript)语言构建，并基于[CommonJS](https://en.wikipedia.org/wiki/CommonJS)规范开发。JavaScript的事件驱动、非阻塞式 I/O 的模型对于我们进行数据分析流程搭建和一些日常数据分析工作都有借鉴作用。如果以后有时间，我可能会尝试用Javascript结合其他一些计算脚本开发一个生物信息学分析工具。R语言的[future](https://github.com/HenrikBengtsson/future)包也为R用户提供了一种并行和分布式处理方案（目前应用可能还不够广泛），如果你感兴趣可以了解一下。

Nodejs诞生历程：

- 2009年3月，Ryan Dahl在其博客上宣布准备基于V8创建一个轻量级的Web服务器并提供一套库。
- 2009年5月，Ryan Dahl在GitHub上发布了最初的版本。
- 2009年12月和2010年4月，两届JSConf大会都安排了Node的讲座。
- 2010年年底，Node获得硅谷云计算服务商Joyent公司的资助，其创始人Ryan Dahl加入Joyent公司全职负责Node的发展。
- 2011年7月，Node在微软的支持下发布了其Windows版本。
- 2011年11月，Node超越Ruby on Rails，成为GitHub上关注度最高的项目（随后被Bootstrap项目超越，目前仍居第二）。
- 2012年1月底，Ryan Dahl在对Node架构设计满意的情况下，将掌门人的身份转交给Isaac Z. Schlueter，自己转向一些研究项目。Isaac Z. - Schlueter是Node的包管理器NPM的作者，之后Node的版本发布和bug修复等工作由他接手。

来源：《深入浅出Node.js》

这篇文章我主要是简单介绍了一下如何使用Node.js接收Github的Webhook并完成远程网页服务的自动部署，关于JavaScript语言和Node.js的详细内容大家可以查阅其他资料。

2017年，我使用[益辉](https://github.com/yihui)的[blogdown](https://github.com/rstudio/blogdown)搭建了我的[博客](https://www.life2cloud.com)。这篇文章主要是为了解决一个问题：在本地MAC系统下完成各类文章类工作，然后自动更新远程网页服务。

解决方案：通过[Github](http://github.com)的Webhook来监听Push事件，同时使用Node.js的Webhook服务监听GitHub发送的信息。

## Node.js 以及依赖包的安装

Node.js主要的安装包可以在[Downlad Page](https://nodejs.org/en/download/)找到，支持Windows、Linux、Mac OS。

以下内容为部署Node.js及依赖包（[coding-webhook-handler](https://www.npmjs.com/package/coding-webhook-handler)）所用代码：

```bash
# 源码安装Node.js
wget https://nodejs.org/dist/v6.11.1/node-v6.11.1.tar.gz
tar -zvxf node-v6.11.1.tar.gz

./configure --prefix=`pwd`
make
make install

# 使用conda安装Node.js
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# sh Miniconda3-latest-Linux-x86_64.sh
conda create -n nodejs python=2.7
source activate nodejs
conda install nodejs
```
在完成Node.js安装后，得到可执行文件`node`和包管理器`npm`，然后就是安装依赖包`github-webhook-handler`用于相关Webhook解析和监控。

特别要注意的是，如果nodejs是以root安装的，可能会导致没有权限安装额外包。

如果是以conda或自己编译安装，需要设置环境变量`NODE_PATH`：

```bash
# ~/.bashrc
export NODE_PATH="~/.miniconda3/lib/node_modules/"
```

```bash
# 国外镜像
npm install -g github-webhook-handler
# 推荐国内镜像
npm install -g cnpm --registry=http://r.cnpmjs.org
cnpm install -g github-webhook-handler
```

在完成上述软件包部署之后你就可以正式开始进行网站Webhook监听和自动部署。

## Node.js 监听Webhook

以下代码为实例， 需要更改的行在后面加上了`//Need Change`标记。

- `your_api_url` 与nginx等转发路径相关
- `your_github_webhook_secret` 与Github的Webhook设置相关
- `your_port` 与nginx中配置的监听端口相关
- `deploy.sh` 与deploy.js在同一路径下，主要用于执行一些更新操作（如果git pull）

```javascript
// deploy.js
var http = require('http')
var createHandler = require('github-webhook-handler')
var handler = createHandler({ path: '/your_api_url/', secret: 'your_github_webhook_secret' }) // Need Change

function run_cmd(cmd, args, callback) {
  var spawn = require('child_process').spawn;
  var child = spawn(cmd, args);
  var resp = "";

  child.stdout.on('data', function(buffer) { resp += buffer.toString(); });
  child.stdout.on('end', function() { callback (resp) });
}

http.createServer(function (req, res) {
  handler(req, res, function (err) {
    res.statusCode = 404
    res.end('no such location')
  })
}).listen(your_port) // Need Change

handler.on('error', function (err) {
  console.error('Error:', err.message)
})

handler.on('push', function (event) {
  console.log('Received a push event for %s to %s',
    event.payload.repository.name,
    event.payload.ref);
    run_cmd('sh', ['./deploy.sh',event.payload.repository.name], function(text){ console.log(text) });
})
```

我将用于网页内容更新的命令存于`deploy.sh`中，当`deploy.js`接收到相应参数后，就会执行下面的脚本，从而完成网页内容更新。当然，你也可以选择其他脚本自己的方式去更新你的网页，只要记得修改`handler.on`中的`run_cmd`的值就可以。

```bash
# deploy.sh
cd ${your_blog_dir}
# Some of Update Command
git ch master
# 为了防止冲突发生，我会现在develop分支开发，为了防止远程仓库被强制更新，
# 我选择切换至早期的commit，然后重新拉下来源码
git reset --hard 4155b2986e02f569a484d3fc8387e6488
git br -D develop
git pull
git ch develop
git pull
```

更新命令很简单，这是因为[blogdown](https://github.com/rstudio/blogdown)本身支持动态监测网页内容更新状况。所以，我只需要更新博客的源代码就可以了: `git pull`。

当然，在部署过程中还需要做一些端口转发工作，比如将监听的端口映射到网页路径上去，我推荐用nginx服务，下面是实例的配置文件 `/etc/nginx/conf.d/your_blog.conf`。另外，需要保证`include /etc/nginx/conf.d/*.conf;`存在于`/etc/nginx/nginx.conf`文件中。

注意：Nginx目前已经将`conf.d`中的文件移动到了`sites-available`，并通过`sites-enabled`目录建立的软连接来启用相应的配置文件。

```bash
upstream your_blog_api {
    server localhost:your_port;
}

server
{
  listen       80;
  server_name  your_domain;
  client_max_body_size 10G;

  location /your_blog_api
  {
    proxy_pass      http://your_blog_api/;
    proxy_redirect          off;
    proxy_set_header        Host $host;
    proxy_set_header        X-Real-IP $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
```

## Github设置Webhook

这部分相关的详细内容可以浏览Github Webhook[官方文档](https://developer.github.com/webhooks/)

Webhook设置页面：https://github.com/username/repo/settings/hooks

<div align="center">
  <img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-25-auto-deploy-nodejs-first/webhook_example.jpg">
</div>

右上角有`Add webhook` 按钮， 点击后填写以下内容：

- `Payload URL` 你的API路径，与上面nginx设置的保持一致
- `Content type` 选择`application/json`
- `Secret`与上面deploy中的保持一致

## 运行Node.js服务
```bash
node deply.js

# 后台运行
# 使用 nohub或screen http://www.gnu.org/software/screen/ 来进行后台作业
`nohub node deploy.js`
```
在完成Node.js服务运行后，我只要提交Commit并Push到Github，网页服务器就可以接收到Github发送的POST请求，然后执行相应的更新博客指令。
