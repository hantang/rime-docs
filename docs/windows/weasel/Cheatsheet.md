---
source: rime-weasel-wiki/weasel.yaml-速查.md
title: weasel.yaml 速查
---

`weasel.yaml` 速查

```yaml
# Weasel settings
# encoding: utf-8

config_version: "0.25"   # 版本号大于等于预置文件版本号时，才能生效

# [app_options]
# 针对特定应用的设置
app_options:
  cmd.exe:               # 带 .exe 的进程名：Weasel 15.0 及之前版本须小写; PR #1049 合并后释出的版本大小写不敏感
    ascii_mode: true     # 英文模式
  firefox.exe:
    inline_preedit: true # 行内显示预编辑区 refer <https://github.com/rime/weasel/issues/946>
  nvim-qt.exe:
    ascii_mode: true
    vim_mode: true       # vim 模式, Esc <C-c> <C-[> 切换到 ascii 状态
# [End of <app_options>]

# [global settings]
show_notifications: true                   # 是否显示状态变化的通知：true；false；option_list（方案内的开头 option name）
show_notifications_time: 1200              # 通知显示的时间，单位 ms
global_ascii: false                        # 切换为 ascii 模式时，是否影响所有窗口：true；false
# [End of <global settings>]

# [style]
# 字体；候选项、候选窗口的行为、布局及样式
style:
  color_scheme: aqua                       # 默认配色方案
  # color_scheme_dark: dark_temple         # 深色模式下，Weasel 的配色方案，Windows 10 1809+ 可用

  font_face: "Microsoft YaHei"             # 全局字体
  label_font_face: "Microsoft YaHei"       # 标签字体
  comment_font_face: "Microsoft YaHei"     # 注释字体
  font_point: 14                           # 全局字体字号
  label_font_point: 14                     # 标签字体字号
  comment_font_point: 14                   # 注释字体字号

  inline_preedit: false                    # 行内显示预编辑区：true；false
  preedit_type: composition                # 预编辑区内容：composition（编码）； preview（选中的候选）；preview_all（全部候选）
  
  fullscreen: false                        # 候选窗口全屏显示：true；false
  horizontal: false                        # 候选项横排：true；false
  vertical_text: false                     # 竖排文本：true；false
  # text_orientation: horizontal           # 文本排列方向，效果和 `vertical_text` 相同：horizontal；vertical
  vertical_text_left_to_right: false       # 竖排方向是否从左到右：true；false
  vertical_text_with_wrap: false           # 文本竖排模式下，自动换行：true；false
  vertical_auto_reverse: false             # 文本竖排模式下，候选窗口位于光标上方时倒序排列：true；false
  
  label_format: "%s."                      # 标签字符：例如 %s. -> 1. 2. 3. | %s: -> 1: 2: 3:
  mark_text: ""                            # 标记字符，显示在选中的候选标签前，需要在配色方案中指定颜色；如该项为空字符串 "" 而配色方案中 hilited_mark_color 非透明色，则显示类似 Windows 11 输入法的标记
  ascii_tip_follow_cursor: false           # 切换 ASCII 模式时，提示跟随鼠标，而非输入光标
  enhanced_position: false                 # 无法定位候选框时，在窗口左上角显示候选框：true；false
  display_tray_icon: false                 # 托盘显示独立于语言栏的额外图标：true；false
  antialias_mode: default                  # 次像素反锯齿设定：default；force_dword；cleartype；grayscale；aliased
  candidate_abbreviate_length: 0           # 候选项略写，超过此数字则用省略号代替。设置为 0 则不启用此功能
  mouse_hover_ms: 0                        # 【已弃用】鼠标悬停选词响应时间（ms），设置为 0 时禁用该功能
  hover_type: none                         # 鼠标在候选窗口悬停时：none（无动作）；hilite（选中鼠标下的候选）；semi_hilite（高亮鼠标下的候选）
  paging_on_scroll: false                  # 在候选窗口上滑动滚轮的行为：true（翻页）；false （选中下一个候选）
  click_to_capture: false                  # 鼠标点击候选项，创建截图：true；false

  layout:
    baseline: 0                            # 字号百分比，与 linespacing 一同设置可解决字体跳动问题，设置为 0 为禁用
    linespacing: 0                         # 字号百分比，参考 <https://github.com/rime/weasel/pull/1177>
    align_type: center                     # 标签、候选文字、注解文字之间的相对对齐方式：top ; center ; bottom
    max_height: 0                          # 候选框最大高度，文本竖排模式下如高度超此尺寸则换列显示候选，设置为 0 不启用此功能
    max_width: 0                           # 候选框最大宽度，horizontal 布局如宽超此尺寸则换行显示候选，设置为 0 不启用此功能
    min_height: 0                          # 候选框最小高度
    min_width: 160                         # 候选框最小宽度
    border_width: 3                        # 边框宽度；又名 border
    margin_x: 12                           # 主体元素和候选框的左右边距；为负值时，不显示候选框
    margin_y: 12                           # 主体元素的上下边距；为负值时，不显示候选框
    spacing: 10                            # inline_preedit 为否时，编码区域和候选区域的间距
    candidate_spacing: 5                   # 候选项之间的间距
    hilite_spacing: 4                      # 候选项和相应标签的间距
    hilite_padding: 2                      # 高亮区域和内部文字的间距，影响高亮区域大小
    # hilite_padding_x: 8                  # 高亮区域和内部文字的左右间距，如无特殊指定则依 hilite_padding 设置
    # hilite_padding_y: 8                  # 高亮区域和内部文字的上下间距，如无特殊指定则依 hilite_padding 设置
    shadow_radius: 0                       # 阴影区域半径，为 0 不显示阴影；需要同时在配色方案中指定非透明的阴影颜色
    shadow_offset_x: 4                     # 阴影左右偏移距离
    shadow_offset_y: 4                     # 阴影上下偏移距离
    corner_radius: 4                       # 候选窗口圆角半径
    round_corner: 4                        # 候选背景色块圆角半径，又名 hilited_corner_radius
    # type: vertical                       # 布局设置，效果和 style 下的设置相同：horizontal（横向）；vertical（竖向） ; vertical_text（竖排文本） ; vertical+fullscreen（全屏） ; horizontal+fullscreen（横向全屏）
# [End of <style>]

# [preset_color_schemes]
# 配色设定
preset_color_schemes:
  aqua:                                           # 在 style/color_schema 指定的配色方案值
    name: 碧水／Aqua                               # 方案设置中显示的配色名称
    author: 佛振 <chen.sst@gmail.com>             # 配色作者名称
    # color_format: abgr                          # 颜色格式：argb；rgba；abgr（默认）
    text_color: 0x000000                          # 默认文字颜色
    # comment_text_color: 0x000000                # 注释文字颜色
    # label_color: 0x000000                       # 标签文字颜色
    back_color: 0xeceeee                          # 候选窗背景色
    shadow_color: 0x00000000                      # 候选窗阴影色
    border_color: 0xe0e0e0                        # 候选窗边框颜色
    hilited_text_color: 0x000000                  # 编码文字颜色
    hilited_back_color: 0xd4d4d4                  # 编码背景颜色
    hilited_shadow_color: 0x00000000              # 编码背景块阴影颜色
    hilited_candidate_text_color: 0xffffff        # 高亮候选文字颜色
    hilited_candidate_back_color: 0xfa3a0a        # 高亮候选背景颜色
    hilited_candidate_shadow_color: 0x00000000    # 高亮候选背景块阴影颜色
    # hilited_candidate_border_color: 0xe0e0e0    # 高亮候选边框颜色
    # hilited_label_color: 0x000000               # 高亮候选的标签颜色
    # hilited_mark_color: 0x000000                # 高亮候选前的标记颜色
    # hilited_comment_text_color: 0x000000        # 高亮候选的注释颜色
    candidate_text_color: 0x000000                # 非高亮候选文字颜色
    candidate_back_color: 0xeceeee                # 非高亮候选背景颜色
    candidate_shadow_color: 0x00000000            # 非高亮候选背景块阴影颜色
    # candidate_border_color: 0xe0e0e0            # 非高亮候选的边框颜色
    # nextpage_color: 0x00000000                  # inline_preedit: false 翻页箭头颜色：下一页；不设置则不显示箭头
    # prevpage_color: 0x00000000                  # inline_preedit: false 翻页箭头颜色：上一页；不设置则不显示箭头

# [end of <preset_color_schemes>]
```
