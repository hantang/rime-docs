---
source: rime-trime-wiki/Theme-Configuration-(New).md
title: 主题配置（新）
---

上次更新时间：2025.10.16

# 主题配置（新）

## 必知必会

同文的主题配置目前基于 YAML 配置语言，并支持由 RIME 引擎扩展的编译指令。因此你需要：

- 了解 YAML 语言，可参考阮一峰的[《YAML 语言教程》](https://www.ruanyifeng.com/blog/2016/07/yaml.html)
- 了解 RIME 引擎扩展的编译指令，可参考[《Rime 配置文件》](https://github.com/rime/home/wiki/Configuration)说明
- 参考通用定制案例和技巧，可参考[《Rime 定制指南》](https://github.com/rime/home/wiki/CustomizationGuide)

> [!NOTE]
> **注意**：新主题配置是指自 2025 年 9 月 13 日及之后新增的主题参数，即本文档所记载的内容。

> [!NOTE]
> **注意**：尽管同文会试图尽可能保持配置的稳定性，但随着项目的发展的需要，这些配置文件的格式仍可能发生扩展或变更，
> 配置文件中的参数仍可能增添、更改或废弃。请及时参考本文档，若发现实际行为与本文档中所记载的不一致，
> 请以实际为准，并通过 [Issues](https://github.com/osfans/trime/issues) 或者社群反馈给我们。

## 一、预编辑区（`preedit`）

预编辑区用来显示未上屏前的输入的编码，比如“ni’hao”。当启用“在程序中显示撰写文本”后，预编辑区会被隐藏。

> 相关拉取请求：[PR#1751](https://github.com/osfans/trime/pull/1751)

预编辑区样式包含以下属性：

|属性|类型|说明|
|--|--|--|
|`horizontal_padding`|整数|（可选）预编辑区水平（左右两侧）内距（默认值：8）|
|`top_end_radius`|浮点|（可选）预编辑区末上端圆角半径（末端方向取决于系统语言的书写方向；默认值：0）|
|`alpha`|浮点|（可选）预编辑区透明度（默认值：0.8，范围：0.0 - 1.0）|
|`foreground`|对象|（可选）预编辑区前景样式|

### 前景样式

前景样式 `foreground` 包含以下属性：

|属性|类型|说明|
|--|--|--|
|`font_size`|浮点|（可选）预编辑区文字大小（默认值：16）|

## 二、候选窗口（悬浮窗口，`window`）

候选窗口用来在设备接入物理接盘时显示候选词。用户也可以启用“始终显示”与虚拟键盘一同使用，此时工具栏区将不再显示候选词。

> 相关拉取请求：[PR#1751](https://github.com/osfans/trime/pull/1751)

候选窗口样式包含以下属性：

|属性|类型|说明|
|--|--|--|
|`insets`|对象|（可选）候选窗口内距（默认值：`vertical` 和 `horizontal` 均为 4）|
|`item_padding`|对象|（可选）候选窗口候选词内距（默认值：`vertical`：2，`horizontal`：4）|
|`foreground`|对象|（可选）候选窗口前景样式|

### 内距

候选窗口内距 `insets` 和其中的候选词内距 `item_padding` 包含以下属性：

|属性|类型|说明|
|--|--|--|
|`vertival`|整数|（可选）纵向内距（内容距离布局上下两侧边界的距离）|
|`horizontal`|整数|（可选）横向内距（内容距离布局左右两侧边界的距离）|

### 前景样式

前景样式 `foreground` 包含一下属性：

|属性|类型|说明|
|--|--|--|
|`label_font_size`|浮点|（可选）候选词序号字体大小（默认值：20）|
|`text_font_size`|浮点|（可选）候选词文字字体大小（默认值：20）|
|`comment_font_size`|浮点|（可选）候选词注释字体大小（默认值：16）|

## 三、工具栏区（`tool_bar`）

工具栏区常显为功能按钮。当处于输入状态时，显示候选字。
> 相关拉取请求：[PR#1729](https://github.com/osfans/trime/pull/1729)

工具栏区样式包含以下属性：

|属性|类型|说明|
|--|--|--|
|`primary_button`|对象|工具栏主按键（左侧第一个）样式|
|`buttons`|对象数组|工具栏其他按键样式|
|`button_spacing`|整数|工具栏其他按键水平间隙|
|`button_font`|字符串或字符串数组|工具栏按键字体设置|

### 按钮样式

主按键 `primary_button` 样式和其他按键 `buttons` 中各按键样式包含以下属性：

|属性|类型|说明|
|--|--|--|
|`background`|对象|（可选）按键的背景样式|
|`foreground`|对象|（可选）按键的前景样式|
|`action`|字符串类型，对象引用|按键的动作，参见预设按键（`preset_keys`）一节|

#### 背景样式

背景样式 `background` 包含以下属性：

|属性|类型|说明|
|--|--|--|
|`type`|枚举|（可选）按键形状类型。可选值：rectangle（默认）、circle|
|`corner_radius`|浮点数|（可选）按键圆角|
|`bg_normal`|字符串类型，配色引用|（可选）一般状态下按键背景配色|
|`bg_hightlight`|字符串类型，配色引用|（可选）按下状态下按键背景配色|
|`vertical_inset`|整数|（可选）垂直方向上按键背景内距（距离上下两侧边框距离）|
|`horizontal_inset`|整数|（可选）垂直方向上按键背景内距（距离左右两侧边框距离）|

#### 前景样式

前景样式 `foreground` 包含以下属性：

|属性|类型|说明|
|--|--|--|
|`style`**¹**|字符串|按键图标样式，与 `option_styles` 二选一|
|`option_styles`|字符串数组|方案开关按键图标样式，与 `style` 二选一|
|`fg_normal`**²**|字符串类型，配色引用|（可选）一般状态下按键前景配色|
|`fg_highlight`**²**|字符串类型，配色引用|（可选）按下状态下按键前景配色|
|`font_size`|浮点数|（可选）按键文字大小|
|`size`|整数数组|（可选）按键宽度（数组中第一个值）和高度（数组中第二个值）|
|`padding`|整数|（可选）按键内距（距离上下左右边框距离）|

**¹** `style` 样式值和 `option_styles` 中各样式值有三种情况：
  1. 使用内置的 Community Material Design 图标。以 `ic@` 为前缀，后接相应图标名称；图标大小遵循 `font_size` 设置。查询图标名称点击[这里](https://pictogrammers.com/library/mdi/)，注意填入参数时使用下划线 `_` 代替短横杠 `-`。
  2. 使用图片。填入图片相对路径，支持 `png`、`jpg`、`webp` 和静态 `gif`。
  3. 使用图标文字。字体遵循 `button_font` 设置，字体大小遵循 `font_size` 设置。

**²** 曾经笔误为 `bg_normal` 和 `bg_hightlight`。
