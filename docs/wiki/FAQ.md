# 常見問題解答*

## 如何定製輸入法？

請查閱[定製指南|CustomizationGuide](./CustomizationGuide.md#定製指南)。

## macOS*

### 如何卸載鼠鬚管（Squirrel）？

1. 開啓系統輸入法設定面板，移除「鼠鬚管」。
2. 打開 Finder 並按下 command+shift+G 前往 `/Library/Input Methods` 檔案夾，移除「鼠鬚管.app」。
3. 如上，前往 `~/Library` 並移除個人鼠鬚管設定資料夾 `Rime`。
4. 重新登入系統，確保清理完畢。

## Linux*

### 如何使用雙拼時，啟動臺灣繁體習慣用字？（Linux + ibus或fcitx）

例如：

  ```plaintext
  爲→為
  啓→啟
  着→著
  裏→裡
  麪→麵 …等
  ```

1. 在方案Schema裡面，switches項目之下加：

  ```yaml
  - name: zh_tw  
    reset: 1
  ```

2. Schema檔案中再來多件一項simplifier項目（在reverse lookup下面位置），如下：

  ```yaml
  simplifier:  
    opencc_config: t2tw.json  
    option_name: zh_tw
  ```

3. 輸入引擎（ibus或fcitx）重新開啟後，就應該成功打出《麵包》、《裡面》等臺灣繁體字。  
（註：schema檔案在 `~/.config/ibus/rime/` 裡面）

## Windows*

Windows用戶的簡單設定方法：

1. 按下Windows鍵
2. 尋找【小狼毫輸入法設定】
3. 選擇【繁體正題】
