---
title: Shiny进阶教程之shinyjs与Codemirror搭配使用美化编辑器
author: Jianfeng Li
date: '2018-08-02'
slug: shiny-shinyjs-mirrorcode
categories:
  - tutorial
tags:
  - shiny
  - shinyjs
  - codemirror
---

## 简介

这是我准备的关于R语言网页编程框架[Shiny](http://shiny.rstudio.com/)进阶教程的第一篇，主要讲一下如何使用[shinyjs](https://CRAN.R-project.org/package=shinyjs)和[codemirror](https://codemirror.net/)来美化你的代码编辑器。Shiny的一些基本的语法和概念我就不单独写了，Rstudio官方教程讲的非常详实。

这篇教程主要为了解决一个问题：如何使用shinyjs与Codemirror美化我们的编辑器？

## 组件基本介绍

[shinyjs](https://CRAN.R-project.org/package=shinyjs)是一个R包，它可以帮助用户在R里面方便的执行Javascript以及CSS操作。因为大部分用R用户学Shiny可能都没有网页基础知识，但是为了开发相对复杂一些的网页应用，基本的HTML/Javascript/CSS知识还是必备的，基本看完然后动手做完[菜鸟教程](http://www.runoob.com/)的练习也就暂时可以了，这样在你想修改和新增某些新功能时可以有的放矢，遇到问题时也能大概知道解决方案。

> Easily Improve the User Experience of Your Shiny Apps in Seconds --- from CRAN

[Codemirror](https://codemirror.net/)是一个代码编辑器的Javascript/Css库，官方下载包点击[这里](https://codemirror.net/codemirror.zip)。

## 主要需求以及遇到的问题

需求：我想将一个`shiny::textAreaInput`变成一个可以显示行号和代码高亮的编辑器。
问题：shiny的input输入值无法动态捕获使用Codemirror插件之后的输入框的值

## 解决方案

使用如下代码解决：

YAML主题的Codemirror的Javascript启动代码：

```r
# yourid is your shiny::textAreainput setted id
text_area_js <- "<script type='text/javascript'>var yourid_editor = CodeMirror.fromTextArea(yourid, {
    lineNumbers: true,
    keyMap: 'sublime',
    theme:'monokai',
    indentUnit: 2,
    gutters: ['CodeMirror-linenumbers', 'CodeMirror-foldgutter'],
    mode: 'yaml'
  });</script>"
```

前端添加和绑定Javascript方法：

```r
# ui.R
set_extend_shinyjs <- function (id) {
  js_code <- sprintf('shinyjs.get_%s_input = function(params) {
      var input_value = %s_editor.getValue();
  Shiny.onInputChange("%s_input_value", input_value);
}', id, id, id)
}
yourid_js_code <- set_extend_shinyjs("yourid")
body <- dashboardBody(
  shinyjs::useShinyjs(),
  extendShinyjs(text = yourid_js_code, functions = sprintf("get_%s_input", yourid))
)
```
`id_editor`是启动之后的Codemirrorr对象（不是原来的shiny::textAreaInput生成的对象），getValue是它的一个方法用于获取目前输入框内的值，这段JS代码可以让我们绑定一个shinyjs的函数（可以在R中调用的）去获取前端的值，这个不仅仅适用于Codemirrorr，也适合其他JS对象。

如果你想批量添加，你可以把多个`extendShinyjs`存入一个R `list`对象输入`dashboardBody`。

```r
extend_js_objs <- list()
for(id in ids){
  json_code <- set_extend_shinyjs(id)
  extend_js_objs <- config.list.merge(
    extend_js_objs, list(extendShinyjs(text = json_code, functions = sprintf("get_%s_input", id))))
}
body <- dashboardBody(
  shinyjs::useShinyjs(),
  extend_js_objs
)
```

服务器后端接收输入值：

```r
observe({
  # replace yourid to yours!
  js$get_yourid_input();
  # featch the value
  print(input$yourid_input_value)
})
```
上面的代码可以让我们动态获取前端美化后的输入框的值。

![](https://raw.githubusercontent.com/Miachol/ftp/master/files/images/bioinstaller/overview5.jpg)
