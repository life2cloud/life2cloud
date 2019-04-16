---
title: Git Handbook
author: Jianfeng Li
date: '2018-05-06'
slug: git-handbook
categories: 
  - handbook
tags: 
  - git
  - handbook
---

## Git 基本操作指南

### 本地仓库操作

 命令 | 功能 
 --- | --- 
git config –global user.email your_email | 设置git email (必须设置)
git config –global user.name your_name | 设置git name (必须设置)
git init | 将目录变为仓库
git add FILE | 将文件或目录加到缓存区
git commit –m "Description" | 提交更改 并注释做了什么更改
git status | 可以查看当前仓库的状态，是否有变化等
git diff | 查看文件的不同
git diff HEAD~n -- file | 查看和版本库中的同一个文件有什么不同
git reset --hard commit_id | 将工作区恢复到commit_id指定的版本库内的版本
git log | 可以查看提交历史，以便确定要回退到哪个版本
git reflog | 查看命令历史，以便确定要回到未来的哪个版本。
git add | 添加到缓存区
git commit | 提交变更到版本库
git checkout -- file | 可以丢弃工作区的修改（没有-- 就是创建一个分支）
git reset HEAD file | 放弃缓存区的更改
git rm | 然后git commit 删除版本库内的相关文件
git checkout -b dev | 创建并转到新分支dev上
git merge dev | 合并分支
git branch -d dev | 删除分支
git log --graph | 查看合并图
git stash | 可以把当前工作现场“储藏”起来，等以后恢复现场后继续工作：
git stash list | 查看被存起来的工作
git stash pop | 恢复并删除stash藏起来的工作
git tag name | 用于新建一个标签，默认为HEAD，也可以指定一个commit id
git tag -a tagname -m "blablabla..." | 可以指定标签信息；
git tag -s tagname -m "blablabla..." | 可以用PGP签名标签；
git tag | 可以查看所有标签。
git tag -d | 删除一个标签
git rebase HEAD~2 | 合并两个commit

### 远程仓库操作

 命令 | 功能
--- |---
git add remote origin git@host:repo.git | 建立和远程仓库的连接
git push -u origin master | 完成远程仓库的创建
git push origin master | 用来推送最新修改
git clone | 从远程克隆至本机
git remote -v | 查看远程库信息
git push --set-upstream gitname develop | 设置向远程推送的分支
git push origin tagname | 在远程产生一个release版本
git push origin :refs/tags/v0.9 | 远程删除标签

### 便捷及美观设置

| 命令 |
| --- |
|git config --global alias.st status|
|git config --global alias.co checkout|
|git config --global alias.ci commit|
|git config --global alias.br branch|
|git config --global alias.unstage 'reset HEAD'|
|git config --global alias.last 'log -1'|
|git config --global alias.lg "log --color --graph| --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"|

### 设置Shell显示分支名（无外部程序）

将下面内容添加至`~/.bashrc`, 就可以在进入git仓库的目录时显示当前分支名

```bash
function find_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
            if [ -f "$dir/.git/HEAD" ]; then
                    head=$(< "$dir/.git/HEAD")
                    if [[ $head == ref:\ refs/heads/* ]]; then
                            git_branch=" ${head#*/*/}"
                    elif [[ $head != '' ]]; then
                            git_branch=' (detached)'
                    else
                            git_branch=' (unknown)'
                    fi
                    return
            fi
            dir="../$dir"
    done
    git_branch=''
}
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
green=$'\e[1;32m'
magenta=$'\e[1;35m'
normal_colours=$'\e[m'

if ${use_color} ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
            PS1="\[\033[01;31m\]\u\[\033[01;34m\]@\h\W\[$magenta\]\$git_branch\[\033[00m\]\$\[\033[00m\]"
   else
        PS1="\[\033[01;32m\]\u\[\033[01;34m\]@\h\w\[$magenta\]\$git_branch\[\033[00m\]\$\[\033[00m\]"
   fi
else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1='\u\W \$ '
    else
        PS1='\u\w \$ '
    fi
fi
```

### 设置Shell显示分支名（oh-my-zsh）

