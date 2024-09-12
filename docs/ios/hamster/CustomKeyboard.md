---
source: rime-hamster-wiki/自定义按键样式.md
# title: 自定义按键样式
---

# 自定义按键样式

「按键样式」是应用在「自定义键盘布局」的单个按键上的样式风格配置，整体上和「自定义键盘配色」相似，只是选项名称和部分类型有所差异。
键盘布局中引用的样式总是优先于当前应用的全局配色，但多数选项在不存在时会自动使用全局配色配置替补，少数会使用默认值。

## 配置路径

按键样式配置采取「先定义后引用」的模式。举例来说，想要在整体白色的键盘配色下，单独为回车键应用蓝色，则需要完成以下步骤：

- 首先参照「自定义键盘布局」和「自定义键盘配色」章节完成布局和整体配色的配置；
- 在键盘布局 `Keyboard` 模型下添加 `keyStyle` 节点，与 `name`、`rows`、`buttonInsets` 等同级；
- 在 `keyStyle` 节点下添加并定义好一个名为 `return-blue` 的样式，具体配置选参见后文；
- 找到键盘布局中关于回车键的定义，在其 `Key` 模型下增加 `lightModeStyleName` 和 `darkModeStyleName`，并将配置值填写为 `return-blue`；
- 在前面步骤中，可以定义明暗两个按键样式，然后在 `Key` 中分别指定明暗主题下的两种风格名称。

## 配置项列表及示例

- 注一：所有颜色值，都采用 _BGR_ 或 _ABGR_ 格式，填写形如 `0x00A5FF` 或 `0xFF00A5FF` 的 **字符串**，且颜色值使用 **大写字母和数字**。
- 注二：按键样式名需要满足 _YAML_ 的键名要求。如不理解，请严格遵照 **字母开头 (`[a-zA-Z]`)、完全由字母 (`[a-zA-Z]`)、数字 (`[0-9]`)、下划线 (`_`) 或中划线 (`-`) 构成** 的要求。

```yaml
keyboards:
- name: 天行键
  rows:
  - keys: []            # 省略了其他按键行配置
  - keys:
    - {}                # 省略本行其他按键
    - action: enter     # 回车键配置
      width: available
      label: return
      callout: []
      lightModeStyleName: return-blue-light     # 亮色按键样式引用
      darkModeStyleName: return-blue-dark       # 暗色按键样式引用
  keyStyle:                                     # 按键样式表定义, 当前键盘布局 (天行键) 的所有引用样式都在这里定义
    return-blue-dark:                           # 按键样式名称, 命名建议采用 [按键]-[风格]-[明暗] 格式
      buttonBackgroundColor: '0xFE873A'                     # 按键背景颜色
      pressedButtonBackgroundColor: '0xFE6100'              # 按键按下时的背景颜色
      buttonForegroundColor: '0xFFFFFF'                     # 按键字符颜色
      fontSize: 16                                          # 按键字符大小
      pressedButtonForegroundColor: '0xFFFFFF'              # 按键按下时的字符颜色
      swipeFontSize: 8                                      # 按键按下时的字符大小
      swipeForegroundColor: '0xFFFFFF'                      # 按键上下划动字符的颜色
      pressedSwipeForegroundColor: '0xFFFFFF'               # 按键按下时上下划动字符的颜色
      cornerRadius: 10                                      # 按键圆角半径
      borderSize: 1                                         # 按键边框宽度
      borderColor: '0xFFFFFF'                               # 按键边框颜色
      lowerEdgeColor: '0x000000'                            # 按键底部立体边框颜色
      shadowSize: 0                                         # 按键阴影大小
      shadowColor: '0x000000'                               # 按键阴影颜色
      buttonBubbleBackgroundColor: '0xFE6100'               # 按键按下时的气泡背景颜色
      actionCalloutBackgroundColor: '0xFE6100'              # 按键长按时弹出气泡的背景颜色
      actionCalloutSelectedBackgroundColor: '0x7DFFA774'    # 按键长按时弹出气泡中已选中项的背景颜色
      actionCalloutSelectedForegroundColor: '0xFFFFFF'      # 按键长按时弹出气泡中已选中项的字符颜色
    return-blue-light: {} # 省略
```
