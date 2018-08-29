---
title: 使用Webhook自动更新博客
author: Jianfeng Li
date: '2017-07-25'
slug: nodejs-auto-deploy-blog
categories:
  - tutorial
tags:
  - blog
  - guide
  - nodejs
---

# Node.js 简介

<div align="center">
  <img src="https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-07-25-auto-deploy-nodejs-first/nodejs.jpg">
</div>

> Node.js 是一个基于 Chrome V8 引擎的 JavaScript 运行环境； Node.js 使用了一个事件驱动、非阻塞式 I/O 的模型，使其轻量又高效； Node.js 的包管理器 npm，是全球最大的开源库生态系统 ---- Node.js 中文网

[Node.js](https://nodejs.org/en/) 在我的第一印象里就是一个类似于PHP、JAVA等在网页后台工作的'语言'，事实上它是使用前端使用最高频的语言JavaScript构建的。

让我比较诧异的是，一些桌面应用也有用到Node.js，比如我现在正在用的[Atom](https://atom.io/)编辑器。

## 目的

前几日，使用[益辉](https://github.com/yihui)写的[blogdown](https://github.com/rstudio/blogdown)搭建了我的[博客](http://www.life2cloud.com)。本身这个博客服务可以自动检测文章更改并重新渲染网页，由于我总是在Windows下完成各类文章类工作，而网页服务托管在我们实验室的网页服务器上，所以更新文章总是比较麻烦。

所以，我打算通过使用[Github](http://github.com)的Webhook来监听Push事件，从而自动更新博客。无意中找到了Node.js的实现，看上去也很简洁，所以就写了这篇博文，主要是简单介绍一下如何使用Node.js接收Github的Webhook并完成远程网页服务的自动部署。

## Node.js 以及依赖包的安装

以下内容为部署Node.js及依赖包（[coding-webhook-handler](https://www.npmjs.com/package/coding-webhook-handler)）所用代码

Node.js主要的安装包可以在[Downlad Page](https://nodejs.org/en/download/)找到，支持Windows、Linux、Mac OS。

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
git br -D develop
git pull
git ch develop
git pull
```

我的更新命令很简单，这是因为[blogdown](https://github.com/rstudio/blogdown)本身支持动态监测网页内容更新状况。所以，我只需要更新代码就可以了: `git pull`。

当然，在部署过程中还需要做一些端口转发工作，比如将监听的端口映射到网页路径上去，我推荐用nginx服务，下面是实例的配置文件 `/etc/nginx/conf.d/your_blog.conf`。另外，需要保证`include /etc/nginx/conf.d/*.conf;`存在于`/etc/nginx/nginx.conf`文件中。

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
