---
title: 日常用到的软件和工具 (文本编辑器)
author: Jianfeng Li
date: '2017-09-26'
slug: daily-tools-text-editor
categories:
  - tutorial
tags:
  - productivity tool

---

## 引言

这一新系列博文主要是想总结并记录一下我日常学习、工作、生活中用到的一些计算机软件或工具，同时系列内容的的每个部分会定期更新，希望这可以给你带来一些帮助。

## 字体与样式

字体和文本样式对文本编辑器非常重要的，下面的几种字体（编程用）是我比较推荐的，写文字和代码一定要选择一个适合你的字体和配色，这会极大的提高你的用户体验：

- [DejaVu Sans Mono](https://dejavu-fonts.github.io/)
- [Source Code Pro](https://github.com/adobe-fonts/source-code-pro/releases)
- [Droid Sans Mono](https://zh.fonts2u.com/droid-sans-mono.%E5%AD%97%E4%BD%93)

配色主题强推：molokai

![molokai](https://camo.githubusercontent.com/6b1c96e698a3e80db6aebd87533dcca85329a4d2/687474703a2f2f7777772e77696e746572646f6d2e636f6d2f7765626c6f672f636f6e74656e742f62696e6172792f57696e646f77734c6976655772697465722f4d6f6c6f6b6169666f7256696d5f383630322f6d6f6c6f6b61695f6f726967696e616c5f736d616c6c5f332e706e67)

## 文本编辑器

### Vim

![Vim](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig1.png)

[VIM](https://en.wikipedia.org/wiki/Vim_(text_editor))是生物信息从业人员必须学会的工具，没有之一，推荐理由我就不多说了，附上我的`~/.vimrc`。

#### Vim 的环境配置

```bash
# INSTALL Vundle, VIM的包管理器
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# 使用 Molokai 配色(前提)
mkdir -p ~/.vim/colors
cd ~/.vim/colors
wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

```

```
filetype plugin on
syntax on
let g:pydiction_location = '~/.vim/tools/pydiction/complete-dict'
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set autoread
set number
set mouse=a
let g:molokai_original = 1

let g:SuperTabDefaultCompletionType="context"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:vim_markdown_frontmatter=1
set selection=exclusive
set selectmode=mouse,key
set cursorline
set ruler

set rtp+=~/.vim/bundle/vundle/
set nocompatible
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'Valloric/YouCompleteMe'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'tpope/vim-pathogen'
Bundle 'cespare/vim-toml'
filetype plugin indent on



nmap <F8> :TagbarToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let g:nerdtree_tabs_open_on_console_startup=0
map <silent> <F2> :NERDTreeToggle<cr>

let g:syntastic_ignore_files=[".*\.py$"]
let NERDTreeShowHidden=1

colorscheme molokai
highlight Comment ctermfg=6 guifg=6

map <C-n> :NERDTree<CR>
map <C-o><C-p> :set mouse-=a<CR>
map <C-o><C-m> :set mouse=a<CR>
let g:miniBufExplMaxSize = 2

let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type="name"

set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteScope = 1
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]"]"
```

### Atom

![ATOM](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig2.png)

[Atom](https://www.atom.io) 是由Github团队开发的现代文本编辑器，它是基于CoffeeScript + Node.js, 运行在[Electron](https://electron.atom.io/)上的跨平台桌面应用，最开始用它，是看它方便的支持插件安装、跨平台、美观、社区活跃、支持Markdown、Git管理、支持自定义CSS修改样式等等。

计算机配置比较好的时候，推荐使用，附带我装的社区支持插件：

- atom-beautify
- atom-bootstrap3
- atom-html-preview
- atom-minify
- atom-ternjs
- autoclose-html
- autocomplete-R
- autocomplete-paths
- busy-signal
- codelf
- color-picker
- docblockr
- emmet
- ever-notedown
- ex-mode
- file-icons
- gist-it
- git-plus
- hyperclick
- intentions
- javascript-snippets
- js-hyperclick
- language-markdown
- language-r
- linter
- linter-eslint
- linter-markdown
- linter-ui-default
- markdown-pdf
- markdown-preview-plus
- markdown-scroll-sync
- markdown-writer
- minimap
- php-hyperclick
- pigments
- project-manager
- r-exec
- relative-numbers
- sync-settings
- tidy-markdown

### Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com/docs) 是微软公司开发的一个开源IDE（伪装成编辑器），性能较Atom有所提升，是目前最受欢迎的文本编辑器之一。

![image https://vip.biotrainee.com/assets/images/1-EqVgaBGCuXDw11ei.png](https://vip.biotrainee.com/assets/images/1-EqVgaBGCuXDw11ei.png)

### RStudio

![RStudio](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig3.png)

[RStudio](https://www.rstudio.com/) 是一个R语言的IDE，确实比较方便，默认就支持`molokai`主题，安装之后记得调整字体、字体大小以及配色。

### Eclipse

![Eclipse](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig4.png)

[Eclipse](https://www.eclipse.org/downloads/) 是一个功能强大的综合IDE，最开始它主要是针对JAVA及其应用开发者，也支持Python、R、PHP等。

### PyCharm

![PyCharm](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig5.png)

[PyCharm](http://www.jetbrains.com/pycharm/) 是一个功能非常强大的Python IDE，如果你的电脑配置比较好的时候（比如有SSD），非常推荐使用。

### Microsoft Word

![Word](https://github.com/Miachol/Writing-material/raw/master/blog/images/2017-09-26-daily-tools-text-editor/fig6.png)

用它主要是因为学术论文写作、各种文字材料的填写，另外它还有几个优势：

- 审阅模式
- 支持Endnote
- 用户使用门槛低（用户数量多）
