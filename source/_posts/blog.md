---
title: 非程序猿按步骤git+hexo搭建及优化教程，了解一下
date: 2018-07-23 00:05:47
tags: 
- 搭建博客
categories: 「get新技能」
photos: https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1532284485273&di=5c842cb99b7c393dbda865959acb101b&imgtype=0&src=http%3A%2F%2Fupload.chinaz.com%2F2015%2F1016%2F1444964380585.png
description: 手把手教怎么做hexo博客了解一下？
top: true

---

# 前言
作为一个纯文科生，我亲手做了一个自己的博客（骄傲脸）。这篇文，是作为我搭建博客和换电脑后迁移博客及优化的过程记录，以免我以后又忘记怎么做了。非程序猿读者们，共勉之。

至于为什么要用git和hexo，而不是傻瓜式用博客网站？可能应为我内心有个geek怪兽吧！

16年的时候，无意中看到一个RD同事的博客，才了解到Hexo是一个快速、简洁且高效的博客框架，又有搭建个人博客的想法，便动手尝试了。

因为因为我之前就已经配置过所有的设置，只是这次换电脑，所以需要在新电脑上做迁移，以及做一些优化工作。

至于如何新建结合git和hexo新建博客的话，可以看这个[《Hexo+GitHub博客搭建实战》](http://wangwlj.com/2017/09/08/blog_setup/)。

也可以参考我最开始学习的陈素封的教程：[《如何搭建一个独立博客——简明Github Pages与Hexo教程》](https://www.jianshu.com/p/05289a4bc8b2)。


# 迁移开始
## 安装Node.js

去Node.js官网下载相应的安装包，一路安装即可。

## 安装Git

Mac下安装Xcode就自带Git。（Windows可以去官网）

## 添加SSH Keys
Github 添加 SSH Keys
首先在本地创建 SSH Keys，（直接用Mac的终端，或者Windows的找到git-git bash）

```
ssh-keygen -t rsa -C "youremail@163.com"
```

后面的邮箱即为 github 注册邮箱，也是你登录 Github 的邮箱，之后会要求确认路径和输入密码，一路回车就行。
成功的话会在 ~/下生成 .ssh文件夹，进去，打开 id_rsa.pub，复制里面的key即可。

然后我们再次测试下公钥有没有添加成功：
```
ssh -T git@github.com
```

成功了。
之后我们再次部署我们的博客网站：
```
hexo d
```

成功。我的个人博客网站也正常显示.

## 源文件拷贝
将你原来电脑上个人博客目录下必要文件拷到你的新电脑上（比如`/users/yourname`目录下），注意无需拷全部，只拷如下几个目录：


```
_config.yml
package.json
scaffolds/
source/
themes/
```

## 安装 hexo
在中断里输入下面指令安装 hexo：

```
npm install hexo-cli -g
```

## 进入`/users/yourname`目录（你拷贝到新电脑的目录）

输入下面指令安装相关模块

```
cd /users/yourname  //进入文件夹的指令
npm install
npm install hexo-deployer-git --save  // 文章部署到 git 的模块
（下面为选择安装）
npm install hexo-generator-feed --save  // 建立 RSS 订阅
npm install hexo-generator-sitemap --save // 建立站点地图
```


## 测试
这时候使用 hexo s 基本可以看到你新添加的文章了。

关于hexo的测试连接localhost:4000有时候出现看不了的情况，可参考最后面的错误解决方案。


## 部署发布文章

```
hexo clean   // 清除缓存 网页正常情况下可以忽略此条命令
hexo g       // 生成静态网页
hexo d       // 开始部署

也可以简化成 
hexo clean
hexo d -g
```

# 更换Hexo主题
主题选的是NexT，我安装的时候还是16年，现在最新更新的Github网址为https://github.com/theme-next/hexo-theme-next
首先将NexT的主题源文件下载到本地，使用Git克隆指令如下：

```
git clone https://github.com/theme-next/hexo-theme-next.git
```

下载后，将压缩包解压缩(文件位于指令运行的当前目录)，复制其中名称为hexo-theme-next的文件夹到Hexo的主题目录下，主题目录的路径为：`Hexo博客根目录/themes/`

在Hexo根目录下有一个以`_config.yml`命名的文件（下称==站点配置文件== ），用Sublime/NotePad++等文本编辑器打开，在其中找到theme属性，将其由landscape改为next。

然后在Hexo根目录执行部署Hexo指令：

```
hexo clean  // 清理缓存

hexo generate // 生成文件

hexo deploy // 部署
```

便可以在远程的博客上看到修改主题后的样式了。

# 设置Hexo主题模式
看到上图，读者可能会产生疑问，为什么自己的主题样式和笔者的不一样，这是因为在Hexo主题中，有四种不同的模式，通过切换模式，让NexT主题显示不一样的样式。

在NexT根目录下有一个同样名称为`_config.yml`，为了区分hexo根目录下的`_config.yml`，将前者称为<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，在其中找到scheme属性，如下图所示：

```
#Schemes
#scheme: Muse
#scheme: Mist
scheme: Pisces
#scheme: Gemini
```

NexT主题默认使用Muse模式，我采用的是Pisces模式，读者可根据自己的喜好，选择其中一种模式。

# 修正图片显示问题
经过上面的配置后，发现上传的博客文章里面的本地图片居然显示不来（没有同步上传）。

于是，找到解决方案：

1. 把<font color="#FFFFFF"><span style="background-color: #68228B;">主页配置文件</span></font>中的`_config.yml`里的`post_asset_folder:`这个选项设置为`true

2. 在你的hexo目录下执行这样一句话`npm install hexo-asset-image --save`，这是下载安装一个可以上传本地图片的插件

3. 等待一小段时间后，再运`行hexo n "xxxx"`来生成md博文时，`/source/_posts`文件夹内除了xxxx.md文件还有一个同名的文件夹

4. 最后在xxxx.md中想引入图片时，先把图片复制到xxxx这个文件夹中，然后只需要在xxxx.md中按照markdown的格式引入图片：
```
![你想输入的替代文字](图片名.jpg)
```

{% note warning %} 注意： `xxxx`是这个md文件的名字，也是同名文件夹的名字。只需要有文件夹名字即可，不需要有什么绝对路径。你想引入的图片就只需要放入xxxx这个文件夹内就好了，很像引用相对路径。

现在只需要直接在括号里写上你的图片名称就行，不用加博客文件名，我看了官方文档才知道。所以多看一眼官方文档才是正经事儿。 {% endnote %}

5. `hexo s`，运行本地服务器，打开`http://localhost:4000/`可实时查看修改情况。

6. `hexo d`，同步到github。

# 设置预览摘要
设置完模式后，读者们会发现，尽管首页显示的是所有文章的列表，但是每一篇文章都显示了所有内容，这样感觉看起来不舒服。

在首页显示一篇文章的部分内容，并提供一个链接跳转到全文页面是一个常见的需求。 NexT 提供三种方式来控制文章在首页的显示方式。 也就是说，在首页显示文章的摘录并显示 阅读全文 按钮，可以通过以下方法：

- 在文章中使用 `<!--more-->` 手动进行截断，Hexo 提供的方式 推荐
- 在文章的 front-matter 中添加 description，并提供文章摘录
- 自动形成摘要，在 主题配置文件 中添加。

建议使用 `<!--more-->`（即第一种方式），除了可以精确控制需要显示的摘录内容以外， 这种方式也可以让 Hexo 中的插件更好的识别。

第二种方式，在<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>中找到`auto_excerpt`属性，将`enable`设置为`true`，将length设置为想要预览到的字数，如下图所示：

```
auto_excerpt:
enable: true #将原有的false改为true
length: 300  #设置预览的字数
```
这里说明一下：上述的部署指令中`hexo deploy`可以换成`hexo server`，两者的区别在于，前者是将博客部署到远程的Github上，而后者是运行在本地，通过`http://localhost:4000`在浏览器中访问。后者是为了调试配置方便而使用，但是最终本地博客还是需要`hexo deploy`指令将其部署至Github上。

另外，不知道为什么设置预览之后，我文章内的头图不会展示，所以，设置预览之后展示头图，可以在*.md文件头部添加`photos:`，这样就可以在首页显示图片了
```
title: 
categories: 
tags:
copyright: true
comments: false
description: 
date: 2017-11-09 14:33:32
top:
photos: 
    - "http://oz2tkq0zj.bkt.clouddn.com/17-11-9/52323298.jpg"
---
```

# 添加评论功能
之前我用的友言，结果特别不好用，才发现原来是挂了，
目前的评论系统，友言，网易云跟帖都挂了。所以，我最终采用的是来必力。

参考：[Hexo博客优化之实现来必力评论功能](http://wangwlj.com/2017/12/18/blog_comment/)

# 添加菜单选项
默认情况下，菜单导航栏有首页、归档、关于三个选项，除此之外笔者还添加了分类、标签和关于。在<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>中，找到menu属性，并去掉categories、 tags、about的的注释，如下图所示：

然后在Hexo根目录执行指令如下：

```
// 添加分类页面
hexo new page "categories"
// 添加标签页面
hexo new page "tags"
// 添加关于页面
hexo new page "about"
```
执行完上述指令后，在Hexo根目录/source/文件夹下创建三个文件夹，命名分别为：categories、tags、about文件夹，在这些文件夹中分别会创建一个以index命名的Markdown文件，对这三个Markdown文件内容进行修改，使之分别为：
```
---
title: categories
date: 2017-03-12 22:06:24
type: "categories"
---
---
title: 标签
date: 2017-03-12 17:27:16
type: "tags"
---
---
title: about
date: 2017-03-12 22:07:26
type: "about"
---
```
完成文件的修改，然后部署Hexo即可完成菜单选项的添加。

# 显示每篇文章字数
**实现方法**

首先安装插件，执行以下命令：

```
npm install hexo-symbols-count-time --save
```
具体的方法都可以看官方教程：https://github.com/theme-next/hexo-symbols-count-time

然后修改<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，

```
symbols_count_time:
  separated_meta: true
  item_text_post: true  // 单篇文章字数统计
  item_text_total: true  //  全站文章字数统计
  awl: 2   //中文改成这个参数，博客如果都用英文，就是4
  wpm: 300  //中文改成这个参数，博客如果都用英文，就是275
```

**实现效果图**

在每篇文章标题下会有如下效果：

![统计每篇文章字数](zishu.jpg)

# 显示站点文章总字数
**实现方法**

首先安装插件，插件安装同上（已经“显示每篇文章字数”则忽略这步）。

然后修改<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，把第七步里，那个`item_text_total`，改成`true`就行。

另外，他默认出来的样式不好看，统计的那句话还是英文，所以直接在页面代码里修改。

位置在`/themes/next/layout/_partials/footer.swig`文件

找到`copyrightYear`那里，直接修改成下面的样子：

```
<span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love" id="animate">
    <i class="fa fa-heart"></i>   //这里我改了系统默认的用户图标，改成小心心了
  </span>
  <span class="author" itemprop="copyrightHolder">{{ theme.footer.copyright | default(author) }}</span>

  {% if config.symbols_count_time.total_symbols %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {% if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">Dannii在这里一共写了</span>
    {% endif %}  // 这里把默认的英文文案改成中文
    <span title="{{ __('symbols_count_time.count_total') }}">{#
    #}{{ symbolsCountTotal(site) }}字{#   // 这里加一个“字”，显示出来就是XX字
  #}</span>
  {% endif %}

  {% if config.symbols_count_time.total_time %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-coffee"></i>
    </span>
    {% if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.time_total')}} &asymp;</span>
    {% endif %}
    <span title="{{ __('symbols_count_time.time_total') }}">{#
    #}{{ symbolsTimeTotal(site, theme.symbols_count_time.awl, theme.symbols_count_time.wpm, __('symbols_count_time.time_minutes')) }}{#
  #}</span>
  {% endif %}
</div>
```

里面的 `<i class="fa fa-heart"></i>  `，版权信息博主名字前面，我改了系统默认的用户图标，改成小心心了。因为hexo支持FontAwesome（就是一个全是icon的网站：https://fontawesome.com/）
，只要在里面写网站所支持的icon名称hexo就能自动加载，所以我找了个`heart`代表小心心的icon。

**实现效果图**

在页面最底部会有如下效果：

![统计字数](tongjizishu.jpg)

# 文章末尾添加版权说明
直接修改文<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font> ，定位到post_copyright，将enable由false改为true即可。

该字段如下：
```
# Declare license on posts
post_copyright:
  enable: true
  license: CC BY-NC-SA 3.0
  license_url: https://creativecommons.org/licenses/by-nc-sa/3.0/
```
实现效果如图所示：

![版权](banquan.jpg)

# 设置个人头像
通过上面切换到Pisces发现，自己的头像还是属于匿名状态，因此，我们有必要设置一下自己的头像。

**实现方法**

在<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font> 中找到`avatar`字段,进行修改:

```
# Sidebar Avatar
# in theme directory(source/images): /images/avatar.gif
# in site  directory(source/uploads): /uploads/avatar.gif
avatar: /images/head_icon.jpg
```
先将`avatar`字段前的#删除，然后粘贴上头像的目录位置或者链接。

笔者将头像图片保存在了主题目录下的`source/images`文件夹，也可以存放在站点目录下的`source/uploads`文件夹。也可以将自己的头像图片，保存在百度网盘或者新浪微盘的某个地方，然后将对应的url地址复制过来，添加在`avatar`字段后即可。

其他的设置可以在<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>里找到`avatar`相关，注释有官方网站，还有一些其他的设置，比如头像是圆还是方，可不可鼠标悬浮的时候旋转等等。

**实现效果图**

其效果如下图所示：

![头像](avatar.jpg)

# 设置网站图标

**实现方法**

打开<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，找到以下字段，进行相应的修改：

```
# Put your favicon.ico into `hexo-site/source/` directory.
favicon: /web_icon.jpg
```
其中，图片web_icon.jpg存放在`hexo-site/source/`目录下。

然后预览，在自己的博客网站上有这样的图标：

![网站icon](webicon.jpg)

这里我使用了小兔兔的图标，随便在网上下的无版权图片就行。

达到效果后即可部署至远程。

# 添加留言版块
我们还可以在菜单栏增加一个”留言板”,让他人可以通过留言板直接给我们留言。

**实现方法**

在博客目录中，执行以下命令，新建一个页面：

```
hexo n page guestbook
```
然后通过路径`Hexo\source\guestbook`找到并打开guestbook文件夹下的`index.md`文件，然后再文件中添加以下代码:

```
<div class="ds-recent-visitors" data-num-items="28" data-avatar-size="42" id="ds-recent-visitors"></div>
```
然后打开<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，在menu字段下，添加如下字段：

```
menu:
  home: / || home
  about: /about/ || user
  tags: /tags/ || tags
  categories: /categories/ || th
  archives: /archives/ || archive
  留言板: /guestbook || heart #自己添加的字段，我是有多种小心心
```

`heart`是留言板的图标，可以在[这里](https://fontawesome.com/)（就是之前说的那个图标网站）找到自己喜欢的图标。

我用的是来必力评论系统，默认在新建页面上会产生评论板块。

# 实现点击出现桃心效果
**实现方法**

打开浏览器，输入如下网址

```
http://7u2ss1.com1.z0.glb.clouddn.com/love.js
```

然后将里面的代码copy一下，新建`love.js`文件并且将代码复制进去，然后保存。将`love.js`文件放到路径`/themes/next/source/js/src`里面，然后打开`\themes\next\layout\_layout.swig`文件,在末尾（在前面引用会出现找不到的bug）添加以下代码：

```
<!-- 页面点击小红心 -->
<script type="text/javascript" src="/js/src/love.js"></script>
```

# 修改文章底部的#号标签
**实现方法**

修改模板/themes/next/layout/_macro/post.swig，搜索 rel="tag">#，将其中的 # 换成<i class="fa fa-tag"></i>

**实现效果图**

![文章里的tag](tag.jpg)

# 代码块样式自定义

**实现方法**

打开`\themes\next\source\css\_custom\custom.styl`,向里面加入：(颜色可以自己定义)

```
// Custom styles.
code {
    color: #ff7600;
    background: #fbf7f8;
    margin: 2px;
}
// 大代码块的自定义样式
.highlight, pre {
    margin: 5px 0;
    padding: 5px;
    border-radius: 3px;
}
.highlight, code, pre {
    border: 1px solid #d6d6d6;
}
```
其实hexo已经支持了代码高亮的设置，所以关于大代码块的高亮设置可以这样做：

首先在<font color="#FFFFFF"><span style="background-color: #68228B;">主页配置文件</span></font>里搜索`hightlight`:

```
highlight:
  enable: true
  line_number: true
  auto_detect: true
  tab_replace:
```
文字自动检测默认不启动，所以改成true使其起作用。

然后在<font color="#FFFFFF"><span style="background-color: #68228B;">主题设置文件</span></font>里搜索`highlight_theme: normal`：
注释显示有五种显示主题可用，分别是：
```
normal
night
night eighties
night blue
night bright
```
具体就看自己选择了，我这里喜欢黑色的，就选了`night`。

# 文章加密访问
**实现方法**

打开themes->next->layout->_partials->head.swig文件,在以下位置插入这样一段代码：

```
<script>
    (function(){
        if('{{ page.password }}'){
            if (prompt('请输入文章密码') !== '{{ page.password }}'){
                alert('密码错误！');
                history.back();
            }
        }
    })();
</script>
```
然后在文章里，头部多加一个`password:xxxxx`就行了。

# 添加社交分享
我这里使用的是`needmoreshare2`，next主题也支持了多种，可以看配置文件里的官方链接选择。

将目录更改为NexT目录,cd到相关位置，然后执行以下指令：
```
git clone https://github.com/theme-next/theme-next-needmoreshare2 source / lib / needsharebutton
```
在<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>中改成：
```
needmoreshare2:
  enable: true
  postbottom:
    enable: true
    options:
      iconStyle: box
      boxForm: horizontal
      position: bottomCenter
      networks: Weibo,Wechat,Douban,QQZone,Twitter,Facebook,Evernote
  float:
    enable: true
    options:
      iconStyle: box
      boxForm: horizontal
      position: middleRight
      networks: Weibo,Wechat,Douban,QQZone,Twitter,Facebook,Evernote
```
更多自定义选项可以参考<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>中的相关注释，`postbottom`部分为每篇文章的转发选项，而`float`部分为博客主页的转发浮动图标。可以修改的选项包括按钮风格，位置，以及社交图标。

# 修改字体颜色/大小/背景色
比如说，想在文章中对某一部分的文字进行强调（改变大小，颜色），该操作具体说明如下：

如果想自定义字体大小以及颜色，可以直接在 Markdown 文档中使用 html 语法：

```
<font size=4 > 这里输入文字，自定义字体大小 </font>
<font color="#FF0000"> 这里输入文字，自定义字体颜色</font> 
<span style="background-color: #ff6600;">这里输入文字，自定义字体背景色</span>
<font color="#000000" size=4><span style="background-color: #ADFF2F;">这是综合起来的效果 </span></font>
<font color="#FFFFFF" size=4><span style="background-color: #68228B;">这是综合起来的效果2 </span></font>
```
其中#FF0000为RGB颜色代码，读者可去RGB颜色查询对照表网站查找自己喜欢的颜色。

若想在RGB颜色值与十六进制颜色码之间相互转化，可查看百度。

**效果如下：**

<font size=4 > 这里输入文字，自定义字体大小 </font>

<font color="#FF0000"> 这里输入文字，自定义字体颜色</font> 

<span style="background-color:
#ff6600;">这里输入文字，自定义字体背景色</span>

<font color="#000000" size=4><span style="background-color: #ADFF2F;">这是综合起来的效果 </span></font>

<font color="#FFFFFF" size=4><span style="background-color: #68228B;">这是综合起来的效果2 </span></font>

# 实现首行缩进
由于markdown语法主要考虑的是英文，所以对于中文的首行缩进并不太友好，因此想要实现行缩进需要加上相应的代码，如下。

在需要缩进行的开头处，先输入下面的代码，然后紧跟着输入文本即可。分号也不要漏掉。

直接写:

```
半方大的空白`&ensp;`或`&#8194`;
全方大的空白`&emsp;`或`&#8195`;
不断行的空白格`&nbsp;`或`&#160`;
```

# 添加搜索功能
笔者采用的是local search。
安装 hexo-generator-searchdb，在站点的根目录下执行以下命令：

`npm install hexo-generator-searchdb --save`

编辑=站点配置文件=（站点根目录下），新增以下内容到任意位置：

```
search:
  path: search.xml
  field: post
  format: html
  limit: 10000
  ```
编辑<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>（主题目录下），启用本地搜索功能：

```
# Local search
local_search:
  enable: true
  ```
之后部署到远程即可。

# Hexo博客提交百度和Google收录
这篇文章写得很详细，我就不详细说了：
[Hexo博客收录百度和谷歌-基于Next主题](https://www.jianshu.com/p/8c0707ce5da4)或者[Hexo个人博客站点被百度谷歌收](https://blog.csdn.net/qq_32454537/article/details/79482914)

# 添加打赏功能
首先，准备支付宝和微信二维码，怎么生成就不多说，百度。

然后在`_config.yml`中配置图片:

```
reward_comment: 坚持原创技术分享，您的支持将鼓励我继续创作！
wechatpay: /images/wechat.jpg
alipay: /images/aipay.png
```

wechat.jpg、aipay.png图片放入`themes/next/source/images`中。

因为这个有个底部文字会闪烁的bug，所以还需要在`next/source/css/_common/components/post/post-reward.styl`里，注释`wechat:hover`和`alipay:hover`，代码如下：

```

/* 注释文字闪动函数

#wechat:hover p{

animation: roll 0.1s infinite linear;
-webkit-animation: roll 0.1s infinite linear;
-moz-animation: roll 0.1s infinite linear;
}

#alipay:hover p{

animation: roll 0.1s infinite linear;
-webkit-animation: roll 0.1s infinite linear;
-moz-animation: roll 0.1s infinite linear;
}
*/

```

# 博文置顶

目前已经有修改后支持置顶的仓库，可以直接用以下命令安装。

```
$ npm uninstall hexo-generator-index --save
$ npm install hexo-generator-index-pin-top --save
```

目前按照上述方法，安装新工具之后，只需要在需要置顶文章上面加上top: true字段即可。

比如说置顶这篇文章：

```
---
title: 测试测试
date: 2018-07-23 01:19:53
categories: tag
tags:
    - 测试
top: true
---
```

然后，可以选择设置置顶图标。

打开：`/blog/themes/next/layout/_macro`目录下的`post.swig`文件，定位到`<div class="post-meta">`标签下，插入如下代码：

```
{% if post.top %}
  <i class="fa fa-thumb-tack"></i>
  <font color=7D26CD>置顶</font>
  <span class="post-meta-divider">|</span>
{% endif %}
```

# 在网站底部加上访问量

**实现效果图**

![访问量](fangwen.jpg)

**具体实现方法 **

打开`\themes\next\layout\partials\footer.swig`文件,在`copyright`前加上这句话： 

```
<script async src="https://dn-lbstatics.qbox.me/busuanzi/2.3/busuanzi.pure.mini.js"></script>
```

然后在`theme.seo`上面添加显示统计的代码： 
```
<div class="powered-by">
<i class="fa fa-user-md"></i><span id="busuanzi_container_site_uv">
  本站访客数:<span id="busuanzi_value_site_uv"></span>
</span>
 <span class="post-meta-divider">|</span>
 <i class="fa fa-user-md"></i><span id="busuanzi_container_site_pv">
  本站总访问量:<span id="busuanzi_value_site_pv"></span>
</span>
 <span class="post-meta-divider">|</span>
</div>
```

在这里有两中不同计算方式的统计代码：

1. pv的方式，单个用户连续点击n篇文章，记录n次访问量

```
<span id="busuanzi_container_site_pv">
    本站总访问量<span id="busuanzi_value_site_pv"></span>次
</span>
```

2. uv的方式，单个用户连续点击n篇文章，只记录1次访客数
```
<span id="busuanzi_container_site_uv">
  本站总访客量<span id="busuanzi_value_site_uv"></span>次
</span>
```
添加之后再执行`hexo d -g`，然后再刷新页面就能看到效果

# SEO优化
太复杂了，直接参考:

[Hexo博客添加SEO-评论系统-阅读统计-站长统计](https://www.jianshu.com/p/2c6ad12791c6)

# 百度谷歌收录
同样有很详细的教程，这里不多说：

收录
[Hexo个人博客站点被百度谷歌收录](https://blog.csdn.net/qq_32454537/article/details/79482914)

# 添加阅读次数统计
注册LeanCloud账号，完成激活；点击左上角的”应用”-“创建新应用”-点击“数据”右边的齿轮–点击创建类class，类名字叫做Counter。
![配置leancloud数据](leancloud1.jpg)

然后，修改<font color="#FFFFFF"><span style="background-color: #68228B;">主题配置文件</span></font>，找到`leancloud_visitors`，添加修改：

```
leancloud_visitors:
  enable: true #将原来的false改为true
  app_id: #<app_id>
  app_key: #<app_key>
```
从设置中找到相应的id和key：
![获取id和key](leancloud2.jpg)

然后预览，就ok啦！

# 设置分类列表
在我们编辑文章的时候，直接在`categories:`项填写属于哪个分类，但如果分类是中文的时候，路径也会包含中文。

比如分类我们设置的是：
```
categories: 编程
```

那在生成页面后，分类列表就会出现编程这个选项，他的访问路径是：
```
*/categories/编程
```
如果我们想要把路径名和分类名分别设置，需要怎么办呢？

打开根目录下的配置文件`_config.yml`，找到如下位置做更改：

```
# Category & Tag
default_category: uncategorized
category_map:
	编程: programming
	生活: life
	其他: other
tag_map:
```

在这里category_map:是设置分类的地方，每行一个分类，冒号前面是分类名称，后面是访问路径。

可以提前在这里设置好一些分类，当编辑的文章填写了对应的分类名时，就会自动的按照对应的路径来访问。

# 设置标签
在编辑文章的时候，tags:后面是设置标签的地方，如果有多个标签的话，可以用下面两种办法来设置：
```
tages: [标签1,标签2,...标签n]
```
或者
```
tages: 
- 标签1
- 标签2
...
- 标签n
```

# 引用本地的文章

```
{% post_link 文章文件名（不要后缀） 文章标题（可选） %}
```

如：

```
{% post_link Hello-World %}
```

```
{% post_link Hello-World 你好世界 %}
```

# 使用标签框

使用方式

```
{% note class_name %} Content (md partial supported) {% endnote %}
```

其中，`class_name` 可以是以下列表中的一个值：

- `bs-callout`
- `default`
- `primary`
- `success`
- `info`
- `warning`
- `danger`

然后看到其他人可以给这个文本框改颜色，所以，可以在`主题配置文件`里找到的`Note tag`就行了。

{% note bs-callout %} # H1标题测试
这个是bs-callout {% endnote %}

{% note default %} # 测试
这个是default {% endnote %}

{% note primary %} # 测试
这个是 primary {% endnote %}

{% note success %} 测试，这个是 success {% endnote %}

{% note info %} 测试，这个是 info {% endnote %}

{% note warning %} 测试，这个是 warning {% endnote %}

{% note danger %} 测试，这个是 danger {% endnote %}

{% note info %} 这个其实也是我在[一个很好看的博客](https://blog.dongleizhang.com/posts/32005d86/)通过F12看到他的设置发找到的文件地方。学习使用HEXO的内置标签 {% endnote %}


# 错误解决方案

## localhost:4000 cannot get
第一种可能是没安装插件，输入指令：

```
npm install hexo-server --save
```

安装完成后，输入以下命令以启动服务器，您的网站会在 http://localhost:4000 下启动。在服务器启动期间，Hexo会监视文件变动并自动更新，您无须重启服务器。
```
hexo server
```
如果您想要更改端口，或是在执行时遇到了 EADDRINUSE 错误，可以在执行时使用 -p 选项指定其他端口，如下：
```
hexo server -p 5000
```
第二种可能，估计是npm安装问题，可以重新安装
```
npm install
```
但当时我出现了
```
npm WARN deprecated ejs@1.0.0: Critical security bugs fixed in 2.5.5
added 10 packages from 6 contributors and audited 3766 packages in 10.51s
found 2 low severity vulnerabilities
  run `npm audit fix` to fix them, or `npm audit` for details
```
按照指示我输入
```
npm audit fix
```

最后一种，直接`hexo g`部署一下，出现所有文件generated后就可以了

## hexo d的时候提示错误
提示下面错误
```
ERROR Deployer not found : github
```
先看<font color="#FFFFFF"><span style="background-color: #68228B;">主页配置文件</span></font>中`_config.yml`里`deploy`要是`type: git`，`repo`这个字段填`https://github.com/yourgit/yourgit.github.io.git

## 其他坑

目前大多都在这里，其他的可以参考网上百度，比如[搭建Hexo博客中碰到的坑](https://www.jianshu.com/p/a2fe56d11c4f)。

---

## 参考

[换了电脑如何使用hexo继续写博](https://blog.csdn.net/lvonve/article/details/79587321)

[Hexo博客彻底解决置顶问题](http://www.netcan666.com/2015/11/22/%E8%A7%A3%E5%86%B3Hexo%E7%BD%AE%E9%A1%B6%E9%97%AE%E9%A2%98/)

[Hexo博客优化之实现来必力评论功能](http://wangwlj.com/2017/12/18/blog_comment/)

[使用Hexo搭建个人博客](https://blog.csdn.net/ace_15/article/details/79255203)

[Hexo博客收录百度和谷歌-基于Next主题](https://www.jianshu.com/p/8c0707ce5da4)

[Hexo个人博客站点被百度谷歌收](https://blog.csdn.net/qq_32454537/article/details/79482914)

[hexo的next主题打赏](https://blog.csdn.net/lcyaiym/article/details/76796545)

[hexo博客的背景设置](https://blog.csdn.net/com_ma/article/details/76039859)

[Hexo博客添加SEO-评论系统-阅读统计-站长统计](https://www.jianshu.com/p/2c6ad12791c6)

[Hexo个人博客站点被百度谷歌收录](https://blog.csdn.net/qq_32454537/article/details/79482914)

[搭建Hexo博客中碰到的坑](https://www.jianshu.com/p/a2fe56d11c4f)

[更改链接颜色](https://blog.csdn.net/qw8880000/article/details/80235648)