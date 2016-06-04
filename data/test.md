---
generator: blogger
publisher: Blogger
spiders: ALL
target: global
title: A workflow for publishing RStudio notebooks on Blogger
viewport: width=1100
...

<div id="navbar" class="navbar section">

<div id="Navbar1" class="widget Navbar" data-version="1">

<div id="navbar-iframe-container">

</div>

</div>

</div>

<div class="row">

<div class="fourcol">

<div id="header" class="header section">

<div id="Header1" class="widget Header" data-version="1">

<div id="header-inner">

<div class="titlewrapper">

</div>

<div class="descriptionwrapper">

<span> </span>

</div>

</div>

</div>

</div>

</div>

<div class="eightcol last">

[+](#) [-](#)
<div id="Pages" class="Pages section">

<div id="PageList1" class="widget PageList" data-version="1">

Pages
-----

<div class="widget-content">

-   [About](http://rogiersbart.blogspot.com/p/about_20.html)
-   [Photography](http://rogiersbart.blogspot.com/p/photography.html)
-   [Music](http://rogiersbart.blogspot.com/p/music.html)
-   [Art](http://rogiersbart.blogspot.com/p/art.html)
-   [Science](http://rogiersbart.blogspot.com/p/science.html)
-   [Home](http://rogiersbart.blogspot.com/)

</div>

</div>

</div>

</div>

</div>

<div class="container">

<div class="row">

<div class="eightcol">

<div id="main" class="main section">

<div id="Blog1" class="widget Blog" data-version="1">

<div class="blog-posts hfeed">

<div class="date-outer">

<span> Wednesday, 6 April 2016 </span> {.date-header}
--------------------------------------

<div class="date-posts">

<div class="post-outer">

<div class="post hentry" itemscope="itemscope"
itemtype="http://schema.org/BlogPosting">

<div class="post-i">

[6.4.16](http://rogiersbart.blogspot.com/2016/04/a-workflow-for-publishing-rstudio.html "permanent link")
### <span style="height:30px;"> A workflow for publishing RStudio notebooks on Blogger </span> <span style="float:right;vertical-align:middle;display:inline-block;height:30px;color:#999!important;font-size:12px;line-height:40px;font-weight:normal;"> 6.4.16 </span> {.post-title .entry-title itemprop="name"}

</div>

<div class="clear">

</div>

<div class="post-header">

<div class="post-header-line-1">

</div>

</div>

<div id="post-body-2966270368472168430" class="post-body entry-content"
itemprop="articleBody">

<div style="text-align: justify;">

The past few years, I have been searching regularly for ways of
formatting R code on
[+Blogger](https://plus.google.com/110587955497525318489). Although
different possibilities were available, almost always I ended up using
the online [Pretty R syntax
highlighter](http://www.inside-r.org/pretty-r/tool) by copying parts of
a script and pasting these in blog posts after highlighting.

</div>

<div style="text-align: justify;">

\

</div>

<div style="text-align: justify;">

Thanks to the excellent work of all people
at [+RStudio](https://plus.google.com/110704473211154995841) however, we
can now easily incorporate markdown content in our R scripts (by
compiling them as
[notebooks](http://rmarkdown.rstudio.com/r_notebook_format.html)), which
seems to be very much suited for writing R-related blog posts. While
creating nicely formatted HTML documents is straightforward now, the
problem moves to that of getting an HTML document published as a Blogger
post without destroying the formatting... Which is not straightforward
if you're not an HTML/JavaScript/CSS expert.

</div>

<div style="text-align: justify;">

\

</div>

<div style="text-align: justify;">

Luckily I found a workaround, which I'm outlining below, for my own
future reference! :)

</div>

\
<div>

**Create your R script**\
\
<div class="separator" style="clear: both; text-align: justify;">

As an example, I'm using my last post on [variography with gstat and
ggplot2](http://rogiersbart.blogspot.be/2016/03/variography-with-gstat-and-ggplot2.html).
You can compile the notebook into a self-contained HTML document, but
the images are then included as
[Base64](https://en.wikipedia.org/wiki/Base64) code, and do not get
picked up when sharing the post url on *e.g.* social networks.
Therefore, I chose not to have the HTML self-contained at this point,
which means the images have to be uploaded to Blogger at some point, or
hosted somewhere else with modifications of the image urls in the html
code. The original script can be found
[here](https://docs.google.com/uc?id=0B4xr2UZeAf_mTGRsNUROcU4wR0E&export=download).

</div>

<div class="separator" style="clear: both; text-align: center;">

\

</div>

<div class="separator" style="clear: both; text-align: center;">

[![](https://docs.google.com/uc?id=0B4xr2UZeAf_mdDBnTTZiSmg4WW8&export=download)](https://docs.google.com/uc?id=0B4xr2UZeAf_mdDBnTTZiSmg4WW8&export=download)

</div>

\
 **Compile your notebook**\
<div style="text-align: justify;">

**\
**

</div>

<div style="text-align: justify;">

Once your script is complete, press the "Compile Notebook" button, or
use Ctrl+Shift+K to compile your script to an RStudio notebook. Once the
RStudio HTML preview pops up, check if everything is there.

</div>

\
<div class="separator" style="clear: both; text-align: center;">

[![](https://docs.google.com/uc?id=0B4xr2UZeAf_maFQ3YlRrU3BRY1U&export=download)](https://docs.google.com/uc?id=0B4xr2UZeAf_maFQ3YlRrU3BRY1U&export=download)

</div>

\
\
 **Get self-contained html body code (without images)**\
\
<div style="text-align: justify;">

Now select the contents of the preview, copy it, and paste it into the
Blogger Compose editor. Everything should look exactly as in the RStudio
HTML preview, except for the images, which should not be there at this
point.

</div>

\
<div class="separator" style="clear: both; text-align: center;">

[![](https://docs.google.com/uc?id=0B4xr2UZeAf_mQ0pIRVpHbHNGZWc&export=download)](https://docs.google.com/uc?id=0B4xr2UZeAf_mQ0pIRVpHbHNGZWc&export=download)

</div>

\
 **Modify image urls**\
<div style="text-align: justify;">

**\
**

</div>

<div style="text-align: justify;">

For inserting the images, switch to the HTML editor, and search for the
"img" HTML tags. Then modify the src attributes, so they point to the
urls of the images (you can host them wherever you want, but I'm using
[Google Drive](https://www.google.com/intl/en/drive/)). Another way of
doing this is to upload the images in the Compose editor, and insert
them in the correct place within the notebook.

</div>

<div>

\
<div class="separator" style="clear: both; text-align: center;">

[![](https://docs.google.com/uc?id=0B4xr2UZeAf_mdzFLNElNNEtMYkk&export=download)](https://docs.google.com/uc?id=0B4xr2UZeAf_mdzFLNElNNEtMYkk&export=download)

</div>

\
 **Further modify HTML if necessary**\
<div style="text-align: justify;">

\

</div>

<div style="text-align: justify;">

Now save and preview your post. Are things still looking as expected?
Then you can probably skip this step. If some weird things happened to
your notebook, you might want to check for incompatibilities with your
blog CSS code. In my case, I had to set border-left to 0px for the code
blocks, as my blog CSS uses a border there. This was quickly solved by
doing a find and replace for which I used
[this](https://github.com/rogiersbart/rtoolz/blob/master/R/find_and_replace.R)
R function on a text file with HTML code:

</div>

<div style="text-align: justify;">

\

</div>

``` {.r style="background-color: whitesmoke; border-radius: 4px; border: 1px solid rgb(204, 204, 204); box-sizing: border-box; color: #333333; font-size: 13px; line-height: 1.42857; margin-bottom: 10px; overflow: auto; padding: 9.5px; widows: auto; word-break: break-all; word-wrap: break-word;"}
library(rtoolz)
find_and_replace('html.txt','style="','style="border-left: 0px;')
```

</div>

<div>

After modifying the HTML code, insert it again in the Blogger HTML
editor.\
\
 **Publish**

</div>

<div>

\
 Finally publish the post, and enjoy the RStudio notebook that just
appeared on your blog!\
<div class="separator" style="clear: both; text-align: center;">

\

</div>

<div class="separator" style="clear: both; text-align: center;">

[![](https://docs.google.com/uc?id=0B4xr2UZeAf_ma1JEWjJnMy1vZnc&export=download)](https://docs.google.com/uc?id=0B4xr2UZeAf_ma1JEWjJnMy1vZnc&export=download)

</div>

\

</div>

<div>

Any people out there doing similar things? Please let me know!

</div>

</div>

<div style="clear: both;">

</div>

<div class="breadcrumb">

<div itemscope="itemscope"
itemtype="http://data-vocabulary.org/Breadcrumb" style="display:none;">

[<span itemprop="title">Search
Post</span>](/search/label/?max-results=8)

</div>

<div itemscope="itemscope"
itemtype="http://data-vocabulary.org/Breadcrumb" style="display:none;">

<span class="one-1">Label : </span> <span class="post-labels"> [<span
itemprop="title">
R</span>](http://rogiersbart.blogspot.com/search/label/R) </span>

</div>

</div>

</div>

<div itemscope="itemscope" itemtype="http://schema.org/Blog"
style="display: none;">

<div itemscope="" itemtype="http://data-vocabulary.org/Review">

<span itemprop="rating">5</span> <span itemprop="reviewer">Bart Rogiers:
A workflow for publishing RStudio notebooks on Blogger</span> <span
itemprop="itemreviewed"> The past few years, I have been searching
regularly for ways of formatting R code on +Blogger . Although different
possibilities were avail...</span>

</div>

</div>

</div>

<div id="comments" class="comments">

#### 2 comments:

<div class="comments-content">

<div id="comment-holder">

<div id="bc_0_3C" kind="c">

<div id="bc_0_3CT">

<div id="bc_0_2T" class="comment-thread" kind="r" t="0" u="0">

1.  <div id="bc_0_1B">

    </div>

    <div class="avatar-image-container">

    ![](//lh6.googleusercontent.com/-cuA7sg1LYLo/AAAAAAAAAAI/AAAAAAAAKb4/es1_-XjnRi8/s35-c/photo.jpg)

    </div>

    <div id="c5981752786255617378" class="comment-block">

    <div id="bc_0_1M" class="comment-header" kind="m">

    [Amit
    Kohli](https://www.blogger.com/profile/10917211094175380977)<span
    class="icon user"></span><span class="datetime secondary-text">[11
    April 2016 at
    12:12](http://rogiersbart.blogspot.com/2016/04/a-workflow-for-publishing-rstudio.html?showComment=1460369534790#c5981752786255617378)</span>

    </div>

    This is a pretty cool approach, but it's still annoying to have to
    write into code blocks. I keep looking for the approach where all
    comments are converted to normal text, and all R code is wrapped in
    \`pre\` and \`code\` tags.

    <span id="bc_0_1MN" class="comment-actions secondary-text"
    kind="m">[Reply](javascript:;)<span
    class="item-control blog-admin pid-891468525">[Delete](https://www.blogger.com/delete-comment.g?blogID=8359135036409117410&postID=5981752786255617378)</span></span>

    </div>

    <div id="bc_0_1BR" class="comment-replies">

    <span id="bc_0_1b+seedFGyHD" kind="d"></span>
    <div id="bc_0_0T" class="comment-thread inline-thread" kind="t"
    t="0" u="0">

    <span id="bc_0_0TT" class="thread-toggle thread-expanded"
    kind="g"><span id="bc_0_0TA" class="thread-arrow"></span><span
    id="bc_0_0TN" class="thread-count"><span id="bc_0_0TNT"
    style="display: none;"></span><span id="bc_0_0TNU"
    style="display: none;"></span>[Replies](javascript:;)</span></span>
    <div id="bc_0_0TD" class="thread-dropContainer thread-expanded">

    <span class="thread-drop"></span>

    </div>

    1.  <div id="bc_0_0B">

        </div>

        <div class="avatar-image-container">

        ![](//lh3.googleusercontent.com/-1c4FrEnT_is/AAAAAAAAAAI/AAAAAAABn94/R1crjgvXTc8/s35-c/photo.jpg)

        </div>

        <div id="c6405211549867823729" class="comment-block">

        <div id="bc_0_0M" class="comment-header" kind="m">

        [Bart
        Rogiers](https://www.blogger.com/profile/04022368031690740313)<span
        class="icon user blog-author"></span><span
        class="datetime secondary-text">[11 April 2016 at
        22:47](http://rogiersbart.blogspot.com/2016/04/a-workflow-for-publishing-rstudio.html?showComment=1460407625409#c6405211549867823729)</span>

        </div>

        You don't have to modify the HTML if there are no conflicts with
        the Blogger template you are using! Just try and see if it works
        for you without this step. You can of course also modify the
        template to remove all conflicts. If you then do use the
        self-contained HTML, it's just copy and paste!

        <span id="bc_0_0MN" class="comment-actions secondary-text"
        kind="m"><span
        class="item-control blog-admin pid-1165991408">[Delete](https://www.blogger.com/delete-comment.g?blogID=8359135036409117410&postID=6405211549867823729)</span></span>

        </div>

        <div id="bc_0_0BR" class="comment-replies">

        </div>

        <div id="bc_0_0B_box" class="comment-replybox-single">

        </div>

    <div id="bc_0_0T_box" class="comment-replybox-thread">

    </div>

    </div>

    </div>

    <div id="bc_0_1B_box" class="comment-replybox-single">

    </div>

<div id="bc_0_2I" class="continue" kind="ci">

[Add comment](javascript:;)

</div>

<div id="bc_0_2T_box" class="comment-replybox-thread">

</div>

<div id="bc_0_2L" class="loadmore loaded" kind="rb">

[Load more...](javascript:;)

</div>

</div>

</div>

</div>

</div>

</div>

<div class="comment-form">

<span
id="comment-editor-src">[](https://www.blogger.com/comment-iframe.g?blogID=8359135036409117410&postID=2966270368472168430)</span>

</div>

<div id="backlinks-container">

<div id="Blog1_backlinks-container">

</div>

</div>

</div>

</div>

</div>

</div>

</div>

<div id="blog-pager" class="blog-pager">

<span id="blog-pager-older-link"> <span
id="Blog1_blog-pager-older-link">[&gt;](http://rogiersbart.blogspot.com/2016/03/weekly-photographs-21-to-30.html "Older Post")</span>
</span>

</div>

<div class="clear">

</div>

<div class="post-feeds">

<div class="feed-links">

Subscribe to: [Post Comments
(Atom)](http://rogiersbart.blogspot.com/feeds/2966270368472168430/comments/default)

</div>

</div>

</div>

</div>

<div class="clear">

</div>

</div>

<div class="fourcol last">

<div id="PopularPosts" class="PopularPosts section">

<div id="Label1" class="widget Label" data-version="1">

Labels
------

<div class="widget-content cloud-label-widget-content">

<span class="label-size label-size-5">
[Art](http://rogiersbart.blogspot.com/search/label/Art) <span
class="label-count" dir="ltr">(20)</span> </span> <span
class="label-size label-size-3"> [Guitar
lesson](http://rogiersbart.blogspot.com/search/label/Guitar%20lesson)
<span class="label-count" dir="ltr">(9)</span> </span> <span
class="label-size label-size-5">
[Music](http://rogiersbart.blogspot.com/search/label/Music) <span
class="label-count" dir="ltr">(18)</span> </span> <span
class="label-size label-size-1">
[Photography](http://rogiersbart.blogspot.com/search/label/Photography)
<span class="label-count" dir="ltr">(4)</span> </span> <span
class="label-size label-size-4">
[Publication](http://rogiersbart.blogspot.com/search/label/Publication)
<span class="label-count" dir="ltr">(12)</span> </span> <span
class="label-size label-size-4">
[R](http://rogiersbart.blogspot.com/search/label/R) <span
class="label-count" dir="ltr">(13)</span> </span> <span
class="label-size label-size-3">
[Recording](http://rogiersbart.blogspot.com/search/label/Recording)
<span class="label-count" dir="ltr">(7)</span> </span> <span
class="label-size label-size-5">
[Science](http://rogiersbart.blogspot.com/search/label/Science) <span
class="label-count" dir="ltr">(24)</span> </span> <span
class="label-size label-size-1">
[Software](http://rogiersbart.blogspot.com/search/label/Software) <span
class="label-count" dir="ltr">(4)</span> </span>

</div>

</div>

<div id="CustomSearch1" class="widget CustomSearch" data-version="1">

Search This Blog {.title}
----------------

<div class="widget-content">

<div id="CustomSearch1_form">

<span class="cse-status">Loading...</span>

</div>

</div>

</div>

</div>

<div class="clear">

</div>

</div>

</div>

</div>

<div class="row">

<div class="eightcol">

Copyright © [Bart
Rogiers](http://rogiersbart.blogspot.com/ "All Rights Reserved")-
Displays best in [Google
Chrome](https://www.google.nl/chrome/browser/desktop/) -
[Attributions](http://rogiersbart.blogspot.com/p/attributions.html)

</div>

<div class="fourcol last">

<div id="footer" class="footer section">

</div>

</div>

</div>
