---
source: rime-hamster-wiki/同步教程.md
title: 同步教程
---

仓输入法的同步指两种情况：一种是 RIME 引擎的同步策略，只同步词库文件。另一种是基于 iCloud 文件系统的同步，不限于词库文件，可以把任何文件都同步到 iCloud。

## RIME 同步

RIME 同步是 RIME 内置的功能，用来同步输入方案中的词库文件。注意，RIME的同步功能只支持 userdb 类型（二进制格式）的词库。如果词库格式为 tabledb 格式（文本格式），则 RIME 同步功能无法支持。

> 如何查看自己的输入方案是那种格式？在输入方案的 x.schema.yaml 文件中，查找 db_class 参数。

### 设置方法

1. iOS系统设置 -> 通用 -> 键盘 -> 仓输入法，开启完全访问权限。

> 注意：这里必须开启“完全访问权限”，是因为 iOS 系统限制，共享在 “AppGroup” 下文件，必须开启“完全访问权限”后，键盘才能有写权限。

2. 打开仓输入法，在 RIME 功能下，关闭“部署时覆盖键盘词库文件”开关。

3. 在应用的方案文件管理功能下，点击Tab “应用文件”，修改 `Rime` 下的 `installation.yaml` 文件。在文件内增加以下配置示例(如果已存在，则修改下面参数的配置信息)：

```yaml
installation_id: "hamster_6s"
sync_dir: "/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/sync"
```

> 注意：在手机端无需手敲上述示例，在仓输入法的 RIME 功能下，点击 RIME 重置下的说明文字可复制。

* `installation_id`: 用来指定同步文件夹名称，如果不加此参数，RIME 默认会生成一个 UUID 的文件。上面的示例会在 `sync_dir` 指定路径下，生成指定的 `hamster_6s` 的文件夹。
* `sync_dir`: 指定的同步路径，如果不加此参数，默认路径为：`仓输入法的文档目录/Rime/sync`。

  使用 iOS 内置应用 Files（中文系统名为：文件） 查看，在`Browse/On My iPhone/Hamster/Rime/sync`（中文系统为：`浏览/我的iPhone/Hamster/Rime/sync`）。
  
  因 iOS 系统限制，指定的同步路径不能随意写，写了也没有权限写入。
  
  上面示例的路径是仓输入法申请的 iCloud 上的路径，固定前缀为：`/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents`。路径前缀后的路径，如 `sync` 是可以自定义的。
  
  使用 iOS 内置应用 Files（中文系统名为：文件） 查看，在`Browse/iCloud Drive/Hamster`（中文系统为：`浏览/iCloud云盘/仓输入法`）。

4. 在其他终端（如其他 iPhone, MacOS等），在 `installation.yaml` 文件内设置与上面相同的 `sync_dir` 参数，而`installation_id`设置为不同的参数。

> 注意：在 MacOS 系统中，这个固定前缀会变为：`~/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents`

### 设置示例

已内置星猫键道方案作为测试用例（输入方案选择内置的“星猫键道6.3”），无需开启仓输入法的“iCloud同步”开关，两台测试设备 iPhone X 和 iPhone 6s。

0. 分别在两台设备上，关闭 RIME 功能下的“部署时覆盖键盘词库文件”开关

1. 修改 6s 的 `installation.yaml` 文件，参数如下:

```yaml
installation_id: "hamster_6s"
sync_dir: "/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/sync"
```

2. 修改 x 的 `installation.yaml` 文件，参数如下：

```yaml
installation_id: "hamster_x"
sync_dir: "/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/sync"
```

3. 两台设置分别将内置星猫键道词库格式改为`userdb`类型，如下，在 `方案文件管理/应用文件/SharedSupport/xmjd6.schema.yaml` 的294~295行。（注意：输入方案调整，行数可能有变化）

```yaml
# ↓ 用户词典格式，tabledb（文本） 或 userdb （二进制）。
  #db_class: tabledb
  db_class: userdb
```

  两台设备修改完毕后点击“重新部署”，使刚才的词库设置生效。

以上，同步准备工作完毕，下面进入自造词同步测试：

1. 在 x 设备输入自造词，输入 `a` 进入自造词模式，键入 `poof`，空格，生成自造词 `凭空这`
2. 在 6s 设备输入自造词，输入 `a` 进入自造词模式，键入 `foop`，空格，生成自造词 `放学平`
3. 在两台设备上分别点击 `RIME 同步`，然后使用 iOS 内置应用 Files（中文系统名为：文件） 查看，在`Browse/iCloud Drive/Hamster/sync`（中文系统为：`浏览/iCloud云盘/仓输入法/sync`）。
  
    可以看到两台设备各自的生成的同步词库文件`xmjd6_user.userdb.txt`，文件内容为各自生成的自造词。
    
