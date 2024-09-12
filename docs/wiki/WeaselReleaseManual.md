# weasel 發佈手冊

TODO: 更新該文檔，以反映自動化發佈流程

1.  在 [Trello](https://trello.com/b/iUJWFnjb/rime-development) 或筆記本上闢一葉紙，記下主要更新內容，方便粘貼到更新日誌。
    例如 https://trello.com/c/WieadeZt
1.  對比上次發佈（git tag），檢查 `weasel.yaml` 是否需要更新版本號。
    注：檢查配置更新的機制改動後，這一步不嚴格要求。但仍建議更新小狼毫配置同時升級該配置文件的版本。
1.  代碼交齊後，用工具根據慣例格式生成變更記錄。（這一步合併到 `update/bump-version.sh` 腳本中）
    以 clog-cli 爲例，爲新版本 0.11.0 生成變更記錄，做法是
    ``` sh
    # cargo install clog-cli
    cd weasel
    clog --from-latest-tag \
        --changelog CHANGELOG.md \
        --repository https://github.com/rime/weasel \
        --setversion 0.11.0
    ```
1.  把手寫的「主要更新」列在變更記錄文件中本次發佈的標題下，格式（包括空行）須與自動生成的段落相同：
    ``` markdown
    <a name="0.11.0"></a>
    ## 0.11.0 (2018-04-07)


    #### 主要更新

    * 新增 [Rime 配置管理器](https://github.com/rime/plum)，通過「輸入法設定／獲取更多輸入方案」調用
    * 在輸入法語言欄顯示狀態切換按鈕（TSF 模式）
    * 修復多個前端兼容性問題
    * 新增配色主題「現代藍」`metroblue`、「幽能」`psionics`

    #### Features
    ```
1.  提交對變更記錄的修改（可以與版本號的修改合併爲一條提交記錄）
    ``` sh
    git commit --all --message "docs(CHANGELOG.md): release 0.11.0"
    ```
1.  用腳本更新輸入法程序的版本號，並提交修改過的文件（腳本會在最後調用 `clog` 提取更新日誌）
    ``` sh
    update/bump-version.sh # print usage
    update/bump-version.sh 0.10.0 0.11.0

    git commit --all --message "chore(release): 0.11.0 :tada:"
    ```
1.  以上提交在 `master` 完成。如果在另一個分支發佈，如 `legacy`，則將以上修改合併到分支。
1.  push 所有修改到 GitHub。檢驗 CI build：下載安裝程序，測試全新安裝以及從上一個推送版本升級。
1.  確認該版本可發佈後，在 `master` 或要做發佈的分支上打標籤。推送標籤到 GitHub 會在安裝包構建完成後自動觸發發佈到 bintray release 頻道的部署作業。
    ``` sh
    git tag --annotate 0.11.0 --message "chore(release): 0.11.0 :tada:"
    git push --tags
    ```
1.  AppVeyor 已經創建好了版本，並上傳了文件，只等一鍵發佈。如果手動完成，這個過程爲：
    將（release tag 觸發的） CI build 生成的安裝包上傳到 bintray。
    在 https://bintray.com/rime/weasel/release 新建版本 (New version)，命名爲版本號 `0.11.0`，描述：`小狼毫 0.11.0`。
    爲新建的版本上傳文件 `weasel-0.11.0.0-installer.exe`。
1.  生成顯示在推送更新介面的變更記錄。只包含 `CHANGELOG.md` 的最新版本章節，格式爲樸素的 HTML 網頁。
    ``` sh
    # npm install --global marked
    update/write-release-notes.sh
    ```
    留存生成的 `release-notes.html` 文件備用。
1.  使用 [Hexo](https://hexo.io/) 在官方網站 <rime.im> 發佈更新。

    ``` sh
    git clone https://github.com/rime/home.git rime-home
    cd rime-home/blog
    npm install

    npm install --global hexo-cli

    # TODO(keyholder): edit files
    cp ~/code/rime/weasel/update/appcast.xml ~/code/rime/home/blog/source/release/weasel/appcast.xml
    cp ~/code/rime/weasel/update/testing-appcast.xml ~/code/rime/home/blog/source/testing/weasel/appcast.xml
    cp ~/code/rime/weasel/release-notes.html ~/code/rime/home/blog/source/release/weasel/release-notes.html
    cp ~/code/rime/weasel/release-notes.html ~/code/rime/home/blog/source/testing/weasel/release-notes.html

    cat <<EOF > ~/code/rime/home/blog/source/release/weasel/index.md
    title: 【小狼毫】更新日誌
    comments: false
    $(date '+date: %Y-%m-%d %H:%M:%S')
    ---

    EOF
    cat ~/code/rime/weasel/CHANGELOG.md >> ~/code/rime/home/blog/source/release/weasel/index.md
    cp ~/code/rime/home/blog/source/release/weasel/index.md  ~/code/rime/home/blog/source/testing/weasel/index.md
    ```

    需要修改的內容包括：

  - [首葉](https://rime.im/) 的下載按鈕：[源代碼](https://github.com/rime/home/blob/master/blog/source/_data/downloads.yaml)
  - [下載葉](https://rime.im/download/) 的版本號及下載鏈接：[源代碼](../blog/download/index.md)
  - [更新日誌](https://rime.im/release/weasel/)，
    更新 [源代碼](../blog/release/weasel/index.md) 文件頭的 `date` 字段，
    並用 `weasel/CHANGELOG.md` 的內容替換 Markdown 正文部份（YAML 結束標記 `---` 及隨後空行以下）
  - [推送更新頻道](https://rime.im/release/weasel/appcast.xml)，
    將 [源代碼](https://rime.im/release/weasel/appcast.xml) 替換爲第 5 步修改過的 `weasel/update/appcast.xml`
  - [推送更新提示](https://rime.im/release/weasel/release-notes.html)，
    將 [源代碼](../blog/release/weasel/index.md) 替換爲第 10 步生成的 `release-notes.html`

    測試頻道（用於手動檢查更新）自動化調試就緒前，將 `blog/source/release/weasel/` 的內容複製到 `blog/source/testing/weasel/`，唯獨需要用 `weasel/update/testing-appcast.xml` 更新 `blog/source/testing/weasel/appcast.xml`。

2.  修改完成後，在本地調試網站。

    ``` sh
    # check your changes with local HTTP server
    hexo server
    ```

    方法爲：將以上修改過的網葉地址中的域名部份替換爲 Hexo 提示的本地服務器地址，在瀏覽器中預覽各個網葉，檢查文字內容和鏈接地址。

3.  確認內容無誤，用 Hexo 發佈網站。

    ``` sh
    # first time releaser, setup without deployment
    hexo deploy --setup

    # source XML/HTML files in generated folder may not get updated.
    hexo clean

    # publish website at rime.github.io
    hexo deploy --generate
    ```

    發佈完成後，可以在 https://github.com/rime/rime.github.io/commits/master 複查提交到 GitHub Pages 的修訂。

4.  提交以上修改到 `rime/home` 代碼庫。

5.  如果本次發佈不是針對小狼毫 0.9 的升級版本（見第 6 步），發佈至此完成。
    否則需要在驗證新版本工作正常後，將其推送到位於 <rimeime.github.io> 的舊更新頻道。

    首先需要取得 [rimeime.github.io](https://github.com/rimeime/rimeime.github.io) 的寫權限。

    ``` sh
    git clone https://github.com/rimeime/rimeime.github.io
    cd rimeime.github.io
    ```

6.  編輯 `weasel-update/appcast.xml` 以及 `weasel-update/pioneer/appcast.xml`：
    從第 5 步的 `weasel/update/appcast.xml` 複製 `<item>` 標籤的內容，視情況修改 `channel > title` 文字中的升級終點版本號。

    當前版本同時在新、舊兩個更新頻道發佈，因此不必修改 <rimeime.github.io> 的更新日誌。
    因爲根據 `appcast.xml` 中 `<sparkle:releaseNotesLink>` 的定義，推送更新提示一律從新官網 <rime.github.io> 加載。

7.  最後提交修改，發出 pull-request。修改併入 `master` 即開始推送更新。
