---
source: rime-squirrel-wiki/实现Shift_L-按下时切换输入法即Shift_L-代替Ctrl_Space-切换系统输入法.md
title: 实现`Shift L`按下时切换输入法
---

> 实现Shift_L-按下时切换输入法即Shift_L-代替Ctrl_Space-切换系统输入法

### 想要实现的功能 按下shift 来切换中英文状态
理想的情况是 mac 只保留一个Squirrel 输入法，用Squirrel 中的功能（shift切换中英文状态）<br/>
现实的情况是 mac 不允许删除默认的 英文输入法，且默认某些Application输入法状态是系统默认的英文<br/>
所以有时实现切换中英文会变得很繁琐 （系统英文态<---> Squirrel英文态<---->Squirrel中文态)


解决方案 不使用 Squirrel英文态，但是依然想用Shift_L 来切换中英文状态<br/>
（系统英文态<---->Squirrel中文态)

这种用法需要将squirrel 配置成禁用ascii_mode的形式

###  1 把ascii_composer从processors移除， 只是不知道会不会有负作用，待验证

###  2 将你用的schema的输入法改为只有中文一种状态，如 wubi_pinyin.schema.yaml
```
switches:
  - name: ascii_mode
    reset: 0
    states: [ 中文] #只保留中文输入法，避免无意间切到英文输入状态，因为我使用系统的英文输入法，还不是rime的
#   states: [ 中文, 西文 ]
#或者使用下面这种语法来打patch
# switches/@0/states:  [ 中文]
```
###  或者以打补丁的方式wubi_pinyin.schema.custom.yaml
```
patch:
# switches:
#   - name: ascii_mode
#     reset: 0
#     states: [ 中文, 西文 ]
  
# wubi_pinyin.schema.yaml. 里有个reset: 奖0 改成1 就变成默认英文输入状态
# 設輸入方案裏 {name: ascii_mode} 在 switches: 列表中爲第一項，即下標 0
# 默认中文状态
  switches/@0/reset: 0
  # 默认英文状态
  # switches/@0/reset: 1

  # 只保留中文输入法，避免无意间切到英文输入状态，因为我使用系统的英文输入法，还不是rime的
  # states: [ 中文, 西文 ]
  switches/@0/states:  [ 中文]

```

###  default.custom.yaml中
```
patch:
  ascii_composer/switch_key:
    # Shift_L: clear
    # Shift_R: clear
    Shift_L: noop
    Shift_R: noop
  key_binder/bindings:
    - { when: always, accept: Control+Shift+2, toggle: ascii_mode }
    # Ctrl-g
    # - { when: composing, accept: Control+g,  send: Escape}
    - { when: always, accept: Control+g,  send: Escape}
    - { when: always, accept: F17,  send: Escape}

```
###  squirrel.custom.yaml 
 ```
patch:
  us_keyboard_layout: false
  # 修改默认输入法的状态
  # wubi_pinyin.schema.yaml. 里有个reset: 奖0 改成1 就变成默认英文输入状态
  # http://bbs.feng.com/forum.php?mod=viewthread&tid=5127693
  #设置 某些程序 默认的输入法初始状态
  #首先查看程序的 Info.plist 文件,如/Emacs.app/Info.plist 得到 Bundle Identifier，通常是形如 com.apple.Xcode 的字符串。
  # windows 上例如，要在 gVim 裏面默認關閉中文輸入，可如此設定：
  # patch:
  #   app_options/gvim.exe:  # 程序名字全用小寫字母
  #     ascii_mode: true
  app_options:
    com.googlecode.iterm2:
        ascii_mode: false
    com.apple.dt.Xcode:
        ascii_mode: false
    org.gnu.Aquamacs:
        ascii_mode: false
    org.gnu.Emacs:
        ascii_mode: false
        no_inline: true

```

###  需要 配合 https://github.com/tekezo/Karabiner-Elements

~/.config/karabiner/karabiner.json 示例

里面写了4个规则,
英文状态切换left_shift 激活rime
中文状态下left_shift 激活系统英文
英文状态下emacs里 按left_shift ,激活rime ,同时执行shell来切换成insert-state下 “open -g hammerspoon://emacs_evil_insert_state”
中文状态下emacs里按下ctrl-g 则触发ctrl-g按键的时候 激活英文输入法，（我在emacs下ctrl-g会回到evil-normal-state)


