---
HandheldFriendly: True
MobileOptimized: 320
description:  via GIPHY 
keywords: 'R, googleformr, useResearch'
title: 'Need user feedback? Send it directly from R – data\_steve'
twitter:card: summary
twitter:creator: '@data\_steve'
twitter:description:  via GIPHY 
twitter:image: '/images/data+steve.png'
twitter:site: '@data\_steve'
twitter:title: 'Need user feedback? Send it directly from R'
viewport: 'width=device-width, initial-scale=1.0'
...

<div class="navigation-wrapper">

-   [Main](/)
-   [About](/about/)
-   [Tags](/tags/)

</div>

<div class="wrap">

[![data\_steve logo](/images/data+steve.png)](/ "data_steve")
[](/) {.site-title .animated .fadeIn}
=====

 {.site-description .animated .fadeIn itemprop="description"}

</div>

<div class="js-menu-screen menu-screen">

</div>

<div id="main" role="main">

<div class="entry-wrapper">

-   [R](/tags/#R "Pages tagged R")
-   [googleformr](/tags/#googleformr "Pages tagged googleformr")
-   [useResearch](/tags/#useResearch "Pages tagged useResearch")

Need user feedback? Send it directly from R {.entry-title}
===========================================

![Steve Simpson bio photo](/images/avatar.jpg) <span
class="author vcard">By <span class="fn">Steve Simpson</span></span>
<span class="entry-date date published">** May 05, 2016</span>
<div class="entry-content">

[via
GIPHY](http://giphy.com/gifs/help-me-you-jerry-macguire-5xtDarnvDIBBEr972uY)

#### Help Me, Help You

As an R-dev, I’d like to know I’m meeting community need, as well as my
own. But after an initial “aha!” moment, you don’t always know how to
live up to the full potential of what you’ve started with a package. For
example, [RStudio collects extensive data through their products to
better understand how to build out the platform and offer other
services.](https://www.rstudio.com/about/privacy-policy/)

So it’d be nice to programmatically allow meaningful user feedback to be
easily sent to me privately without a lot of hassle

googleformr now comes with the function
`gformr_comments`{.highlighter-rouge} function that allows any useR of
googleformr to send **useful, helpful, kind** comments to a Google Form
I have set up for this purpose. Just follow along below:

<div class="highlighter-rouge">

``` {.highlight}
# compose a thoughtful comment and save it to a variable
my_comment <- "I'd love a googleformr feature to help distinguish 
               between lots of posts for one person vs. 
               lots of posts from many people."

# then send the comment
googleformr::gformr_comment(my_comment)
```

</div>

#### useR feedback

Generally, I think this could be a useful feature for many R-devs who’d
like to be accessible to their users.

Most users:

-   don’t run their own blogs,
-   don’t attend useR groups, and
-   don’t have a Github account to post issues.

And really, is an Issue post a place for saying “well done”, or for
making feature requests? Or even, [as a newbie, are your first Github
Issues a stress-free thing to
do?](thttp://www.codenewbie.org/blogs/how-to-make-a-pull-request).

I’d love 100 notes telling me they’d like a googleformr feature to help
distinguish between lots of posts for one person vs. lots of posts from
many people. But I wouldn’t want to have to close out 100 Issues on
Github saying the same thing.

In my next post, I’ll give a short tutorial for adding a feedback
function to your package as well.

[Tweet](https://twitter.com/share)[googleformr](https://github.com/data-steve/googleformr)\
\

</div>

</div>

[Previous](/links-i-liked/ "Links I liked")

</div>

<div class="footer-wrapper">

<span>© 2016 Steve Simpson. Powered by [Jekyll](http://jekyllrb.com)
using the [So Simple
Theme](https://mademistakes.com/work/so-simple-jekyll-theme/).
Syndicated on [R-bloggers](http://www.r-bloggers.com/) </span>
<div class="social-icons">

[**](https://twitter.com/data_steve "Steve Simpson on Twitter")
[**](https://linkedin.com/in/steve-simpson-1a05376 "Steve Simpson on LinkedIn")
[**](https://github.com/data-steve "Steve Simpson on Github")
[**](/feed.xml "Atom/RSS feed")

</div>

</div>
