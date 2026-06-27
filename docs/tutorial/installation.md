# 安装RIME

???+ tip "安装后注销或者重启"

    安装RIME输入法后，一般需要**注销当前用户或者重启系统**，再次登录系统后，RIME输入法才会自动添加到系统输入法中。

    如果还是不行，可再通过系统配置手动添加到输入法列表中。

## Windows

Windows系统推荐从官网或Github仓库手动下载安装包下载，
Windows 11系统可以使用内置`winget`安装小狼毫。

=== "手动安装"

    下载最新版：`小狼毫` [GitHub最新发布版](https://github.com/rime/weasel/releases/latest)
    ![GitHub Release](https://img.shields.io/github/v/release/rime/weasel)

    尝鲜用户可以下载 [**Nightly Build**](https://github.com/rime/weasel/releases/tag/latest) 版本。

    运行exe安装程序，按提示步骤完成安装。

=== "winget安装"

    使用微软官方包工具`winget`

    ```powershell
    # 支持Windows10/Windows11（内置）
    # https://github.com/microsoft/winget-cli
    # https://learn.microsoft.com/zh-cn/windows/package-manager/winget/

    winget install --id Rime.Weasel
    ```

=== "第三方包管理工具"

    - 使用第三方包工具 `choco` / `scoop`

    ```powershell
    # choco <https://chocolatey.org/install>
    choco install weasel

    # scoop <https://scoop.sh/>
    # 需要添加第三方库，例如 scoop bucket add Scoopforge_Extras-CN
    # https://github.com/Scoopforge/Extras-CN
    scoop install Scoopforge_Extras-CN/weasel
    ```

    - 或者 UniGetUI （为winget/choco/scoop等提供GUI界面）
        <https://github.com/devolutions/unigetui>

安装后在任务栏语言栏切换到RIME图标即可使用。

???+ warning "版本支持"

    小狼毫从`0.15.0`开始版本，仅支持 **Windows8.1/Windows/10/Windows11** 系统。

    旧版系统支持版本：
    - `0.14.3` Windows 7, Windows 8/8.1, Windows 10（不再更新）
    - `0.9.30` Windows XP SP3（不再更新）

??? tip "病毒警告"

    ⚠️ 如果 Windows Defender 误报为病毒。
    请确保从官方页面或者官方仓库的 GitHub Releases 页面下载，
    并在杀毒软件中将其添加为信任/白名单。
    不要安装不确定来原来的第三方下载包。

## macOS

macOS系统，如果已经安装Homebrew可以使用`brew`命令安装，
或者从官网、Github仓库手动下载安装包安装。
Fcitx5版目前仅手动安装方式。

=== "Homebrew安装"

    ```bash
    # homebrew: https://brew.sh/
    brew install squirrel-app

    # 旧版本homebrew
    # brew install --cask squirrel
    # brew cask install squirrel
    ```

=== "手动安装"

    下载最新版：`鼠须管` [GitHub最新发布版](https://github.com/rime/squirrel/releases/latest)
    ![GitHub Release](https://img.shields.io/github/v/release/rime/squirrel)

    尝鲜用户可以下载 [**Nightly Build**](https://github.com/rime/squirrel/releases/tag/latest) 版本。

    双击安装（并重启或注销系统），完成后在【系统设置 → 键盘 → 输入法】中添加【鼠须管】。
    菜单栏出现【ㄓ】图标后即可使用。

=== "Fcitx5-macOS版安装"

    Fcitx5-macOS是Fcitx5在macOS的移植版，也支持其他Fcitx5输入法，例如：
    - 拼音版（核心是fcitx5-chinese-addons）可以添加拼音、双拼、五笔等，
    - 中州韵版（核心是fcitx5-rime）支持Rime相关输入方案。

    可以通过【插件管理器】进行安装多种语言输入法（Rime在“通用”分类），并在【输入法】添加相应键盘和对应输入方案。

    前往 `fcitx5-macos` [GitHub最新发布版](https://github.com/fcitx/fcitx5-macos/releases/latest) ybxm选择 **中州韵版** 下载安装。
    
    相关文档：

    - [Fcitx5 macOS 小企鹅输入法](https://fcitx-contrib.github.io/docs/)
    - [小企鹅输入法 macOS 版安装器](https://github.com/fcitx-contrib/fcitx5-macos-installer/blob/master/README.zh-CN.md)

    !!! warning

        Fcitx5-macOS(中州韵)和鼠须管可以共存，但是注意它们的数据目录是不同的，
        不要将两者的Rime数据目录通过软链接关联（由于并发问题会导致词库可能破坏）。


???+ warning "版本支持"

    鼠须管从`0.18`（2024/05）开始，最新版需要 macOS 13.0 及以上系统。

    旧版 `0.16.2` （2023/02） 适用于 macOS 10.9 ～ macOS 12 (不再更新)。

    fcitx5-macOS 仅支持 macOS >= 13.3。

??? tip "无法打开安装包"

    ⚠️ 如果打开安装包（app/dmg/pkg等），
    出现弹窗提醒“无法打开 XX，因为无法验证开发者”或者“已损坏，无法打开”的情况，
    不必惊慌，原因是软件打包生成是没有添加Apple Developer签名。

    如果不信任相关来源或包的安全性，请勿安装。

    【Gatekeeper 绕过指南】

    - 部分支持手动解锁：可以通过【系统设置 → 隐私与安全性 → 仍要打开】手动解锁。
    - 命令行处理：现将应用拖动到安装路径（一般是应用程序目录`/Applications`）

        ```shell
        xattr -dr com.apple.quarantine /Applications/YourApp.app
        # 或者清除所有属性
        # xattr -cr /Applications/YourApp.app
        ```

<!-- [^1]: squirrel-app更名 <https://github.com/Homebrew/homebrew-cask/blob/main/cask_renames.json> -->

## Linux

尽量使用新版Linux发行版，旧系统中相关软件包版本可能较低，安装方式和配置有所不同，第三方配置方案甚至可能出错。

Linux上目前流行中中文输入法框架（也支持其他语言）主要有两种：

- **IBus** (Intelligent Input Bus) 是GNOME 默认输入法框架，默认可用、配置简单，相对而言扩展能力一般。
  基于IBus的中文输入法有：

    - **ibus-rime**
    - **ibus-libpinyin**
    - ibus-pinyin
    - ibus-sunpinyin
    - ibus-table-wubi

- 【推荐】**Fcitx5**（小企鹅输入法） 是Fcitx （Free Chinese Input Tool of X，旧全名） 的“重写版本”，面向更现代的桌面框架，性能更好，但是配置相对复杂。

    - 系统发行版
        - fcitx5 (linux)
        - fcitx5-android
        - fcitx5-macos
    - 输入方案支持
        - **fcitx5-rime**
        - **fcitx5-chinese-addons**
    - ……

查询Linux发行版支持RIME包情况：

- <https://pkgs.org/download/ibus-rime>
- <https://pkgs.org/download/fcitx5-rime>

=== "Debian/Ubuntu"

    - **IBus框架**

    ```bash
    # 更新
    sudo apt update
    # 安装ibus【一般默认已经安装】和ibus-rime
    sudo apt install ibus ibus-rime

    # 中文字体【可选】
    # sudo apt install fonts-noto-cjk

    # 【配置】切换到ibus 或在Language Support中配置
    im-config -s ibus
    ```

    > 注销/重启后，在【设置-键盘-输入源（input sources）】中搜索添加【RIME】。

    - **Fcitx5框架**

    ```bash
    sudo apt update
    # 安装fcitx5和fcitx5-rime
    sudo apt install fcitx5 fcitx5-rime
    # 【可选】中文输入法（全拼、双拼和五笔等）
    # fcitx5-chinese-addons

    # 切换输入法框架
    im-config -s fcitx5

    # 【配置】打开 fcitx5-configtool 添加rime

    # 【配置开机自启动】fcitx5
    # 参考 https://fcitx-im.org/wiki/Setup_Fcitx_5#XDG_Autostart
    mkdir -p ~/.config/autostart && cp /usr/share/applications/org.fcitx.Fcitx5.desktop ~/.config/autostart
    # 或者：【设置 → Apps】 找到 Fcitx5 配置中勾选 Autostart；
    # 或者：安装 gnome-tweaks 后，打开程序，将fictx5添加到【开机启动程序】

    # 【优化】（默认时，可能存在输入框和光标是分离的），可以安装，或者参考接下来的部分
    sudo apt install gnome-shell-extension-manager
    # 然后打开Extensions 搜索安装 Input Method Panel
    ```

=== "ArchLinux"

    参考文档: https://wiki.archlinux.org/title/Rime

    - **IBus框架**

    ```bash
    # Arch Linux
    sudo pacman -S ibus ibus-rime
    ```

    - **Fcitx5框架**

    ```bash
    sudo pacman -S fcitx5 fcitx5-rime

    # 【可选】下面部分会自动依赖安装
    # fcitx5-configtool: 图形化配置工具
    # fcitx5-im: 输入法设置工具
    # fcitx5-gtk: GTK 程序的支持
    # fcitx5-qt: QT5 程序的支持
    # librime: rime 相关库
    ```

=== "Fedora/CentOS/RedHat"

    - **IBus框架**

    ```bash
    # Fedora 20以上
    sudo dnf install ibus-rime

    # Fedora低版使用yum
    # sudo yum install ibus-rime
    ```

    - **Fcitx5框架**

    ```bash
    sudo dnf install fcitx5 fcitx5-rime
    # 支持lua脚本【部分发行版可能手动安装以支持词库Lua脚本相关功能】
    sudo dnf install librime-lua
    ```

另外，除了Linux发行版内置的包管理器，也可以：

=== "AppImage版IBus"

    <https://github.com/hchunhui/ibus-rime.AppImage>

=== "Flatpak版Fcitx5"

    ```bash
    # https://flathub.org/apps/org.fcitx.Fcitx5
    flatpak install org.fcitx.Fcitx5
    flatpak install flathub org.fcitx.Fcitx5.Addon.Rime

    # 【注意】flatpak版的用户目录和普通fcitx5版目录不同
    ```

??? tip "输入框异常修复"

    如果配置后，软件中无法正常输入，或者输入框和光标分离，
    可以参考 <https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland> 进行参数配置。

    编辑文件`/etc/profile`（全局生效，影响所有用户，需要sudo权限）或者
    `~/.xprofile`（仅影响当前用户），文末新增：

    ```shell
    export XMODIFIERS=@im=ibus
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    ```

    或者

    ```shell
    export XMODIFIERS=@im=fcitx5
    export GTK_IM_MODULE=fcitx5
    export QT_IM_MODULE=fcitx5
    ```

<!--
gnome扩展相关：
https://github.com/mjakeman/extension-manager
https://github.com/wengxt/gnome-shell-extension-kimpanel
https://extensions.gnome.org/extension/261/kimpanel/
-->

## 移动端

一般可以从应用商店（Apple Store、Google Play等）或者Github仓库（Android系统）下载安装。

## 卸载

1. 更新输入法列表：卸载输入法之前需要先将要系统配置的输入法列表移除将要卸载输入法名。
2. 停止相关进程：如有必要，打开任务管理器/活动监视器，终止相应输入法程序。
3. 卸载输入法
     - 使用包管理器（如homebrew/winget/apt等），可以通过包管理器卸载。
     - 手动安装的：Windows小狼毫提供自带的卸载程序，使用卸载程序卸载；
        macOS鼠须管打开`/Library/Input Methods`目录，右键`Squirrel.app`选择“移到废纸篓”（Move to Trash）即可。
        Fcitx5-macOS，图标右键点击【关于 Fcitx5 macOS】，弹窗页面选择卸载。
4. 清理：卸载完成后，可以手动清除用户数据目录等配置。
5. 注销或重启系统。

=== "Windows"

    终止小狼毫服务

    ```powershell
    # 方式1：右键输入法图标后点击【退出算法服务】
    # 方式2：任务管理器，【进程】中搜索“小狼毫”，然后右键“结束任务”
    # 方式3：Powershell
    Stop-Process -Name WeaselServer  -Force
    ```

=== "macOS"

    ```bash
    # 停止服务
    killall Squirrel

    # 通过homebrew卸载
    brew uninstall squirrel-app
    # 手动卸载
    # sudo rm -rf "/Library/Input Methods/Squirrel.app"

    # 清除个人配置
    rm -rf ~/Library/Rime
    ```
