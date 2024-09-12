---
source: rime-trime-wiki/trime.yaml.md
title: trime.yaml 速查
---


```yaml
# Trime default style settings
# encoding: utf-8

config_version: "for小鹤主题5.5"
name: 比翼高飞
# 本主题依附于小鹤主题使用，下面__include: 之后紧跟的就是主题名
# 如使用本主题，小鹤主题名应为：trime.yaml；如小鹤主题名为：小鹤.trime.yaml，则需在本文件内查找“__include: 小鹤.trime”替换为“__include: 小鹤.trime”
# 
author: 散步的鹤 flypy.com #作者资讯
height:
# ----------键盘高度调整------------

  A: &VJG 54         #主键盘行高  自定
  B: &VJY 44         #主键盘第一行高 与符号键盘高度不等时调整
  C: &VJM 20         #主键盘增高行高
  D: &FJG 56         #符号键盘行高  D=(A*4+B+C)/5=56
  E: &SZG 64         #数字和编辑键盘行高 E=(D*5-C)/4=64
  F: &SZM 24        #数字和编辑键盘末行高=C 和主键盘不平时调整
  
  M: &SPG 280 #3.2.6竖屏总高=A*4+B+C
  N: &HPG 240 #3.2.6横屏总高

# ----------键盘左右下留空3.2.3------------

  U: &UZYK 5  #竖屏左右留空
  X: &UXMK 0  #竖屏下面留空
  
  H: &HZYK 40 #横屏左右留空
  M: &HXMK 0 #横屏下面留空
  
# ----------空格行键宽度调整------------

  E: &HCK 17          #回车
  K: &KGK 35         #空格
  S: &SBK 16          #数字标点
  #100=数字标点S*3+空格K+回车H
  
  K0: &KBZ 32
  K1: &KGZ 15
  K2: &KGV 5
  K3: &KGY 15
  K4: &KBY 33
# ----------结束------------，
style:
  __include: 小鹤.trime:/style
  key_height: *FJG
  keyboard_height: *SPG #3.2.6锁定键盘高度，避免切换时键盘高度变化而造成闪烁
  keyboard_height_land: *HPG #3.2.6锁定横屏下键盘高度，避免切换时键盘高度变化而造成闪烁
  keyboard_padding: *UZYK #3.2.6竖屏模式下，屏幕左右两侧与键盘的距离（曲面屏减少误触）
  keyboard_padding_bottom: *UXMK #3.2.6竖屏模式下，屏幕下边缘与键盘的距离（避免误触发全面屏手势）
  keyboard_padding_land: *HZYK #3.2.6横屏模式下，屏幕左右两侧与键盘的距离（避免横屏按键过度拉伸变形）
  keyboard_padding_land_bottom: *HXMK #3.2.6横屏模式下，屏幕下侧与键盘的距离
android_keys:
  __include: 小鹤.trime:/android_keys
liquid_keyboard:
  __include: 小鹤.trime:/liquid_keyboard
preset_keys:
  __include: 小鹤.trime:/preset_keys
  __patch:
    K_defaultVJ:  #注销助记键盘设定键
fallback_colors:
  __include: 小鹤.trime:/fallback_colors
preset_color_schemes:
  __include: 小鹤.trime:/preset_color_schemes
preset_keyboards:
  __include: 小鹤.trime:/preset_keyboards
  __patch:
    defaultVJ:  #注销助记键盘
  default:
    __include: 小鹤.trime:/preset_keyboards/default
    height: *VJG
    __patch:
        "keys/@before 0": {height: *VJY, click: 1, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 1": {click: 2, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 2": {click: 3, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 3": {click: 4, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 4": {click: 5, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 5": {click: 6, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 6": {click: 7, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 7": {click: 8, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 8": {click: 9, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 9": {click: 0, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@0/long_click": "$"
        "keys/@1/long_click": "*"
        "keys/@2/long_click": "("
        "keys/@3/long_click": ")"
        "keys/@4/long_click": "<"
        "keys/@5/long_click": ">"
        "keys/@6/long_click": "["
        "keys/@7/long_click": "]"
        "keys/@8/long_click": "&"
        "keys/@9/long_click": "~"
        "keys/@11/long_click": select_all
        "keys/@13/long_click": "-"
        "keys/@14/long_click": ";"
        "keys/@21/width": 12 #如果需要AZ两行居中对齐，在此行和下行前加#号即可
        "keys/@before 33": {click: "", width: 3, key_back_color: glb, hilited_key_back_color: glb}
        "keys/@30/height": 
        "keys/@30/key_symbol_offset_x": 0
        "keys/@30/width": *SBK
        "keys/@31/width": *SBK
        "keys/@31/long_click": "!"
        "keys/@31/composing": 
        "keys/@31/key_symbol_offset_x": 0
        "keys/@32": {click: space, width: *KGK, key_text_size: 9, key_text_offset_x: 0, key_text_offset_y: 3, key_symbol_offset_x: 0, key_symbol_offset_y: 6, long_click: Mode_switch, key_back_color: kgb, key_text_color: kgt, key_symbol_color: kgs, hilited_key_back_color: kgh, hilited_key_text_color: kght, hilited_key_symbol_color: kghs}
        "keys/@33": {click: ".", label: "  。", width: *SBK, composing: delimiterJ1, long_click: "?", key_back_color: bdb, key_text_color: bdt, key_symbol_color: bds, hilited_key_back_color: bdh, hilited_key_text_color: bdht, hilited_key_symbol_color: bdhs}
        "keys/@34/width": *HCK
        "keys/@34/key_symbol_offset_x": 0
        "keys/@35": {height: *VJM, click: "", width: *KBZ, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@36": {click: Left2, composing: space, width: *KGZ, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@37": {click: space2, width: *KGV, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@38": {click: Right2, composing: space, width: *KGY, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@39": {click: "", width: *KBY, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
    key_symbol_offset_x: 0
  letter:
    __include: 小鹤.trime:/preset_keyboards/letter
    height: *VJG
    __patch:
        "keys/@before 0": {height: *VJY, click: 1, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 1": {click: 2, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 2": {click: 3, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 3": {click: 4, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 4": {click: 5, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 5": {click: 6, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 6": {click: 7, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 7": {click: 8, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 8": {click: 9, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@before 9": {click: 0, key_back_color: 789B, hilited_key_back_color: 789H, key_text_color: 789T}
        "keys/@11/long_click": select_all
        "keys/@13/long_click": "-"
        "keys/@14/long_click": "&"
        "keys/@21/width": 12 #如果需要AZ两行居中对齐，在此行和下行前加#号即可
        "keys/@before 33": {click: "", width: 3, key_back_color: xdbdb, hilited_key_back_color: xdbdb}
        "keys/@30/composing": 
        "keys/@30/width": *SBK
        "keys/@30/key_symbol_offset_x": 0
        "keys/@30/height": 
        "keys/@31/long_click": "!"
        "keys/@31/composing": 
        "keys/@31/key_symbol_offset_x": 0
        "keys/@31/width": *SBK
        "keys/@32/width": *KGK
        "keys/@32/key_text_color": ykgt
        "keys/@32/key_text_offset_x": 0
        "keys/@32/key_symbol_offset_x": 0
        "keys/@32/key_text_offset_y": 3
        "keys/@32/key_back_color": kgb
        "keys/@32/hilited_key_back_color": kgh
        "keys/@32/swipe_left": 
        "keys/@32/swipe_right": 
        "keys/@33": {click: ".", label: " 。", composing: delimiterJ, long_click: "?", width: *SBK, key_back_color: bdb, key_text_color: bdt, key_symbol_color: bds, hilited_key_back_color: bdh, hilited_key_text_color: hbdt}
        "keys/@34/width": *HCK
        "keys/@34/key_symbol_offset_x": 0
        "keys/@35": {height: *VJM, click: "", width: *KBZ, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@36": {click: Left2, composing: space, width: *KGZ, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@37": {click: space2, width: *KGV, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@38": {click: Right2, composing: space, width: *KGY, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
        "keys/@39": {click: "", width: *KBY, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
    key_symbol_offset_x: 0
  number:
    __include: 小鹤.trime:/preset_keyboards/number
    height: *SZG
    __patch:
        "keys/@15/height": *SZG   # enter行
        "keys/@20": {height: *SZM, click: "", width: 100, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
  edit:
    __include: 小鹤.trime:/preset_keyboards/edit
    height: *SZG
    __patch:
        "keys/@15/height": *SZG
        "keys/@20": {height: *SZM, click: "", width: 100, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
  menu:
    __include: 小鹤.trime:/preset_keyboards/menu
    height: *SZG
    __patch:
        "keys/@21/height": *SZG
        "keys/@28": {height: *SZM, click: "", width: 100, key_back_color: zgb, key_text_color: 0x00, hilited_key_back_color: zgb, hilited_key_text_color: 0x00}
```