4. 分别在两台设备上，使用 iOS 内置应用 Files（中文系统名为：文件）打开 sync 目录下对方设备的目录，强制下载目录下全部文件。

    > 注意：未将云端文件下载到本地的文件，在右侧有个的云朵样式的下载图标，此时长按这个文件，点击“下载”，即可完成。
    
5. 分别在两台设备中，点击 `RIME同步`，然后使用 iOS 内置应用 Files（中文系统名为：文件） 查看自造词文件，在`Browse/iCloud Drive/Hamster/sync`（中文系统为：`浏览/iCloud云盘/仓输入法/sync`）下，`installation_id`参数对应的目录中，`xmjd6_user.userdb.txt`文件内容增加了对方设备的自造词内容。

以上是两台设备自造词同步示例。

## iCloud 同步

iCloud 同步是指:

1. 将方案文件管理下的应用文件存储到iCloud中，此功能需要手工触发（iCloud同步 -> 拷贝应用文件至iCloud）。

此功能默认会将应用文件下的 `Rime` 与 `SharedSupport` 两个目录内的全部文件拷贝到 iCloud 的 `/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/RIME` 目录下。

如果希望过滤掉不想要的文件，可以使用 iCloud 同步功能下的正则过滤功能。如：

* `^.*[.]userdb.*$`: 表示过滤 userdb 目录及其包含的文件
* `^.*build.*$`：表示过滤 build 目录及其包含的文件
* `^.*SharedSupport.*$`：表示过滤 SharedSupport 目录及其包含的文件
* `^.*[.]bin$`：表示过滤已 `.bin` 结尾的文件

> 注意：不需要手工敲这些过滤表达式，点击功能下的说明文字即可复制。然后按个人需要修改。

2. 将 iCloud 下 `/private/var/mobile/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/RIME` 目录中的文件，复制到仓的应用文件中。

此功能需要打开 “iCloud开关”。 在打开后，每次触发“RIME 重新部署”时，会自动复制 iCloud 上的文件（即上面所指路径下的文件）。

在复制时，会比较相同文件名的文件，如果 iCloud 中的文件与本地文件不同，那么会使用 iCloud 中的文件覆盖掉本地文件。

> 注意：如果您设置了功能 1 中的正则过滤表达式，那么在复制时也会进行过滤处理。

## 手机端 与 iCloud 以及 PC端rime的联动同步
手机端仓操作步骤：
1. 把方案文件全部都丢icloud仓的文件夹下（Hamster>RIME>Rime下）
2. 把仓的设置icloud 同步打开
3. 如果放在icloud中的方案有default.yaml，那么请删掉，sharedsupport中有内置，（如果不需要内置方案，删除rime文件夹即可，这样可以减少仓所占空间，如果需要使用内置方案可以不需要删除）
4. 再点重新部署，就会把icloud云中的方rime整个文件夹拷贝下来案
5. 记得在仓的icloud同步中设置过滤的正则:
       ^.*build.*$,^.*SharedSupport.*$
    注意，如果没有使用的userdb文件请再加上
       ^.*[.]userdb.*$
    中间用,隔开

这样操作，就能在使用点击拷贝到icloud功能时，不会把这些文件上传，同时也保持了icloud中仅存方案文件

PC端操作步骤（以GoodSync软件为例）： 
1. 装上GoodSync
2. 新建同步任务→选择备份
3. 出现
      文件夹→文件夹
   左边选择：
       icloud路径的Hamster>RIME>Rime，Rime文件夹，也就是方案所在文件夹
   右边选择：
       rime用户文件夹（电脑的rime输入法图标右键用户文件夹即可打开，复制路径）
4. 点开选项增加一些设置及过滤规则
      过滤器中→排除全部增加：build,hamster.custom.yaml等等，想排除什么文件自行添加，再把下列四个排除选项全部勾选
5. 点开自动分析和同步勾选以下
       文件更改时，延迟设置0秒
       自动解决冲突左边覆盖右边（保证保留最新的）
6. 左侧右侧各自勾选
      不要生成_gsdata_文件夹
### 联动同步的优势
   **文件操作仅需在iCloud中修改，修改后，由于开启了icloud同步，仓点击重新部署即可更新并应用，而PC电脑，也因为GoodSync会自动进行同步文件，也只需要点击rime的重新部署即可。**

## iCloud 同步 与 RIME 同步的区别

RIME 同步主要是用来做自造词同步的，而 iCloud 同步功能主要是做文件的云端备份的。

## 问题

https://github.com/imfuxiao/Hamster/issues/231
关于自造词同步的问题，有疑问可以参考这个issue。


https://github.com/imfuxiao/Hamster/discussions/44
关于同步/拷贝键盘词库文件至应用/Rime同步的说明