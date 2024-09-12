---
source: rime-trime-wiki/五笔双键配置案例详解(四)-实现手机上的双键键盘.md
title: (四)-实现手机上的双键键盘
---

现在我们已经有了一个可以实现双键的输入方案。虽然是在电脑上测试的，但是在手机上也是可以使用的。
我们还缺少一个对应的手机键盘。下面的工作需要在手机上布署测试了。
 
## 具体的配置
 
按惯例，还是先贴上相关代码，再慢慢分析。
我们通过对trime.yaml打patch来实现

```yaml
#trime.custom.yaml
patch:
  #1、新建一個按鍵佈局wubi86_double_key
  "preset_keyboards/wubi86_double_key":  #佈局ID
    author: "boboIqiqi"   #作者
    name: "五笔双键"  #方便自己辨識的名字
    ascii_mode: 0 #默認進入中文狀態
    height: 60   #每行高度
    width: 20   #按鍵默認寬度（取所有按鍵中用得較多的寬度值，接下來就可以少寫一些width了） 
    keys:   #按鍵排列
      #第一行
      - {label: "Q W", click: q, long_click: 1}
      - {label: "E R", click: e, long_click: 2}
      - {label: "T Y", click: t, long_click: 3}
      - {label: "U I", click: u, long_click: 4}
      - {label: "O P", click: o, long_click: 5}
 
      #第二行
      - {label: "A S", click: a, long_click: 6}
      - {label: "D F", click: d, long_click: 7}
      - {label: "G H", click: g, long_click: 8}
      - {label: "J K", click: j, long_click: 9}
      - {label: "L"  , click: l, long_click: 0}
 
      #第三行
      - {label: "词" , click: Shift_L, width: 10}
      - {label: "Z"  , click: z, long_click: "@", width: 10}
      - {label: "X C", click: x, long_click: "!"}
      - {label: "V B", click: v, long_click: "?"}
      - {label: "N M", click: n, long_click: "."}
      - {click: BackSpace}
 
      #第四行
      - {click: Keyboard_symbols, width: 15}
      - {click: Keyboard_qwerty, label: "全", long_click: Menu, width: 10}
      - {click: "，", width: 10}
      - {label: " " , click: space, long_click: VOICE_ASSIST, width: 30}
      - {click: "。", width: 10}
      - {label: "123", click: Keyboard_number, width: 10}
      - {label: "确定", click: Return, width: 15}
 
  "style/keyboards":
    - .default
    - default
    - number
    - symbols
    - qwerty
 
  "preset_keyboards/qwerty/ascii_mode": 1
 
  "style/candidate_view_height": 36
  "style/round_corner": 0.0
  "style/label_text_size": 18
  "style/comment_height": 14
  "preset_keys/Keyboard_defaultw":   #返回中文键盘
      label: 英
      select: .default
      send: Eisu_toggle
  "preset_keys/space":
    functional: false
    label: " "
    repeatable: false  #关掉空格键重复
    send: space
 
```
 
## 使用说明
1. 将上面的源码存储为 trime.custom.yaml
2. 将trime.custom.yaml以及wubi86_double_key.schema.yaml都拷贝到手机的/sdcard/rime目录下
3. 到同文的主设置界面，点击重新布署

注：也可以使用准备篇中介绍的批处理脚本，记得回去复习一下哦。

现在，在选单中切换到"五笔双键"输入方案，就可以使用它了。
 
## 原理说明
主要使用到的技术如下:
 
- 定义一个键盘
- 声明和切换键盘
- 通过打patch修改键盘布局的属性
 
建议阅读@xiaoqun2016老师和@osfans老大 写的 [trime.yaml详解](https://github.com/osfans/trime/wiki/trime.yaml%E8%A9%B3%E8%A7%A3)
 
 
