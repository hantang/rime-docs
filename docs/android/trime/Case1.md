---
source: rime-trime-wiki/五笔双键配置案例详解(一)-准备篇.md
title: (一)-准备篇
---

## 五笔双键配置案例详解(一) 准备篇
 
这是我认识同文和小狼毫以来，配置的第一个输入方案。感谢全程有@xiaoqun2016和@osfans老大的细致而耐心的指导。
记下整个过程，方便后来者学习。
通过本案例，你可以学到：
- 小狼毫的一般配置和调试流程
- 小狼毫模糊音的使用
- 同文键盘的配置和对已有键盘布局的修改
- 键盘的切换
 
 
### 一般的调试流程
"工欲善其事，必先利其器"。搭建好下开发环境，使用良好的配置工具，做事可以事半功倍。
 
#### 文本编辑器
我使用的是gVim，在Windows下。
Vim编辑yaml文件有很多好处:
- Vim自带了yaml文件的语法高亮，方便查看
- 小狼毫自带的yaml文件开头都配有vim的modeline行，会自动设置好缩进等相关选项，方便编辑
- Vim本身也很强大，使用范围广，教程多，而且开源免费
 
#### 调试流程
1. 将你要反复修改或者反复打patch修改的yaml文件复制一份，放到你的工作目录(这样防止修改错了需要回厂)
2. 在工作目录创建XX.custom.yaml文件(如果已有就不要创建了) -- 建议不要在原文件上修改,而是通过打patch方法修改
3. 有两个批处理脚本如下,你可以直接复制过去使用
 
```bash
:: rime.bat
copy wubi86_double_key.schema.yaml %appdata%\rime
copy wubi86.dict.yaml %appdata%\rime

start WeaselDeployer.exe /deploy   ::重要的是这句，需要将小狼毫的安装目录添加到path环境变量中

rem 或者写成这样
rem "C:\Program Files\Rime\weasel-0.9.14\WeaselDeployer.exe" /deploy
pause
```
如果是在手机上调试同文输入法，则使用下面的:
 
```bash
:: trime.bat
adb push trime.yaml /sdcard/rime
adb push trime.custom.yaml /sdcard/rime
adb push wubi86_double_key.schema.yaml /sdcard/rime
adb shell am broadcast -a com.osfans.trime.deploy
pause
```
 
这样做的好处，就是每次修改，都相当于把系统文件恢复到你打patch之前的状态，你打patch造成的错误不会累积。
 
 
### 定制输入方案

我要实现的键盘效果如下所示:

![五笔双键](https://camo.githubusercontent.com/01fb5abfd965c718657763629f695be8aa33ef6e/687474703a2f2f696d672e626c6f672e6373646e2e6e65742f3230313630353031313132393337393336)

实现效果类似九宫格，但是因为一个键上只有两个键同时又保留了电脑上的键盘布局。所以，保留了五笔的输入模式。

大致的步骤是（这也是本系列文章的标题）:

1. 先复制wubi86的输入法方案,实现自己的方案
2. 添加模糊音，实现双键方案
3. 对双键方案进行调整完善（码表共享和词频调整）
4. 在手机上定义双键键盘，实现中文输入
5. 定义键盘切换，实现英文输入
6. 对输入方案优化　（符号选2-3候选字等等）

1－3都是在电脑的小狼毫进行调试，4－6则是在手机的同文输入法上进行调试。