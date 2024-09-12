---
source: rime-weasel-wiki/为特定输入方案定制外观.md
---

# 为特定输入方案定制外观

小狼毫支持为特定输入方案定制图标和样式。

## 自定义图标

将图标文件（.ico）复制到小狼毫用户文件夹，然后在输入方案的配置文件的 `schema` 节点下，添加如下几行：

```yaml
schema:
  icon: <输入方案图标> # 又名 zhung_icon
  ascii_icon: <ASCII 模式图标>
  full_icon: <全角模式图标>
  half_icon: <半角模式图标>
```

您也可以在输入方案的补丁文件中自定义图标。例如，将明月拼音的输入方案图标调整为 `cn.ico`。首先，确保 `cn.ico` 文件在小狼毫用户目录下，然后，修改补丁文件 `luna_pinyin.custom.yaml` 如下：

```yaml
# luna_pinyin.custom.yaml
patch:
  "schema/icon": cn.ico
```

## 自定义样式

`weasel.yaml` style 节点下的大部分选项都可以写入某个特定方案中，使之覆盖全局设置。

以为朙月拼音单独设定配色方案为例，在输入方案中添加：

```yaml
# luna_pinyin.schema.yaml
style:
  color_scheme: google
```

或者在 luna_pinyin.custom.yaml 添加如下代码：

```yaml
# luna_pinyin.custom.yaml
patch:
  "style/color_scheme": google
```

这样，当使用其他输入方案时，小狼毫将使用全局配色方案；当切换到该方案时，小狼毫将会使用指定的配色方案。