---
source: rime-squirrel-wiki/在Squirrel使用上思源字體.md
title: 在Squirrel使用上思源字體
---

最近炒得比較火的思源字體, 樣子真的是很漂亮.

接下來, 我就分享下怎麼在Squirrel使用上思源字體.

首先, 下載 [Source Han Sans](http://tcpdiag.dl.sourceforge.net/project/source-han-sans.adobe/SourceHanSansTWHK-1.000.zip).

``` bash
cd ~/Library/Rime
mvim squirrel.custom.yaml
```

然後, 將以下的Copy過去
``` yaml
patch:
  "style/font_face": "Source Han Sans TWHK"
  "style/font_point": 28
```

'骨頭'的對比圖

1. 使用前

    ![使用前](https://cloud.githubusercontent.com/assets/5491695/3866802/19314e1a-1fe3-11e4-9612-71014180f980.png)

2. 使用後

    ![使用後](https://cloud.githubusercontent.com/assets/5491695/3866801/192feda4-1fe3-11e4-8600-8855963be233.png)
