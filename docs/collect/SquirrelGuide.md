---
source: rime-collect/鼠鬚管介面配置指南.md
---

# 鼠鬚管介面配置指南

## Style

此處配置皆可於方案配置內覆寫，同樣使用`style`關鍵詞，方案內配置優先

* `font_face`: 字體名稱，可多個，以`，`分隔
* `label_font_face`: 同上，控制序號
* `comment_font_face`: 同上，控制注疏
* `font_point`: 字號，可帶小數
* `label_font_point`: 同上，控制序號
* `comment_font_point`: 同上，控制注疏
* `inline_preedit`: 鍵入碼顯示位置，`true`者直接顯示於鍵入位點，`false`者與候選詞同框內顯示，默認`false`
* `inline_candidate`: 選中詞顯示位置，`true`者直接顯示於鍵入位點，`false`者不插入鍵入位點，默認`false`。此項與上一項相互獨立，可有 4 種組合，同爲`true`時鍵入位點插入候選詞，默認`false`
* `candidate_list_layout`: 候選框樣式，`linear`者爲線型，各候選首尾相連成一串，`stacked`者各候選皆另起一行，呈堆疊狀。默認`stacked`
* `text_orientation`: 候選框文字方向，`horizontal`者橫排自左至右，`vertical`者豎排自右至左。默認`horizontal`
* `candidate_format`: 候選項格式，`%c`爲序號，`%@`爲詞，默認`%c. %@`
* `memorize_size`: 選定線型候選框樣式時，當候選框末端接觸屏幕邊時，是否記住候選框長度，以選免首選項位置快速變化，`true`/`false`，默認`false`
* `translucency`: 是否添加毛玻璃背景，當背景色呈半透明時可見，`true`/`false`，默認`false`
* `border_height`, `border_width`，邊框粗細，如未設邊框色，則僅影響佈局。可帶小數，可爲負。默認 0
* `corner_radius`: 外框圓角半徑，可帶小數。默認 0
* `hilited_corner_radius`: 候選項背景框圓角半徑，可帶小數，通常小於上一項。默認 0
* `surrounding_extra_expansion`: 非高亮（選中）候選項背景框大小縮放，`0`即與高亮框相同，負數縮小，正數放大。默認 0
* `line_spacing`: 行間距，可帶小數，可爲負。默認 0
* `spacing`: 鍵入碼區與候選項區之間的間距，可帶小數，可爲負。默認 0
* `base_offset`: 文字垂直方向位置調整，正數向上（右），負數向下（左）。默認 0
* `alpha`: 候選框整體透明度，0-1 範圍。默認 1
* `color_scheme`: 配色方案名（明主題下），於`preset_color_schemes`下設定
* `color_scheme_dark`: 同上，暗主題下

## preset_color_schemes

以下色格式皆爲`AABBGGRR`，十六進制不區分大小寫，A 者透明度，B 者藍，G 者綠，R 者赤。A 可省，省時不透明

此處可覆寫以上`style`配置，此處優先

* `name`: 方案名，無實際作用
* `author`: 作者，無實際作用
* `color_space`: 色空間，`display_p3`或`sRGB`，默認`sRGB`
* `back_color`: 整體候選框底色
* `border_color`: 整體候選框描邊色
* `candidate_text_color`: 候選詞字色
* `comment_text_color`: 候選詞注疏字色
* `label_color`: 候選詞序號字色
* `candidate_back_color`: 候選詞底色
* `hilited_candidate_text_color`: 高亮（選中）候選詞字色
* `hilited_comment_text_color`: 高亮（選中）候選詞注疏字色
* `hilited_candidate_label_color`: 高亮（選中）候選詞序號字色
* `hilited_candidate_back_color`: 高亮（選中）候選詞底色
* `preedit_back_color`: 鍵入碼區底色
* `text_color`: 鍵入碼字色
* `hilited_text_color`: 高亮（選中）鍵入碼字色
* `hilited_back_color`: 高亮（選中）鍵入碼底色
