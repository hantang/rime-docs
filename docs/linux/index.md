---
source: ibus-rime/README.md
---

# ibus-rime

Rime Input Method Engine for Linux/IBus

project home: [rime.im](https://rime.im)

code repository: https://github.com/rime/ibus-rime

license: GPLv3-or-later

## installation

Refer to https://github.com/rime/home/wiki/RimeWithIBus

build dependencies:

- pkg-config
- cmake>=3.10
- librime>=1.0 (development package)
- libibus-1.0 (development package)
- libnotify (development package)
- plum (submodule)

runtime dependencies:

- ibus
- librime>=1.0
- libibus-1.0
- libnotify
- rime-data (provided by plum)
