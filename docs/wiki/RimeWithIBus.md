## Rime With IBus

> Building and installing ibus-rime.

Packages for Linux Distributions

### Archlinux

```shell
pacman -S ibus-rime
```

### Debian

Rime 已收錄於 [Debian Jessie](https://wiki.debian.org/DebianJessie) 及以上版本

```shell
sudo apt-get install ibus-rime # or fcitx-rime
```

### Gentoo

```shell
emerge ibus-rime  # or fcitx-rime
```

### Ubuntu

Rime 已收錄於 [Ubuntu 12.10 (Quantal Quetzal)](https://old-releases.ubuntu.com/releases/12.10/) 及以上版本

```shell
sudo apt-get install ibus-rime
```

安裝更多輸入方案：（推薦使用 [/plum/](https://github.com/rime/plum) 安裝最新版本）

```shell
# 朙月拼音（預裝）
sudo apt-get install librime-data-luna-pinyin
# 雙拼
sudo apt-get install librime-data-double-pinyin
# 宮保拼音
sudo apt-get install librime-data-combo-pinyin
# 注音、地球拼音
sudo apt-get install librime-data-terra-pinyin librime-data-bopomofo
# 倉頡五代（預裝）
sudo apt-get install librime-data-cangjie5
# 速成五代
sudo apt-get install librime-data-quick5
# 五筆86、袖珍簡化字拼音、五筆畫
sudo apt-get install librime-data-wubi librime-data-pinyin-simp librime-data-stroke-simp
# IPA (X-SAMPA)
sudo apt-get install librime-data-ipa-xsampa
# 上海吳語
sudo apt-get install librime-data-wugniu
# 粵拼
sudo apt-get install librime-data-jyutping
# 中古漢語拼音
sudo apt-get install librime-data-zyenpheng
```

### Fedora 22+

```shell
sudo dnf install ibus-rime
```

### Fedora 18/19

```shell
sudo yum install ibus-rime
```

### OpenSUSE tumbleweed & 15

```shell
sudo zypper in ibus-rime
```

### Solus

```shell
sudo eopkg it ibus-rime
```

有手藝、有時間、熱心腸的Linux技術高手！ 請幫我把Rime打包到你喜愛的Linux發行版，分享給其他同學吧。

謝謝你們！

## Manual Installation

### Prerequisites

To build la rime, you need these tools and libraries:

* capnproto (for librime>=1.6)
* cmake
* boost >= 1.46
* glog (for librime>=0.9.3)
* gtest (optional, recommended for developers)
* libibus-1.0
* libnotify (for ibus-rime>=0.9.2)
* kyotocabinet (for librime<=1.2)
* leveldb (for librime>=1.3, replacing kyotocabinet)
* libmarisa (for librime>=1.2)
* opencc
* yaml-cpp

Note: If your compiler doesn't fully support C++11, please checkout `oldschool` branch from https://github.com/rime/librime/tree/oldschool

### Build and install ibus-rime

Checkout the repository:

```shell
git clone https://github.com/rime/ibus-rime.git
cd ibus-rime
```

If you haven't installed dependencies (librime, rime-data), install those first:

```shell
git submodule update --init
(cd librime; make && sudo make install)
(cd plum; make && sudo make install)
```

Finally:

```shell
make
sudo make install
```

### Configure IBus

* restart IBus (`ibus-daemon -drx`)
* in IBus Preferences (`ibus-setup`), add "Chinese - Rime" to the input method list

Voilà !

### ibus-rime on Ubuntu 12.04 安裝手記

註：這篇文章過時了。

今天天氣不錯，我更新了一把Ubuntu，記錄下安裝 ibus-rime 的步驟。

```shell
# 安裝編譯工具
sudo apt-get install build-essential cmake

# 安裝程序庫
sudo apt-get install libopencc-dev libz-dev libibus-1.0-dev libnotify-dev

sudo apt-get install libboost-dev libboost-filesystem-dev libboost-regex-dev libboost-signals-dev libboost-system-dev libboost-thread-dev
# 如果不嫌多，也可以安裝整套Boost開發包（敲字少：）
# sudo apt-get install libboost-all-dev

# 下文略……
```

### ibus-rime on Centos 7


```shell
yum install -y gcc gcc-c++ boost boost-devel cmake make cmake3
yum install glog glog-devel kyotocabinet kyotocabinet-devel marisa-devel yaml-cpp yaml-cpp-devel gtest gtest-devel libnotify zlib zlib-devel gflags gflags-devel leveldb leveldb-devel libnotify-devel ibus-devel
cd /usr/src

# install opencc
curl -L https://github.com/BYVoid/OpenCC/archive/ver.1.0.5.tar.gz | tar zx
cd OpenCC-ver.1.0.5/
make
make install
ln -s /usr/lib/libopencc.so /usr/lib64/libopencc.so

cd /usr/src
git clone --recursive https://github.com/rime/ibus-rime.git

cd /usr/src/ibus-rime
# 下文略，同前文給出的安裝步驟
```
