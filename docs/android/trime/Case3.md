---
source: rime-trime-wiki/五笔双键配置案例详解(三)-用模糊音实现双键转换.md
title: (三)-用模糊音实现双键转换
---

前面的热身已经结束，下面开始真正的定制了。

这部分的定制还是在PC的小狼毫上进行，主要修改上一节中复制得来的，wubi86_double_key.schema.yaml文件。

## 具体的配置

将wubi86_double_key.schema.yaml文件中的speller节点修改如下：

```yaml
speller:
  delimiter: " ;'"
  max_code_length: 4
  algebra:
    - derive/w/q/
    - derive/r/e/
    - derive/y/t/
    - derive/i/u/
    - derive/p/o/
 
    - derive/s/a/
    - derive/f/d/
    - derive/h/g/
    - derive/k/j/
 
    - derive/c/x/
    - derive/b/v/
    - derive/m/n/
```

上面的代码就是用来改造五笔双键，也是双键输入法定制的核心。

## 原理说明
这里主要用到的技术就是模糊音。
注意上面的derive你可以理解为替换的意思，比如 `- derive/w/q`就是将码表编码中的所有w都替换为q。

从我们要定制的输入法图片上，我们可以看出，五笔双键的键盘每个按键上有两个键。
但是，目前小狼毫的librime并不支持，输入时对按键进行模糊化，即输入一个按键可能有两种情况（也正是这个原因，同文输入法目前不能支持九宫格，期待@佛振老大等人可以快点更新呀)。

我们不能对输入编码进行模糊化，那就只能对码表进行模糊化。

想象一下，我们现在只能输入一半的按键，比QW键其实是Q键，只是外观写的是"Q/W"。这样用户就只能输入Q，而不可能输入W了。
如果用一个简单的直接的办法实现，能将码表中所有的字都打出来，那就是事先将码表中的所有的W都替换成Q。将R替换成E等等。这样就可以实现模糊化了。
因为，输入Q时候，原来为编码为W的字(编码已经被替换成Q)也会出来。
这样要修改码表，虽然比较复杂，也不推荐，但是可以帮助我们理解一下概念。

拼写运算是rime对输入法编码进行定制的最强大的武器。
而正则表达式又是拼写运算的核心知识点。
关于这两者，大家有兴趣可以查看设计书中具体连链接。

## 使用和存在的问题

现在再运行脚本，部署一下。看看会发生什么？
 
Ctrl+~,切换到"五笔双键"。按一下A,"工"和"要"都出来了，即A和S上的简码都出来了。
 
呵呵，是不是实现了？
别着急。目前还是很多问题的：
 
1. 现在切换到wubi86，试着输入几个字，你会发现，wubi86也被模糊化了。
2. 注意词频是有问题的，你试着输lqtt. 显示 "输入"这个单词，居然在"加尔各答"后面？

以下都是@xiaoqun2016 老师给出的回答.具体见
https://github.com/osfans/trime/issues/61
 
### 共享码表的问题
在translator结点下，添加如下定义
  　prism: wubi86_double_key
替换prism这个属性，表示生成的码表棱镜文件。即最终会生成一个名为wubi_double_key.prism.bin的二进制文件，用来存储我们加了模糊音替换后的wubi86的码表。
如果不加这个选项，就会与原来的wubi86.schema共用一个码表，这样就会改变原来的输入方案。即使用标准的wubi86也会有模糊音的现象。


### 模糊化后的词频问题
这里主要涉及码表翻译器(table_translator)和音节翻译器(script_translator)
table_traslator对拼写运算支持得不好，经典模糊音转换来的字词的频率都默认为0，所以无法按正常的词频显示。
script_translator不存在这个问题，但是可能会有别的问题。这个我也在理解中
 
 
## 修改后的源码
以下为我现在使用的 `wubi86_double_key.schema.yaml`的源码

```yaml
# Rime schema settings
# vim: set sw=2 sts=2 et:
# encoding: utf-8

schema:
  schema_id: wubi86_double_key
  name: "五笔86双键版"
  version: "0.12"
  author:
    - 發明人 王永民先生
  description: |
    五筆字型86版
    碼表源自 ibus-table
    請安裝【袖珍簡化字拼音】以啓用 z 鍵拼音反查

switches:
  - name: ascii_mode
    reset: 0
    states: [ 中文, 西文 ]
  - name: full_shape
    states: [ 半角, 全角 ]
  - name: extended_charset
    states: [ 通用, 增廣 ]

engine:
  processors:
    - ascii_composer
    - recognizer
    - key_binder
    - speller
    - punctuator
    - selector
    - navigator
    - express_editor
  segmentors:
    - ascii_segmentor
    - matcher
    - abc_segmentor
    - punct_segmentor
    - fallback_segmentor
  translators:
    - punct_translator
    - reverse_lookup_translator
#    - table_translator
    - script_translator

speller:
  delimiter: " ;'"
  max_code_length: 4
  algebra:
    - derive/w/q/
    - derive/r/e/ 
    - derive/y/t/ 
    - derive/i/u/ 
    - derive/p/o/ 

    - derive/s/a/ 
    - derive/f/d/ 
    - derive/h/g/ 
    - derive/k/j/ 
    
    - derive/c/x/ 
    - derive/b/v/ 
    - derive/m/n/ 

translator:
  dictionary: wubi86_double_key
  enable_charset_filter: true
  enable_encoder: true

reverse_lookup:
  dictionary: pinyin_simp
  prefix: "z"
  tips: 〔拼音〕
  preedit_format:
    - xform/([nljqxy])v/$1ü/
    - xform/([nl])ue/$1üe/
    - xform/([jqxy])v/$1u/

punctuator:
  import_preset: default

key_binder:
  import_preset: default

recognizer:
  import_preset: default
  patterns:
    reverse_lookup: "^z[a-z]*$"

```
