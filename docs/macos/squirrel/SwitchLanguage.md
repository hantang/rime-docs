---
source: rime-squirrel-wiki/禁用-Squirrel-英文模式，使用左侧-Shift-切换中英.md
title: 使用左侧-Shift 切换中英
---

时间：2018-08-19    
系统：macOS 10.13.6     
应用版本：
- Karabiner-Elements 12.1.0
- Squirrel 2018/04/12 编译

## 具体步骤

1. 禁用 Squirrel 中的英文模式：
  > 从输入方案中 engine/processor 列表里删除 ascii_composer

这是开发者 lotem (佛振) 钦点的方法。https://github.com/rime/squirrel/issues/221#issuecomment-401652387

以小鹤双拼输入方案为例，在 `double_pinyin_flypy.custom.yaml` 自定义文件中加入：

```
patch:
  engine/processors:
    # - ascii_composer
    - recognizer
    - key_binder
    - speller
    - punctuator
    - selector
    - navigator
    - express_editor
```
这样就相当于删除 ascii_composer 了，也就禁用英文模式了。

2. 在 squirrel.custom.yaml 自定义文件中加入：
```
patch:
  app_options:
```
这是为了防止 Squirrel 在某些应用中试图自动切换英文模式。因为第一步已禁用英文模式，不做这一步会导致有些应用中无法输入中文。

3. 配置 Karabiner-Elements

打开 ~/.config/karabiner/karabiner.json 文件，可以看到如下代码：
```
{
    "global":
    {
        "check_for_updates_on_startup": true,
        "show_in_menu_bar": true,
        "show_profile_name_in_menu_bar": false
    },
    "profiles": [
    {
        "complex_modifications":
        {
            "parameters":
            {
                "basic.simultaneous_threshold_milliseconds": 50,
                "basic.to_delayed_action_delay_milliseconds": 500,
                "basic.to_if_alone_timeout_milliseconds": 1000,
                "basic.to_if_held_down_threshold_milliseconds": 500
            },
            "rules": []
        },
... ...
```
在其中 rules 后面的 中括号 内（也就是规则列表区域），加入：

```
{
"description": "将 单独按下的Left_Shift 映射为 Ctrl+Space，以切换输入法",
"manipulators": [
{
    "type": "basic",
    "from":
    {
        "key_code": "left_shift"
    },
    "to_if_alone": [
    {
        "key_code": "spacebar",
        "modifiers": [
            "left_control"
        ]
    }],
    "to_if_held_down": [
    {
        "key_code": "left_shift"
    }]
}]
}
```

4. 设置输入法切换快捷键为 Crtl+Space，完毕。

## 额外调整

此外，如果你发现按下左侧 Shift 来输入大写或符号时容易不起效或不好用，那就需要进行下面的处理。
这是因为你按下左侧 Shift 的时间太短、动作太快，Karabiner-Elements 不识别。

需要修改上面倒数第二段代码中的这两行代码里的数字为 150 （毫秒）左右：
```
"basic.to_if_alone_timeout_milliseconds": 1000,
"basic.to_if_held_down_threshold_milliseconds": 500
```

含义：
- Shift 按下的时长 **小于** to_if_alone_timeout_milliseconds 的情况下才会发送 ctrl+space 以切换输入法。
- Shift 按下的时长 **大于** to_if_held_down_threshold_milliseconds 的情况下才能输入大写或 @# 等符号。

根据自己情况调整。