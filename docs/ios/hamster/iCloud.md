---
source: rime-hamster-wiki/开启iCloud备份后的使用说明.md
title: 开启iCloud备份后的使用说明
---

# iCloud备份功能
## 开启步骤：
1、iCloud备份功能在高阶设置下的同步与备份里面。

2、勾选开启iCloud。

3、首次开启iCloud会将仓内的方案配置拷贝至iCloud下的Hamster/Rime目录下，并切换使用此目录。

## 开启iCloud备份的注意事项！

- 1、App内置的方案变动后，不会自动同步到iCloud文件内，因此 App内提供了“拷贝至iCloud“的选项
- 2、iCloud内文件变动后，亦不会自动同步到App内，但当点击 **重新部署** 的时候，仓会**增量拷贝**iCloud中 全部与仓App输入方案不同的文件。
- 3、因此在开启了iCloud备份功能后，如需要编辑方案和方案词典文件，请在iCloud里面进行编辑修改文件，以免在重新部署的时候，仓内修改的文件被覆盖⚠️。
- 4、仓App内Rime目录下有方案部署使用后，实时记录用户词频的xxx.userdb文件夹，iCloud里面不要有xxx.userdb文件夹（可通过正则过滤^.*[.]userdb.*$，^.*build.*$文件夹，点击“拷贝至iCloud”时，就不会将仓内的xxx.userdb文件夹拷贝到iCloud），部署就不会覆盖仓内部新的用户词频文件。
- 5、通过App内高阶设置-->Rime设置-->“Rime同步”，可将用户词频保存在sync目录，里面有方案使用的用户词频文件，如：xxx.userdb.txt（不同于文件夹，这是Rime的同步机制与App行为无关）。
- 6、如需自定义sync目录存放位置，请编辑installation.yaml文件，
- 路径示例： `sync_dir: "/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/RIME/Rime/sync"`