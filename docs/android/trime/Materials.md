---
source: rime-trime-wiki/Rime经典资料汇总-菜鸟书评.md
title: Rime经典资料汇总
---

关于 Rime 的大多数权威资料都在 Rime 的 wiki 上都可以找得到，还有一些贴吧经典的帖子。

全都列在这里，做一个汇总，顺便大家可以加上一些书评和介绍，方便大家查阅。

另外，网上以前的有些链接都失效的，主要是 Google 相关的，都被墙了，大家注意不要点。

- [Rime 官网](http://rime.im/)
- [Rime 贴吧](http://tieba.baidu.com/f?ie=utf-8&kw=rime&fr=search)


## 致第一次安装 RIME 的你

[:link: 贴吧](http://tieba.baidu.com/p/3288634121?pid=57279455882&cid=89312209915#89312209915)
入门，快速上手一篇文章。作者直奔主题，开始讲解各种定制，适合入门学习。

这里给的是贴吧的链接，从帖子里，大家可以看到网友的提问和作者的回答，更有助于理解。

## Rime 输入方案设计书

[:link: GitHub](https://github.com/rime/home/wiki/RimeWithSchemata)
[:material-link: 本站](../../wiki/RimeWithSchemata.md)

> Rime 輸入方案創作者的第一本參考書

※ 佛振 chen.sst@gmail.com 修訂於 2013 年 5 月 4 日

关于 Rime，最最权威，最最经典的资料。出自 Rime 的主要设计者和创作者 佛振老大之手。进阶必读！

对Rime的工作原理和设计思想都进行了深入浅出讲解。主要包括以下几个部分：

1. Rime 的简介和一些设计思想
2. Rime 的数据文件分布及作用 (**强烈推荐阅读**,打 patch 的基础)
3. 详解了输入法各功能组件的工作流程 (适合输入方案设计者和高阶用户，看完后，你会对 yaml 文件中顶层的标签不再陌生)
4. 介绍了如何打 patch 定制 (**强烈推荐阅读**，所有定制的基础)
5. 综合演练 (介绍了几个实例，关于输入方案定制，进阶用户必读，想要对现有方案做大改动的必读)

## 定制指南

[:link: GitHub](https://github.com/rime/home/wiki/CustomizationGuide)
[:material-link: 本站](../../wiki/CustomizationGuide.md)

这里全是一些具体的细节的定制实例。

如：

- / 鍵輸入標點「、」
- 全套西文标点符号
- 默認英文輸出
- Control 鍵切換中西文
等等

`Rime 输入方案设计书`的第5部分，讲的是演练实例，是大的输入方案的改造，而这里只是一些我们日常生活是经常会用到的，对输入方案的小小的调整。  
如果你有什么关于定制的问题想要提问，建议先认真阅读一下这里。  
当然，如果你解决了某个定制问题，你也可以将解决方案添加到这个 wiki 中。

## Schema.yaml 詳解

[:link: GitHub](https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/Rime_description.md)
[:material-link: 本站](../../collect/RimeDescription-Schema.md)

对一个输入方案的yaml文档做了详解，对`Rime输入方案设计书`中的第三部分的补充，设计书是从理论角度讲，这里是结合schema.yaml文件逐步讲的。  
另外文章末尾还附了 Dict.yaml 詳解，如果想对词库或者码表作修改，可以看这里。


----
下面还有一些比较好的贴子。

## 佛振教你写 Rime 输入方案之辅助码的作法

[:link: 贴吧](http://tieba.baidu.com/p/2094178562)

可以看作者如何操作 Vim 和正则表达式。对码表进行深入的剖解。
