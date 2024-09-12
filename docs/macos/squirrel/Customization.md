---
source: rime-squirrel-wiki/squirrel.yaml-配置指南.md
title: squirrel.yaml 配置指南
---

## 鼠鬚管介面定製指南

* 此處列出所有可用之選項，以便使用鼠鬚管的各位自定義喜歡的樣式。示例請參攷[自帶squirrel.yaml](https://github.com/rime/squirrel/blob/master/data/squirrel.yaml)，定製時請使用`squirrel.custom.yaml`文件patch   
* **一般用戶請不要直接修改`squirrel.yaml`，否則可能丢失修改的內容，切記**   
* `squirrel.custom.yaml`的使用方式非常靈活，在此提供一些參攷：[LEO Yoon-Tsaw的squirrel.custom.yaml](https://github.com/LEOYoon-Tsaw/Rime_collections/blob/master/squirrel.custom.yaml)

---

* keyboard_layout: `last`/`default`或具體鍵板布局名   
  `last`即最近一次使用的鍵板布局   
  `default`即 US (ABC) 布局   
  具體鍵板名如`com.apple.keylayout.USExtended`或其簡寫`USExtended`   
 
* app_options
  * ascii_mode: 初始爲西文模式
  * no_inline: 不使用行內編輯
  * inline: 強制使用行內編輯
  * vim_mode: 退出 VIM 插入模式自動切換輸入法狀態

* chord_duration: 如`0.1`，單位爲秒
* show_notifications_when: `always`/`never`，是否顯示切換方案或開關狀態時的通知

* style
  * color_scheme: 配色名，須存在于`preset_color_schemes`之中
  * color_scheme_dark: （可選）黑暗模式下的配色名，須存在于`preset_color_schemes`之中，未指定則始終使用`color_scheme`所指定的配色
  * candidate_format: 以`[label]`指代序號，`[candidate]`指代候選詞，`[comment]`指代注釋，可另加任意其它字符，也可多次重復出現   
    例如`[label]. [candidate] [comment]`

  * candidate_list_layout: `stack`/`linear`，候選詞堆疊或平鋪顯示
  * text_orientation: `horizontal`/`vertical`，文字橫排或縱排
    || stack | linear |
    |:---:|:---:|:---:|
    | **horizontal** | 智能ABC | 流行輸入法 |
    | **vertical** | Rime獨有 | Rime獨有 |
  * inline_preedit: `true`/`false` 是否行內編輯
  * inline_candidate: `true`/`false` 是否行內顯示第一候選
    |  | inline_candidate: true | false |
    |:---:|:---:|:---:|
    | **inline_preedit: true** | 第一候選及未成字編碼皆行內顯示，候選框沒有編輯區 | 輸入碼行內顯示，候選框沒有編輯區 |
    | **false** | 第一候選行內顯示，候選框有編輯區 | 行內顯示空白佔位符，候選框有編輯區 |
  * memorize_size: `true`/`false` 一次輸入過程中，候選框觸及屏幕邊緣時**是否**粘住不再縮回，避免來回跳動
  * mutual_exclusive: `true`/`false` 候選區各背景色**是否**各自獨立，帶透明度的情況下互不浸染
  * translucency: `true`/`false` 是否添加毛玻璃背景（需配合透明背景色才得看到）
  
  * corner_radius: 非負數，候選外框圓角大小
  * hilited_corner_radius: 非負數，高亮區圓角大小（包括高亮候選詞和高亮編輯區）
  * border_height: 可正可負，邊緣高度，爲負時可收窄圓角造成的避讓留白
  * border_width: 可正可負，邊緣寬度，爲負時可收窄圓角造成的避讓留白
  * line_spacing: 可正可負，文字行間距
  * spacing: 可正可負，候選框內編輯區與候選區之間的間距
  * base_offset: 可正可負，文字基線高度調節
  * shadow_size: 非負數，非零則爲高亮候選詞增添陰影
  * surrounding_extra_expansion: 可正可負，若設置了`candidate_back_color`，調節非高亮候選詞背景相對於高亮背景的大小。正則更大，負更更小

  * font_face: 字體，可設多個，以`,`間隔不同字體，以`-`加註粗細。[鼠鬚管：如何查找合用字體之名](https://github.com/rime/squirrel/wiki/鼠鬚管：如何查找合用字體之名)
  * font_point: 字號
  * label_font_face: （可選）序號專用字體，如未設置則使用`font_face`
  * label_font_point: （可選）序號專用字號，如未設置則使用`font_point`
  * comment_font_face: （可選）註釋專用字體，如未設置則使用`font_face`
  * comment_font_point: （可選）註釋專用字號，如未設置則使用`font_point`

* preset_color_schemes: 配色方案列於此項下
  * name: 名稱，無實際效果，僅供展示
  * author: 作者，無實際效果，僅供展示
  * color_space: `display_p3`/`srgb` 色值所用色域
  * back_color: 候選框背景色
  * border_color: 候選框邊框色（邊框粗細爲`border_height`、`border_width`中小者，小于零則不顯示）
  * preedit_back_color: 編輯區背景色
  * text_color: 編輯區（非高亮）編碼色
  * hilited_back_color: 編輯區高亮背景色
  * hilited_text_color: 編輯區高亮編碼色
  * candidate_back_color: 候選詞背景色
  * candidate_text_color: 候選詞色
  * label_color: 候選序號色
  * comment_text_color: 候選註釋色
  * hilited_candidate_back_color: 高亮候選詞背景色
  * hilited_candidate_text_color: 高亮候選詞色
  * hilited_candidate_label_color: 高亮候選序號色
  * hilited_comment_text_color: 高亮候選註釋色
  * `style`中除`color_scheme`、`color_scheme_dark`外其餘諸項亦可於此覆蓋