```
{
   "global" : {
      "show_in_menu_bar" : true,
      "check_for_updates_on_startup" : true,
      "show_profile_name_in_menu_bar" : false
   },
   "profiles" : [
      {
         "selected" : true,
         "devices" : [],
         "simple_modifications" : [],
         "virtual_hid_keyboard" : {
            "caps_lock_delay_milliseconds" : 0,
            "keyboard_type" : "ansi",
            "country_code" : 0
         },
         "complex_modifications" : {
            "parameters" : {
               "basic.to_delayed_action_delay_milliseconds" : 500,
               "basic.to_if_held_down_threshold_milliseconds" : 500,
               "basic.simultaneous_threshold_milliseconds" : 50,
               "basic.to_if_alone_timeout_milliseconds" : 1000
            },
            "rules" : [
               {
                  "manipulators" : [
                     {
                        "from" : {
                           "modifiers" : {
                              "optional" : [
                                 "any"
                              ]
                           },
                           "key_code" : "left_shift"
                        },
                        "to_if_alone" : [
                           {
                              "key_code" : "escape"
                           },
                           {
                              "select_input_source" : {
                                 "language" : "en",
                                 "input_source_id" : "^com\\.apple\\.keylayout\\.US$"
                              }
                           }
                        ],
                        "type" : "basic",
                        "conditions" : [
                           {
                              "type" : "input_source_if",
                              "input_sources" : [
                                 {
                                    "language" : "zh-Hans"
                                 }
                              ]
                           }
                        ],
                        "to" : [
                           {
                              "key_code" : "left_shift"
                           }
                        ],
                        "description" : "按 left_shift 切换系统英文和 RIME 输入法"
                     },
                     {
                        "from" : {
                           "modifiers" : {
                              "optional" : [
                                 "any"
                              ]
                           },
                           "key_code" : "left_shift"
                        },
                        "to_if_alone" : [
                           {
                              "select_input_source" : {
                                 "language" : "zh-Hans",
                                 "input_source_id" : "^im\\.rime\\.inputmethod\\.Squirrel\\.Rime$"
                              }
                           }
                        ],
                        "type" : "basic",
                        "conditions" : [
                           {
                              "type" : "input_source_if",
                              "input_sources" : [
                                 {
                                    "language" : "en"
                                 }
                              ]
                           },
                           {
                              "bundle_identifiers" : [
                                 "^org\\.gnu\\.Emacs$",
                                 "^org\\.gnu\\.AquamacsEmacs$",
                                 "^org\\.gnu\\.Aquamacs$"
                              ],
                              "type" : "frontmost_application_unless"
                           }
                        ],
                        "description" : "按 left_shift 切换RIME 输入法",
                        "to" : [
                           {
                              "key_code" : "left_shift"
                           }
                        ]
                     },
                     {
                        "from" : {
                           "key_code" : "left_shift",
                           "modifiers" : {
                              "optional" : [
                                 "any"
                              ]
                           }
                        },
                        "type" : "basic",
                        "to_if_alone" : [
                           {
                              "select_input_source" : {
                                 "input_source_id" : "^im\\.rime\\.inputmethod\\.Squirrel\\.Rime$",
                                 "language" : "zh-Hans"
                              }
                           },
                           {
                              "key_code" : "f18"
                           }
                        ],
                        "conditions" : [
                           {
                              "type" : "input_source_if",
                              "input_sources" : [
                                 {
                                    "language" : "en"
                                 }
                              ]
                           },
                           {
                              "type" : "frontmost_application_if",
                              "bundle_identifiers" : [
                                 "^org\\.gnu\\.Emacs$",
                                 "^org\\.gnu\\.AquamacsEmacs$",
                                 "^org\\.gnu\\.Aquamacs$"
                              ]
                           }
                        ],
                        "description" : "emacs按 left_shift 切换RIME 输入法",
                        "to" : [
                           {
                              "key_code" : "left_shift"
                           }
                        ]
                     },
                     {
                        "type" : "basic",
                        "conditions" : [
                           {
                              "input_sources" : [
                                 {
                                    "language" : "zh-Hans"
                                 }
                              ],
                              "type" : "input_source_if"
                           },
                           {
                              "bundle_identifiers" : [
                                 "^org\\.gnu\\.Emacs$",
                                 "^org\\.gnu\\.AquamacsEmacs$",
                                 "^org\\.gnu\\.Aquamacs$"
                              ],
                              "type" : "frontmost_application_if"
                           }
                        ],
                        "to" : [
                           {
                              "key_code" : "g",
                              "modifiers" : [
                                 "left_control"
                              ]
                           },
                           {
                              "select_input_source" : {
                                 "input_source_id" : "^com\\.apple\\.keylayout\\.US$",
                                 "language" : "en"
                              }
                           }
                        ],
                        "description" : "emacs按 ctrl-g 切换english 输入法",
                        "from" : {
                           "key_code" : "g",
                           "modifiers" : {
                              "mandatory" : [
                                 "control"
                              ],
                              "optional" : [
                                 "caps_lock"
                              ]
                           }
                        }
                     }
                  ],
                  "description" : "按 left_shift 切换系统英文和 RIME 输入法"
               }
            ]
         },
         "name" : "Default profile"
      }
   ]
}

```
### emacs 配置
```
(global-set-key (kbd "<f17>") 'evil-normal-state) ;mac karabiner用来控制输入法
(define-key isearch-mode-map (kbd "<f17>") 'evil-normal-state) ;详见isearch-pre-command-hook
(global-set-key (kbd "<f18>") 'evil-insert-state) ;mac karabiner用来控制输入法
(define-key isearch-mode-map (kbd "<f18>") 'evil-insert-state) ;详见isearch-pre-command-hook
```