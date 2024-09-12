---
source: rime-trime-wiki/五笔双键配置案例详解(二)-添加一个输入方案.md
title: (二)-添加一个输入方案
---

## 五笔双键配置案例详解(二) 添加一个输入方案
 
把大象装到冰箱里分几步？  
答: 三步：  

1. 把冰箱门打开
2. 把大象推进去
3. 把冰箱门关上
 
添加一个输入方案分几步？  
答: 也是三步:  

1. 得到一份方案 (编写或者复制)
2. 为输入方案定义schema_id和name
3. 将输入方案schema_id添加到default.yaml的shcema_list中
 
OK,现在按Ctrl+~就可以切换了。
 
 
### 得到输入方案
由于五笔双键是在wubi86的基础上的，所以，你必须有原始的wubi86.schema.yaml和wubi86.dict.yaml这两个文件。
wubi86.schema.yaml存放的是wubi的方案的一般处理流程，我们有了这个模板，就可以方便地进行修改。
wubi86.dict.yaml这个文件存放的是wubi86的码表，即所有的汉字、词组和对应的编码。我们会在这个码表的基础上进行模糊音处理，从而生成一个新的，适合双键的码表。
 
闲话少说，总之第一步就是原来的wubi86.schema.yaml复制一份，重命名为wubi86_double_key.schema.yaml
 
### 生成新的输入方案
第二步，就是在前一步基础上，将wubi86_double_key.schema.yaml文件中下面两项给替换掉:
 
```yaml
　schema_id: wubi86_double_key　#id是给系统看的，系统中引用都是通过它
  name: "五笔86双键版"　　　#name是给人看的，切换输入方案的时候，这个名字就会出现
```
 
说明:
  替换schema_id，是因为每个输入方案必须有一个独立的标识（后面会用到）。
替换了name，是给人看的。
 
### 添加方案到系统列表
经过上面的两步，我们其实就已经有了一个名字独一无二的输入方案。虽然输入主案的内容与wubi86一模一样，但是至少我们先配置一下，然后就可以在系统方案中看到他。
在 default.custom.yaml文件添加我们的方案id。
```yaml
patch:
  schema_list:
    - schema: wubi86
    - schema: wubi86_double_key   #我们的方案ID
```
 
**重新布署**
 
现在切换到小狼毫，然后按下小狼毫的热键，Ctrl+\` 或者F4试试
现在是不是就可以看到我们的输入方案的名称了？
切换过去试一下，是不是跟系统自带的五笔一模一样？
 
 
### 提高篇
如果你有兴趣深究，还可以切换到%AppData%/rime路径下，看看重新布署后，到底生成了哪些文件。
其实生成的文件中以wubi86开头的文件，只有三个:
- wubi86.prism.bin   #输入法的棱镜文件
- wubi86.reverse.bin　 #输入法反查的文件
- wubi86.table.bin    #输入法的码表文件
 
由于我的码表文件共用的是wubi86的文件，所以我们跟wubi86其实是共用的一套输入法棱镜文件。
看wubi86_double_key.yaml中的内容，就知道了。
 
```yaml
translator:
  dictionary: wubi86    #注意这里,其实引用的是wubi86.dict.yaml码表文件
  enable_charset_filter: true
  enable_encoder: true
```
 
### 小结
现在，你可以回顾一下前面学到的知识。

1. 每个输入方案，有两个名字: schema_id和name。一个是系统使用，一个是显示给人看。
2. 定义了输入方案和schema_id后，只要将schema_id添加到default.custom.yaml文件的schema_list中。就可以切换到该输入方案了。
 