如果你使用[oh-my-zsh](http://ohmyz.sh/) + agnoster，可以直接得到以下终端样式，默认显示Git分支及其状态信息。

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/blog/images/2018-05-06-notes-git-handbook/fig1.png'>
<br/>
<b>oh-my-zsh + agnoster</b>
</div>


### 参考资料

- [廖雪峰的Git教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/)
- [手把手教你使用Git-博乐在线](http://blog.jobbole.com/78960/)
- [windows下如何github ssh 公钥](http://www.cnblogs.com/igrl/archive/2010/09/17/1829358.html)

## Git flow工作流程

### Git Flow 是什么

Git Flow是构建在Git之上的一个组织软件开发活动的模型，是在Git之上构建的一项软件开发最佳实践。Git Flow是一套使用Git进行源代码管理时的一套行为规范和简化部分Git操作的工具。

2010年5月，在一篇名为“[一种成功的Git分支模型](http://nvie.com/posts/a-successful-git-branching-model/)”的博文中，@nvie介绍了一种在Git之上的软件开发模型。通过利用Git创建和管理分支的能力，为每个分支设定具有特定的含义名称，并将软件生命周期中的各类活动归并到不同的分支上。实现了软件开发过程不同操作的相互隔离。这种软件开发的活动模型被nwie称为“Git Flow”。

一般而言，软件开发模型有常见的瀑布模型、迭代开发模型、以及最近出现的敏捷开发模型等不同的模型。每种模型有各自应用场景。Git Flow重点解决的是由于源代码在开发过程中的各种冲突导致开发活动混乱的问题。因此，Git flow可以很好的于各种现有开发模型相结合使用。

在开始研究Git Flow的具体内容前，下面这张图可以看到模型的全貌（引自nvie的博文)：

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-05-notes-git-handbook/fig1.jpg'>
<br/>
<b>Fig 1</b>
</div>

### Git Flow中的分支

#### 主分支

主分支是所有开发活动的核心分支。所有的开发活动产生的输出物最终都会反映到主分支的代码中。主分支分为master分支和development分支。

##### master分支

master分支上存放的应该是随时可供在生产环境中部署的代码（Production Ready state）。当开发活动告一段落，产生了一份新的可供部署的代码时，master分支上的代码会被更新。同时，每一次更新，最好添加对应的版本号标签（TAG）。

##### develop分支

develop分支是保存当前最新开发成果的分支。通常这个分支上的代码也是可进行每日夜间发布的代码（Nightly build）。因此这个分支有时也可以被称作“integration branch”。

当develop分支上的代码已实现了软件需求说明书中所有的功能，通过了所有的测试后，并且代码已经足够稳定时，就可以将所有的开发成果合并回master分支了。对于master分支上的新提交的代码建议都打上一个新的版本号标签（TAG），供后续代码跟踪使用。

因此，每次将develop分支上的代码合并回master分支时，我们都可以认为一个新的可供在生产环境中部署的版本就产生了。通常而言，“仅在发布新的可供部署的代码时才更新master分支上的代码”是推荐所有人都遵守的行为准则。基于此，理论上说，每当有代码提交到master分支时，我们可以使用Git Hook触发软件自动测试以及生产环境代码的自动更新工作。这些自动化操作将有利于减少新代码发布之后的一些事务性工作。

#### 辅助分支

辅助分支是用于组织解决特定问题的各种软件开发活动的分支。辅助分支主要用于组织软件新功能的并行开发、简化新功能开发代码的跟踪、辅助完成版本发布工作以及对生产代码的缺陷进行紧急修复工作。这些分支与主分支不同，通常只会在有限的时间范围内存在。

辅助分支包括：

- 用于开发新功能时所使用的feature分支；
- 用于辅助版本发布的release分支；
- 用于修正生产代码中的缺陷的hotfix分支。

以上这些分支都有固定的使用目的和分支操作限制。从单纯技术的角度说，这些分支与Git其他分支并没有什么区别，但通过命名，我们定义了使用这些分支的方法。

##### feature分支

使用规范：
- 可以从develop分支发起feature分支
- 代码必须合并回develop分支
- feature分支的命名可以使用除master，develop，release-*，hotfix-*之外的任何名称

feature分支（有时也可以被叫做“topic分支”）通常是在开发一项新的软件功能的时候使用，这个分支上的代码变更最终合并回develop分支或者干脆被抛弃掉（例如实验性且效果不好的代码变更）。

一般而言，feature分支代码可以保存在开发者自己的代码库中而不强制提交到主代码库里。

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-05-notes-git-handbook/fig2.png'>
<br/>
<b>Fig 2</b>
</div>

##### release分支

使用规范：

- 可以从develop分支派生
- 必须合并回develop分支和master分支
- 分支命名惯例：release-*

release分支是为发布新的产品版本而设计的。在这个分支上的代码允许做小的缺陷修正、准备发布版本所需的各项说明信息（版本号、发布时间、编译时间等等）。通过在release分支上进行这些工作可以让
develop分支空闲出来以接受新的feature分支上的代码提交，进入新的软件开发迭代周期。

当develop分支上的代码已经包含了所有即将发布的版本中所计划包含的软件功能，并且已通过所有测试时，我们就可以考虑准备创建release分支了。而所有在当前即将发布的版本之外的业务需求一定要确保不能混到release分支之内（避免由此引入一些不可控的系统缺陷）。

成功的派生了release分支，并被赋予版本号之后，develop分支就可以为“下一个版本”服务了。所谓的“下一个版本”是在当前即将发布的版本之后发布的版本。版本号的命名可以依据项目定义的版本号命名规则进行。

##### hotfix分支

使用规范：

- 可以从master分支派生
- 必须合并回master分支和develop分支
- 分支命名惯例：hotfix-*

除了是计划外创建的以外，hotfix分支与release分支十分相似：都可以产生一个新的可供在生产环境部署的软件版本。

当生产环境中的软件遇到了异常情况或者发现了严重到必须立即修复的软件缺陷的时候，就需要从master分支上指定的TAG版本派生hotfix分支来组织代码的紧急修复工作。

这样做的显而易见的好处是不会打断正在进行的develop分支的开发工作，能够让团队中负责新功能开发的人与负责代码紧急修复的人并行的开展工作。

<div align=center>
<img src='https://github.com/Miachol/Writing-material/raw/master/notes/images/2017-09-05-notes-git-handbook/fig3.png'>
<br/>
<b>Fig 3</b>
</div>

##### 更进一步

Git Flow开发模型从源代码管理角度对通常意义上的软件开发活动进行了约束。应该说，为我们的软件开发提供了一个可供参考的管理模型。Git Flow开发模型让nvie的开发代码仓库保持整洁，让小组各个成员之间的开发相互隔离，能够有效避免处于开发状态中的代码相互影响而导致的效率低下和混乱。

所谓模型，在不同的开发团队，不同的文化，不同的项目背景情况下都有可能需要进行适当的裁剪或扩充。祝各位好运！

PS：为了简化使用Git Flow模型时Git指令的复杂性，nvie开发出了一套[git增强指令集](https://github.com/nvie/gitflow)。可以运行于Windows、Linux、Unix和Mac操作系统之下。有兴趣的同学可以去看看。

转自：

- [基于git的源代码管理模型——git flow](http://www.ituring.com.cn/article/56870)
- [Git工作流指南：Gitflow工作流](http://blog.jobbole.com/76867/)


## Git flow操作指南

### Git flow操作(标准化软件开发流程)

 命令 | 功能
--- |---
cd /git/woyaoquan | 进入克隆仓库
git checkout -b develop origin/develop | 初始化版本流程控制（得到远程服务器develop）
git flow init | 初始化工作目录(一直回车即可)
git flow feature start editimage | 开始创建新的需求分支,目的修改image; 这时项目会自动切换feature/editimage分支
git flow feature finish editimage | 更改部分代码后
git commit -a -m "修改完了"(-a 参数表示提交所有更改了的文件，但是不适用于新创建的文件) | 完成开发分支合并develop(自动)
git push origin develop | 发布到远程开发分支
git flow release start v0.7.0 | 开始进行发布版本的准备工作（develop -> master分支）
git flow release finish v0.7.0 | 进行Merge以及打tag
git push origin master | 将发布版本推送至远程

##### Git flow 紧急BUG流程(1)

 命令 | 功能
--- | ---
git pull origin release/v1.0 | 拉回release版本
git checkout release/v1.0 | 切换分支
git push origin release/v1.0 | 修改BUG
git commit -a -m "修改完BUG,BUG文件+行数" | 修改完后提交

##### Git flow 紧急BUG流程(2)

 命令 | 功能
------------- |-------------
git pull origin master | 更新master分支为最新
git checkout master | 切换到master分支
git flow hotfix start hfx | 生成一个hotfix分支
git pull origin hotfix/hfx | 通知相关得工程师和测试人员hotfix分支名称, 最终测试完成后拉回分支最新代码
git flow hot fix finish hfx | 最终修改和测试完成后，结束hot fix以供发布
git push origin master | 发布最终的master分支
