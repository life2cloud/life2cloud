---
title: '多服务器无限跳板: mmh + pgyvpn'
author: Jianfeng Li
date: '2018-11-29'
slug: mmh-pgyvpn
categories: []
tags: 
  - ssh
  - mmh
  - pgyvpn
---

## 核心需求

- 需要连接实验室或者公司内网服务器
- 需要在多服务器之间拷贝一些小文件（包括没有公网IP的内网服务器）
- 需要同时在多台服务器（比如分散在华为云、实验室内网、国外服务器等）运行相同命令获取输出

## 工具搭配

- [mmh](https://github.com/mritd/mmh)
- [pgyvpn](https://pgy.oray.com/download/)：支持Linux, Mac, Windows, Android, IOS 

## mmh 示例配置文件

```yaml
# 最大跳板机数量
maxProxy: 5

# 默认配置
basic:
  user: root
  port: 22
  password:
  privatekey: "/Users/mritd/.ssh/id_rsa"
  privatekey_password: ""

# 服务器配置
servers:
- name: d24
  tags:
  - doh
  user: root
  privatekey: "/Users/mritd/.ssh/id_rsa"
  privatekey_password: ""
  address: 172.16.0.24
  port: 22
  proxy: "d33"
- name: d33
  tags:
  - doh
  - k8s
  user: root
  password: "password"
  address: 172.16.0.33
  port: 22

# tags
tags:
  - doh
  - k8s
```

## mmh 官方示例操作

![](https://raw.githubusercontent.com/mritd/mmh/master/img/mmh.gif)

![](https://raw.githubusercontent.com/mritd/mmh/master/img/mec.gif)

## mmh 多主机管理示例

连接一台服务器可以有无数种路径：

- A（本机） > B（局域网）
- A（本机） > B（局域网）> C（公网IP）
- A（本机） > B（公网IP）> C（内网）
- A（本机） > B（pgyvpn）> C（内网）
- A（本机） > B（pgyvpn）> C（内网）> D（内网）
- A（本机） > B（pgyvpn）> C（内网）> D（内网）> E（公网IP）

目前，我是给自己控制的同一台主机按连接方式，分为\_1、\_2、\_3等，这样我可以自由选择想要的路径去连接目标主机。如果其中某条连接路径中断时，仍然可以通过其他连接路径来访问服务器。不过，同时对很多台主机增加连接方式，自然会增加你的维护配置文件的工作量（如下面的rj_nd1-rj_nd8）。

另外，通过按主机、连接方式、服务器功能组等指标指定标签，可以方便你批量进行命令行操作。

```bash
Name          User          Tags          Address
-------------------------------------------------------------
pi_sjtu2_1    \*     pi_1          \*:22
pi_sjtu2_2    \*     pi_2          \*:22
pi_sjtu2_3    \*     pi_3          \*:22
pi_sjtu2_4    \*     pi_4          \*:22
pub_al_zhl    \*           blog          \*:22
pub_tc_biotr  \*          btr           \*:22
rj_m1         \*           m1            \*:22
rj_nd1_1      \*           rj_hpc_1      \*:22
rj_nd1_2      \*           rj_hpc_2      \*:22
rj_nd1_3      \*           rj_hpc_3      \*:22
rj_nd1_4      \*           rj_hpc_4      \*:22
rj_nd5_1      \*           rj_hpc_1      \*:22
rj_nd5_2      \*           rj_hpc_2      \*:22
rj_nd5_3      \*           rj_hpc_3      \*:22
rj_nd5_4      \*           rj_hpc_4      \*:22
rj_nd6_1      \*           rj_hpc_1      \*:22
rj_nd6_2      \*           rj_hpc_2      \*:22
rj_nd6_3      \*           rj_hpc_3      \*:22
rj_nd6_4      \*           rj_hpc_4      \*:22
rj_nd7_1      \*           rj_hpc_1      \*:22
rj_nd7_2      \*           rj_hpc_2      \*:22
rj_nd7_3      \*           rj_hpc_3      \*:22
rj_nd7_4      \*           rj_hpc_4      \*:22
rj_nd8_1      \*           rj_hpc_1      \*:22
rj_nd8_2      \*           rj_hpc_2      \*:22
rj_nd8_3      \*           rj_hpc_3      \*:22
rj_nd8_4      \*           rj_hpc_4      \*:22
rj_sihweb_1   \*           sihweb_1      \*:22
rj_sihweb_2   \*           sihweb_2      \*:22
rj_sihweb_3   \*           sihweb_3      \*:22
rj_sihweb_4   \*           sihweb_4      \*:22
rj_web        \*           rj_web        \*:22
```
## pgyvpn 命令行版界面

只需要内网中的一台服务器（linux/windows/mac均可）登陆pgyvpn，就可以使用mmh一键跳转到任意该内网服务器可以连接的服务器（包括二次甚至三次跳转等）。

同时，通过在内网运行几个pgyvpn服务，也可以避免因其中一台服务器网络中断而无法正常连接内网其他服务器。

```bash
================= 上海贝锐(Oray) =================
                蒲公英VPN (Linux)
                    Ver 2.1.0
==================================================
登录中........
登录成功！
~~~~~~~~~~~~~~~~~~~请输入以下指令~~~~~~~~~~~~~~~~~
1,getmbrs:      获取组成员信息
2,bypass:       查看旁路路由
3,chgacnt:      更换帐号
4,showsets:     查看所有设置
5,prtinfo:      显示实时信息（组成员变动）
6,noinfo:       不显示实时信息
7,slang:        切换语言(change language)
8,qservice:     退出并关闭VPN服务
9,quit:         退出VPN界面
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---------------------VPN组信息--------------------

VPN组名称:xxx的网络

---------------------组成员信息-------------------
*********************在线成员*********************

(蒲公英VPN)名称:        demo
虚拟IP地址:             172.**.**.***
```

## mmh + pgyvpn 该方案解决的主要痛点

- 可以一键同时操作没有公网IP的内网服务器、公网服务器
- 一条命令即可操作多台需要/不需要多层SSH连接的目标服务器
