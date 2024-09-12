---
source: rime-hamster-wiki/自定义布局.md
# title: 自定义布局
---

# 自定义键盘布局

仓输入法自定义键盘布局配置文件说明。

> 注意：本教程仅适用于 2.2.0 版本以上。

## 键盘模型

将每种键盘布局抽象为 `Keyboard`, `Row`, `Key`，`KeySwipe` 等模型。其中 `Keyboard` 模型用来表示具体的键盘，`Row` 表示键盘的一行，`Key` 表示行中按键，`KeySwipe` 表示按键的划动配置。

### Keyboard模型

* `name`: 键盘名称。
  * **必选项**，字符串类型。
  * **请保证名称的唯一性**，否则相同名称的键盘会存在覆盖情况。
* `isPrimary`: 是否是主键盘类型
  * 可选值，布尔类型，默认值为 `false`
  * 用于点击符号返回主键盘功能。
* `rowHeight`：键盘中全部行的行高。如果为此项赋值，那么键盘的所有行高都为此值。
  * 可选项，对应 [RowHeight 选项](#RowHeight选项)，可分别为横屏或纵屏设置不同的高度。
* `buttonInsets`: 按钮内距。
  * 可选项，对应 [ButtonInsets 选项](#ButtonInsets选项)。
* `rows`: 键盘的行。
  * **必选项**，数组类型。
  * 数组中每个元素对应 [Row 模型](#Row模型)

### Row模型

* `rowHeight`: 当前行的行高。
  * 可选项，对应 [RowHeight 选项](#RowHeight选项)，可分别为横屏或纵屏设置不同的高度。
  * 如果自定义的键盘的所有行的高度是相等的，请使用 Keyboard 模型中的 `rowHeight` 属性。
* `keys`：当前行的按键。
  * **必选项**，数组类型
  * 数组中每个元素对应 [Key 模型](#Key模型)

### Key模型

* `action`：按键对应的操作。
  * **必选项**，字符串类型。内容必须符合 [Action 选项](#Action选项)，具体如何填写请参考 [Action 选项](#Action选项)。

* `width`：按键宽度。
  * 可选项，字符串类型。如果为空，则默认为 `input` 宽度选项。
  * 填写值对应 [KeyWidth 选项](#KeyWidth选项) 选项。

* `processByRIME`：是否由 RIME 引擎处理。

  * 可选值，布尔类型(true/false)。如果不填写，默认为 ture，表示默认由 RIME 引擎处理。

  > 注意：此参数对 symbol 类型无效，symbol 类型始终不经过 rime 引擎处理

* `label`: 按键显示文本。

  * 可选值，字符串类型。如果不填写，则使用 `action` 对应的文本显示，比如 `action` 的值为 `character(a)`，则显示为 `a`。
  * `label` 可填写两种格式，
    * 格式1: `label: '长显文本'`，为非空格键指定长显的文本。 
    * 格式2: 为空格指定加载文本使用。
    ```yaml
    label:
      loadingText: '加载文字'
      text: '常显文字'
    ```
* `swipe`：按键滑动配置。

  * 可选值，数组类型，每个元素对应 [KeySwipe 模型](#KeySwipe模型) 模型。如果为空，则表示该按键没有划动配置。
  * 具体配置参考 [KeySwipe 模型](#KeySwipe模型)

* `callout`：按键长按呼出视图配置。

  * 可选值，数组类型，每个元素对应 [KeyCallout 模型](#KeyCallout模型) 模型。如果为空，则表示该按键长按呼出设置。
  * 具体配置参考 [KeyCallout 模型](#KeyCallout模型)
  * 例如：
  ```yaml
  callout:
    - action: { shortcutCommand: "#上个输入方案" }
  ```

## KeySwipe模型

* `direction`: 滑动方向。
  * **必选值**，字符串类型。内容必须符合 [Direction 选项](#Direction选项) 选项。

* `action`：表示划动触发的操作。
  * **必选值**，配置与 Key 模型中的 action 配置相同。
  
* `label`: 表示划动显示的文本。
  * 可选值，字符串类型。配置与 Key 模型中的 label 配置相同。
  
* `display`: 表示是否在按键 UI 中显示滑动的文本。
  * 可选值，布尔类型(true/false)。如果不填写，默认为 true，即显示。

* `processByRIME`: 表示滑动触发操作是否经过 RIME 引擎处理。
  * 可选值。布尔类型(true/false)。如果不填写，默认为 false，即不经过 rime 引擎处理。
  > 注意：此参数对 symbol 类型无效，symbol 类型始终不经过 rime 引擎处理

## KeyCallout模型

> 注意：长按选项不支持换行

* `action`：表示触发的操作。
  * **必选值**，配置与 Key 模型中的 action 配置相同。
  * 如果不想呼出的 action 操作由 RIME 处理，请使用 `symbol`, `character`开头的操作会经过 rime 引擎处理。

* `label`: 表示划动显示的文本。
  * 必选值，字符串类型。配置与 Key 模型中的 label 配置相同。

## Action选项

对应 `action` 的值，`action`的值必须为以下形式

* `backspace`：表示物理键盘的退格键。
* `enter`：表示物理键盘的回车键。
* `shift`：表示物理键盘的 Shift 键。
* `tab`：表示物理键盘的 Tab 键。
* `space`：表示物理键盘的空格键。
* `character: { char: 字符 }`：表示物理键盘的字符按键，其中`字符`表示具体的 ASCII 字符。
  
  > 注意：`character`类型会经过 RIME 引擎处理，所以必须是 ASCII 中的单个字符，如果是多个，则截取首个字符。
  
  例如：
  * `a` 键的配置为 `action: { character: { char: a } }`，注意是小写，如果想显示为大写可以通过 `label` 属性配置实现。


* `characterMargin: { char: 字符 }`：用来表示虚拟按键的占位符。不显示，但点击后会和 `character` 的效果相同。例如中文26键中 `A` 键的左侧空白，`L`键的右侧空白。

  > 注意：`characterMargin` 类型会经过 RIME 引擎处理，所以必须是 ASCII 中的单个字符，如果是多个，则截取首个字符。
  
* `keyboardType: type`: 表示切换虚拟键盘的类型，其中 type 表示切换的类型。type 必须符合 [KeyboardType 选项](#KeyboardType选项)，具体如何填写请参考 [KeyboardType 选项](#KeyboardType选项)。

  例如：
  * 表示切换到数字九宫格键盘 `action: { keyboardType: numericNineGrid }`
  * 表示切换分类符号键盘 `action: { keyboardType: classifySymbolic }`
  * 表示切换到自定义键盘-仓颉 `action: { keyboardType: 仓颉 }`

* `symbol: { char: string }`：用来表示想要输入字符串，其中 `string` 表示您想输入的字符串，可以为任何 unicode 字符，不限长度。

  > 注意：`symbol` 类型不会经过 RIME 引擎处理。
  
  例如：
  * `action: { symbol: { char: 你好 } }`，会直接上屏“你好”。

* `shortcutCommand: command`: 用来表示快捷指令，其中 `command` 表示指令名称。具体指令名称请参考 [#ShortcutCommand 选项](#ShortcutCommand选项)。

  例如：
  * `action: { shortcutCommand: "#行首" }`：表示移动到行首。

* `none`: 仅用来表示占位符，不做任何操作且UI不应呈现。
* `nextKeyboard`: 系统键盘切换键，类似系统的地球键，用来切换到 iOS 系统中的其他键盘。

## KeyboardType选项

对应 `action` 中 `keyboardType` 的 `type` 值。

* `alphabetic`：表示英文键盘。
* `classifySymbolic`：表示分类符号键盘。
* `chinese`：表示中文26键的键盘。
* `chineseNineGrid`：表示中文九宫格键盘。
* `numericNineGrid`：表示数字九宫格键盘。
* `emojis`：表示 Emoji 键盘，预留功能，目前还不支持 emoji 键盘。
* `自定义键盘名称`: 表示自定义键盘，对应 Keyboard 模型中的 `name` 值。

## ShortcutCommand选项

对应 `action` 中 `shortcutCommand` 的 `command` 值。

* `#重输`：表示清空还未上屏的输入字符。
* `#简繁切换`: 表示中文简繁切换。
* `#中英切换`：表示中文英文切换。
* `#行首`：表示光标移动到行首。
* `#行尾`：表示光标移动到行尾。
* `#次选上屏`：表示候选文字列表中次选文字上屏。
* `#三选上屏`：表示候选文字列表中第三位候选文字上屏。
* `#上个输入方案`：表示当在“输入方案列表”中选择两个或两个以上方案时，最近一次的输入方案与当前输入方案切换。
* `#换行`：表示换行，注意：这里使用 `\r` 表示换行。
* `#RimeSwitcher`：表示进入 RIME 的 switch 功能。
* `#左移`：表示光标向左移动一个字符
* `#右移`：表示光标向右移动一个字符
* `sendKeys: { keys: string }`：表示向 RIME 引擎发送指定按键。`string` 表示组合按键的配置，配置示例: `action: { shortcutCommand: { sendKeys: { keys: "Control+l" } } }`
* `#关闭键盘`：表示关闭当前键盘
* `#左手模式`: 单手模式中的左手模式
* `#右手模式`: 单手模式中的右手模式
* `#方案切换`: 显示已选的方案列表，在列表中可切换当前输入方案。

## KeyWidth选项

用来表示键宽。

KeyWidth 选项可以填写以下值：

* `available`: 表示剩余宽度，如果同行中有两个及两个以上的按钮的宽度为 `available` 类型，则它们会平分剩余宽度。
* `input`: 全键盘中全部 input 类型的按键，宽度相同。系统会自动计算 `input` 类型的宽度。
* `inputPercentage: value`: 使用 `input` 类型宽度的百分比作为按键的宽度, 其中 `value` 为表示百分比的值，浮点类型。

  例如: 
  * `width: { inputPercentage: 2 }` 表示 `input` 类型宽度的 2 倍作为按键宽度。
  * `width: { inputPercentage: 0.5 }` 表示 `input` 类型宽度的 1/2 作为按键宽度。
  
* `percentage: value`：使用行宽度的百分比作为按键的宽度，其中 `value` 为表示百分比的值，浮点类型。
 
  例如：`width: { percentage: 0.13 }` 表示行宽度的 13% 作为当前按键的宽度。

* `points: value`: 指定按键宽度为已 pt(point) 为单位的固定值。其中 `value` 为浮点类型。

  例如：`width: { points: 20 }`：表示当前按键宽度为 20 个 pt。

按键宽度有两种表示方式：

* 方式1: 直接赋值，表示横屏模式/纵屏模式宽度相同。

```yaml
width: available
width: { percentage: 0.13 }
```

* 方式2: 为横屏/纵屏模式设置不同值。

```yaml
width:
  portrait: { percentage: 0 }
  landscape: { percentage: 0.07 }
```

## Direction选项

* `up`: 表示向上划动。
* `down`：表示向下划动。
* `left`: 表示向左划动。
* `right`：表示向右划动。


## RowHeight选项

用来表示行高。有两种表达方式

* 方式1：单独填写浮点类型数值，如：`rowHeight: 40.5`，则表示屏幕在横屏与纵屏模式下行高相同。
* 方式2：纵屏和横屏模式下设定不同的高度。可以为`portrait`与`landscape`赋值。如：

```yaml
rowHeight:
  portrait: 40.5
  landscape: 30.5
```

## ButtonInsets选项

用来表示按键内距。有两种表达方式

* 方式1: 单独填写浮点数值，如`buttonInsets: 3`，表示按键的四条边的内距相同，都为 `3`。
* 方式2：对象模式，为四边分别设定内距。如：

```yaml
buttonInsets: { left: 2, right: 2, top: 4, bottom: 4 }
```

> 注意：单个属性如果未赋值，则该属性值为零。


## 配置示例

```yaml
keyboards:
  - name: "仓颉"
    isPrimary: true
    rows:
      - keys:
          - action: { character: { char: q } }
            label: "手"
            swipe:
              - direction: up
                action: { character: { char: 1 } }
                display: true
          - action: { character: { char: w } }
            label: "田"
            swipe:
              - direction: up
                action: { character: { char: 2 } }
                display: true
          - action: { character: { char: e } }
            label: "水"
            swipe:
              - direction: up
                action: { character: { char: 3 } }
                display: true
          - action: { character: { char: "r" } }
            label: "口"
            swipe:
              - direction: up
                action: { character: { char: "4" } }
                display: true
          - action: { character: { char: "t" } }
            label: "廿"
            swipe:
              - direction: up
                action: { character: { char: "5" } }
                display: true
          - action: { character: { char: "y" } }
            label: "卜"
            swipe:
              - direction: up
                action: { character: { char: "6" } }
                display: true
          - action: { character: { char: "u" } }
            label: "山"
            swipe:
              - direction: up
                action: { character: { char: "7" } }
                display: true
          - action: { character: { char: "i" } }
            label: "戈"
            swipe:
              - direction: up
                action: { character: { char: "8" } }
                display: true
          - action: { character: { char: "o" } }
            label: "人"
            swipe:
              - direction: up
                action: { character: { char: "9" } }
                display: true
          - action: { character: { char: "p" } }
            label: "心"
            swipe:
              - direction: up
                action: { character: { char: "0" } }
                display: true
      - keys:
          - action: { characterMargin: { char: "a" } }
            width: available
          - action: { character: { char: "a" } }
            label: "日"
            swipe:
              - direction: up
                action: { character: { char: "!" } }
                display: true
          - action: { character: { char: "s" } }
            label: "尸"
            swipe:
              - direction: up
                action: { character: { char: "@" } }
                display: true
          - action: { character: { char: "d" } }
            label: "木"
            swipe:
              - direction: up
                action: { character: { char: "#" } }
                display: true
          - action: { character: { char: "f" } }
            label: "火"
            swipe:
              - direction: up
                action: { character: { char: "$" } }
                display: true
          - action: { character: { char: "g" } }
            label: "土"
            swipe:
              - direction: up
                action: { character: { char: "%" } }
                display: true
          - action: { character: { char: "h" } }
            label: "竹"
            swipe:
              - direction: up
                action: { character: { char: "&" } }
                display: true
          - action: { character: { char: "j" } }
            label: "十"
            swipe:
              - direction: up
                action: { character: { char: "*" } }
                display: true
          - action: { character: { char: "k" } }
            label: "大"
            swipe:
              - direction: up
                action: { character: { char: "(" } }
                display: true
          - action: { character: { char: "l" } }
            label: "中"
            swipe:
              - direction: up
                action: { character: { char: ")" } }
                display: true
          - action: { characterMargin: { char: "l" } }
            width: available
      - keys:
          - action: { keyboardType: classifySymbolic }
            width: { percentage: 0.13 }
          - action: { characterMargin: { char: "z" } }
            width: available
          - action: { character: { char: "z" } }
            label: "重"
            swipe:
              - direction: up
                action: { character: { char: "~" } }
                display: true
          - action: { character: { char: "x" } }
            label: "難"
            swipe:
              - direction: up
                action: { character: { char: ":" } }
                display: true
          - action: { character: { char: "c" } }
            label: "金"
            swipe:
              - direction: up
                action: { character: { char: "'" } }
                display: true
          - action: { character: { char: "v" } }
            label: "女"
            swipe:
              - direction: up
                action: { character: { char: "_" } }
                display: true
          - action: { character: { char: "b" } }
            label: "月"
            swipe:
              - direction: up
                action: { character: { char: "," } }
                label: "，"
                display: true
          - action: { character: { char: "n" } }
            label: "弓"
            swipe:
              - direction: up
                action: { character: { char: "." } }
                label: "。"
                display: true
          - action: { character: { char: "m" } }
            label: "一"
            swipe:
              - direction: up
                action: { character: { char: "?" } }
                label: "？"
                display: true
          - action: { characterMargin: { char: "m" } }
            width: available
          - action: backspace
            width: { percentage: 0.13 }
            swipe:
              - direction: up
                action: { shortcutCommand: "#重输" }
      - keys:
          - action: { keyboardType: numericNineGrid }
            width: { percentage: 0.19 }
          - action: space
            width: available
            label:
              loadingText: "仓输入法"
              text: "空格"
          - action: { character: { char: "," } }
            label: "，"
            swipe:
              - direction: up
                action: { character: { char: "." } }
                label: "。"
                display: true
          - action: { keyboardType: alphabetic }
            width: { percentage: 0.13 }
          - action: enter
            width: { percentage: 0.19 }
  - name: "大千注音"
    isPrimary: true
    buttonInsets: { left: 2, right: 2, top: 4, bottom: 4 }
    rowHeight: 43.2
    rows:
      - keys:
          - action: { character: { char: "1" } }
            label: "ㄅ"
            swipe:
              - direction: up
                action: { character: { char: "1" } }
                display: true
          - action: { character: { char: "2" } }
            label: "ㄉ"
            swipe:
              - direction: up
                action: { character: { char: "2" } }
                display: true
          - action: { character: { char: "3" } }
            label: "ˇ"
            swipe:
              - direction: up
                action: { character: { char: "3" } }
                display: true
          - action: { character: { char: "4" } }
            label: "ˋ"
            swipe:
              - direction: up
                action: { character: { char: "4" } }
                display: true
          - action: { character: { char: "5" } }
            label: "ㄓ"
            swipe:
              - direction: up
                action: { character: { char: "5" } }
                display: true
          - action: { character: { char: "6" } }
            label: "ˊ"
            swipe:
              - direction: up
                action: { character: { char: "6" } }
                display: true
          - action: { character: { char: "7" } }
            label: "˙"
            swipe:
              - direction: up
                action: { character: { char: "7" } }
                display: true
          - action: { character: { char: "8" } }
            label: "ㄚ"
            swipe:
              - direction: up
                action: { character: { char: "8" } }
                display: true
          - action: { character: { char: "9" } }
            label: "ㄞ"
            swipe:
              - direction: up
                action: { character: { char: "9" } }
                display: true
          - action: { character: { char: "0" } }
            label: "ㄢ"
            swipe:
              - direction: up
                action: { character: { char: "0" } }
                display: true
          - action: { character: { char: "-" } }
            label: "ㄦ"
            swipe:
              - direction: up
                action: { character: { char: "-" } }
                display: true
      - keys:
          - action: { characterMargin: { char: "q" } }
            width: available
          - action: { character: { char: "q" } }
            label: "ㄆ"
          - action: { character: { char: "w" } }
            label: "ㄊ"
          - action: { character: { char: "e" } }
            label: "ㄍ"
          - action: { character: { char: "r" } }
            label: "ㄐ"
          - action: { character: { char: "t" } }
            label: "ㄔ"
          - action: { character: { char: "y" } }
            label: "ㄗ"
          - action: { character: { char: "u" } }
            label: "ㄧ"
          - action: { character: { char: "i" } }
            label: "ㄛ"
          - action: { character: { char: "o" } }
            label: "ㄟ"
          - action: { character: { char: "p" } }
            label: "ㄣ"
          - action: { characterMargin: { char: "p" } }
            width: available
      - keys:
          - action: { characterMargin: { char: "a" } }
            width: available
          - action: { character: { char: "a" } }
            label: "ㄇ"
          - action: { character: { char: "s" } }
            label: "ㄋ"
          - action: { character: { char: "d" } }
            label: "ㄎ"
          - action: { character: { char: "f" } }
            label: "ㄑ"
          - action: { character: { char: "g" } }
            label: "ㄕ"
          - action: { character: { char: "h" } }
            label: "ㄘ"
          - action: { character: { char: "j" } }
            label: "ㄨ"
          - action: { character: { char: "k" } }
            label: "ㄜ"
          - action: { character: { char: "l" } }
            label: "ㄠ"
          - action: { character: { char: ";" } }
            label: "ㄤ"
          - action: { characterMargin: { char: ";" } }
            width: available
      - keys:
          - action: { character: { char: "z" } }
            label: "ㄈ"
          - action: { character: { char: "x" } }
            label: "ㄌ"
          - action: { character: { char: "c" } }
            label: "ㄏ"
          - action: { character: { char: "v" } }
            label: "ㄒ"
          - action: { character: { char: "b" } }
            label: "ㄖ"
          - action: { character: { char: "n" } }
            label: "ㄙ"
          - action: { character: { char: "m" } }
            label: "ㄩ"
          - action: { character: { char: "," } }
            label: "ㄝ"
          - action: { character: { char: "." } }
            label: "ㄡ"
          - action: { character: { char: "/" } }
            label: "ㄥ"
          - action: backspace
            swipe:
              - direction: up
                action: { shortcutCommand: "#重输" }
      - keys:
          - action: { keyboardType: numericNineGrid }
            width: { percentage: 0.13 }
          - action: { keyboardType: classifySymbolic }
            width: { percentage: 0.13 }
          - action: space
            width: available
            label:
              loadingText: "仓输入法"
              text: "空格"
          - action: { character: { char: "，" } }
            label: "，"
            swipe:
              - direction: up
                action: { character: { char: "。" } }
                display: true
          - action: { keyboardType: alphabetic }
            width: { percentage: 0.13 }
          - action: enter
            width: { percentage: 0.19 }
  - name: "声笔trime"
    isPrimary: true
    buttonInsets: { left: 2, bottom: 3, top: 3, right: 2 }
    rows:
      - keys:
          - action: { character: { char: "1" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "!" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "2" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "@" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "3" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "#" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "4" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "$" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "5" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "%" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "6" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "^" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "7" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "&" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "8" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "*" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "9" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "(" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "0" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: ")" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 0
      - keys:
          - action: { character: { char: "q" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: Q
            swipe:
              - action: { character: { char: "`" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "w" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: W
            swipe:
              - action: { character: { char: "~" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "e" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: E
            swipe:
              - action: { character: { char: "+" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "r" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: R
            swipe:
              - action: { character: { char: "-" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "t" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: T
            swipe:
              - action: { character: { char: "=" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "7" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "&" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "8" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "(" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "9" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: ")" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "-" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "y" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: Y
            swipe:
              - action: { character: { char: "_" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "u" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: U
            swipe:
              - action: { character: { char: "{" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "i" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: I
            swipe:
              - action: { character: { char: "}" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "o" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: O
            swipe:
              - action: { character: { char: "[" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "p" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: P
            swipe:
              - action: { character: { char: "]" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: { character: { char: "a" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: A
            swipe:
              - action: { character: { char: '\' } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "s" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: S
            swipe:
              - action: { character: { char: "|" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "d" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: D
            swipe:
              - action: { character: { char: "×" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "f" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: F
            swipe:
              - action: { character: { char: "÷" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "g" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: G
            swipe:
              - action: { character: { char: "↓" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "4" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "$" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "5" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "%" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "6" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "^" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "+" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "h" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: H
            swipe:
              - action: { character: { char: "↑" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "j" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: J
            swipe:
              - action: { character: { char: "←" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "k" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: K
            swipe:
              - action: { character: { char: "→" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "l" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: L
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Control+l" } } }
                label: 快改
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: ";" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            swipe:
              - action: { character: { char: ":" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: shift
            width:
              portrait: { percentage: 0.15 }
              landscape: { percentage: 0.08 }
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Tab" } } }
                label: ⇥
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: { sendKeys: { keys: "Tab" } } }
                label: ⇥
                display: false
                processByRIME: true
                direction: down
          - action: { character: { char: "z" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: Z
            swipe:
              - action: { shortcutCommand: "#重输" }
                label: 清空
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "x" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: X
            swipe:
              - action: { shortcutCommand: "#剪切" }
                label: 剪切
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "c" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: C
            swipe:
              - action: { shortcutCommand: "#复制" }
                label: 复制
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "v" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: V
            swipe:
              - action: { shortcutCommand: "#粘贴" }
                label: 粘贴
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "1" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "!" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "2" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "@" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "3" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "#" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "*" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "b" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: B
            swipe:
              - action: { keyboardType: classifySymbolic }
                label: 符号
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "n" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: N
            swipe:
              - action: { shortcutCommand: "#RimeSwitcher" }
                label: 开关
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "m" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: M
            swipe:
              - action: { shortcutCommand: "#关闭键盘" }
                label: 键盘
                display: true
                processByRIME: true
                direction: up
          - action: backspace
            width: { percentage: 0.15 }
            swipe:
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Shift+Return" } } }
                display: false
                processByRIME: true
                direction: up
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Control+Delete" } } }
                label: 删词
                display: false
                processByRIME: true
                direction: down
              - action: { shortcutCommand: "#重输" }
                label: 清空
                display: false
                processByRIME: true
                direction: left
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: { keyboardType: numericNineGrid }
            width:
              portrait: { percentage: 0.15 }
              landscape: { percentage: 0.08 }
            label: "123"
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Shift+Tab" } } }
                label: ⇤
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: { sendKeys: { keys: "Shift+Tab" } } }
                display: false
                processByRIME: true
                direction: down
          - action: { character: { char: "/" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "?" } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#繁简切换" }
                display: true
                processByRIME: true
                direction: down
          - action: { character: { char: "," } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "<" } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#行首" }
                label: 行首
                display: true
                processByRIME: true
                direction: down
          - action: space
            width:
              portrait: { percentage: 0.3 }
              landscape: { percentage: 0.14 }
            swipe:
              - action: { shortcutCommand: "#中英切换" }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#左移" }
                display: false
                processByRIME: true
                direction: left
              - action: { shortcutCommand: "#右移" }
                display: false
                processByRIME: true
                direction: right
          - action: { character: { char: "=" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "0" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "÷" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: space
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.14 }
            swipe:
              - action: { shortcutCommand: "#中英切换" }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "." } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: ">" } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#行尾" }
                label: 行尾
                display: true
                processByRIME: true
                direction: down
          - action: { character: { char: "'" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: '"' } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#上个输入方案" }
                label: 方案
                display: true
                processByRIME: true
                direction: down
          - action: enter
            width: { percentage: 0.15 }
            swipe:
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Control+Return" } } }
                display: false
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
  - name: "声笔46"
    isPrimary: true
    buttonInsets: { left: 2, bottom: 3, top: 3, right: 2 }
    rows:
      - keys:
          - action: { character: { char: "1" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "!" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "2" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "@" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "3" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "#" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "4" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "$" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "5" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "%" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "6" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "^" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "7" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "&" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "8" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "*" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "9" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: "(" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "0" } }
            width: { percentage: 0.1 }
            swipe:
              - action: { character: { char: ")" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 0
      - keys:
          - action: { character: { char: "q" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: Q
            swipe:
              - action: { character: { char: "`" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "w" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: W
            swipe:
              - action: { character: { char: "~" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "e" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: E
            swipe:
              - action: { character: { char: "+" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "r" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: R
            swipe:
              - action: { character: { char: "-" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "t" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: T
            swipe:
              - action: { character: { char: "=" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "7" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "&" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "8" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "(" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "9" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: ")" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "-" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "y" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: Y
            swipe:
              - action: { character: { char: "_" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "u" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: U
            swipe:
              - action: { character: { char: "{" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "i" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: I
            swipe:
              - action: { character: { char: "}" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "o" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: O
            swipe:
              - action: { character: { char: "[" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "p" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: P
            swipe:
              - action: { character: { char: "]" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: { character: { char: "a" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: A
            swipe:
              - action: { character: { char: '"' } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "s" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: S
            swipe:
              - action: { character: { char: "|" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "d" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: D
            swipe:
              - action: { character: { char: "×" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "f" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: F
            swipe:
              - action: { character: { char: "÷" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "g" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: G
            swipe:
              - action: { character: { char: "↓" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "4" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "$" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "5" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "%" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "6" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "^" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "+" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "h" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: H
            swipe:
              - action: { character: { char: "↑" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "j" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: J
            swipe:
              - action: { character: { char: "←" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "k" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: K
            swipe:
              - action: { character: { char: "→" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "l" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: L
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Control+l" } } }
                label: 快改
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: ";" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            swipe:
              - action: { character: { char: ":" } }
                display: true
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: { character: { char: "z" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            label: Z
            swipe:
              - action: { shortcutCommand: "#重输" }
                label: 清空
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "x" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: X
            swipe:
              - action: { shortcutCommand: "#剪切" }
                label: 剪切
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "c" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: C
            swipe:
              - action: { shortcutCommand: "#复制" }
                label: 复制
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "v" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: V
            swipe:
              - action: { shortcutCommand: "#粘贴" }
                label: 粘贴
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "b" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: B
            swipe:
              - action: { keyboardType: classifySymbolic }
                label: 符号
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "1" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "!" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "2" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "@" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "3" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "#" } }
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "*" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "n" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: N
            swipe:
              - action: { shortcutCommand: "#RimeSwitcher" }
                label: 开关
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "m" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            label: M
            swipe:
              - action: { shortcutCommand: "#关闭键盘" }
                label: 键盘
                display: true
                processByRIME: true
                direction: up
          - action: { character: { char: "," } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: "<" } }
                display: true
                processByRIME: true
                direction: up
              - action: nextKeyboard
                label: 🌐
                display: true
                processByRIME: true
                direction: down
          - action: { character: { char: "." } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: ">" } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#上个输入方案" }
                label: 方案
                display: true
                processByRIME: true
                direction: down
          - action: { character: { char: "/" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.08 }
            swipe:
              - action: { character: { char: "?" } }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#繁简切换" }
                display: true
                processByRIME: true
                direction: down
        rowHeight:
          portrait: 50
          landscape: 40
      - keys:
          - action: { keyboardType: numericNineGrid }
            width:
              portrait: { percentage: 0.15 }
              landscape: { percentage: 0.08 }
            label: "123"
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Shift+Tab" } } }
                label: ⇤
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: { sendKeys: { keys: "Shift+Tab" } } }
                display: false
                processByRIME: true
                direction: down
          - action: shift
            width:
              portrait: { percentage: 0.15 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { shortcutCommand: { sendKeys: { keys: "Tab" } } }
                label: ⇥
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: { sendKeys: { keys: "Tab" } } }
                display: false
                processByRIME: true
                direction: down
          - action: { character: { char: "'" } }
            width:
              portrait: { percentage: 0.1 }
              landscape: { percentage: 0.07 }
            swipe:
              - action: { character: { char: '"' } }
                display: true
                processByRIME: true
                direction: up
          - action: space
            width:
              portrait: { percentage: 0.3 }
              landscape: { percentage: 0.14 }
            swipe:
              - action: { shortcutCommand: "#中英切换" }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#左移" }
                display: false
                processByRIME: true
                direction: left
              - action: { shortcutCommand: "#右移" }
                display: false
                processByRIME: true
                direction: right
          - action: { character: { char: "=" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "0" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: { character: { char: "÷" } }
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.07 }
          - action: space
            width:
              portrait: { percentage: 0 }
              landscape: { percentage: 0.14 }
            swipe:
              - action: { shortcutCommand: "#中英切换" }
                display: true
                processByRIME: true
                direction: up
              - action: { shortcutCommand: "#左移" }
                display: true
                processByRIME: true
                direction: left
              - action: { shortcutCommand: "#右移" }
                display: true
                processByRIME: true
                direction: right
          - action: backspace
            width:
              portrait: { percentage: 0.15 }
              landscape: { percentage: 0.14 }
            swipe:
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Shift+Return" } } }
                display: false
                processByRIME: true
                direction: up
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Control+Delete" } } }
                label: 删词
                display: false
                processByRIME: true
                direction: down
              - action: { shortcutCommand: "#重输" }
                label: 清空
                display: false
                processByRIME: true
                direction: left
          - action: enter
            width: { percentage: 0.15 }
            swipe:
              - action:
                  { shortcutCommand: { sendKeys: { keys: "Control+Return" } } }
                display: false
                processByRIME: true
                direction: up
        rowHeight:
          portrait: 50
          landscape: 40
```

## 工具

感谢 @lost-melody 开发的自定义键盘工具。

[https://lost-melody.github.io/hamster-tools](https://lost-melody.github.io/hamster-tools)


