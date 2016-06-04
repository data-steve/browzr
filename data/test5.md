---
generator: 'WordPress 4.3.1'
title: 'Another take on building a multi-lingual shiny app | Christophe Ladroue'
...

<div id="wrapper" class="hfeed">

<div id="header">

<div id="masthead">

<div id="branding" role="banner">

<div id="site-title">

<span> [Christophe
Ladroue](http://chrisladroue.com/ "Christophe Ladroue") </span>

</div>

<div id="site-description">

</div>

![](http://chrisladroue.com/wp-content/uploads/2011/03/banner_green1.png)

</div>

<div id="access" role="navigation">

<div class="skip-link screen-reader-text">

[Skip to content](#content "Skip to content")

</div>

<div class="menu">

-   [Home](http://chrisladroue.com/)
-   [Publications](http://chrisladroue.com/publications/)
-   [Software](http://chrisladroue.com/software/)
    -   [Brownian Motion and Iterated Integrals on
        Mathematica](http://chrisladroue.com/software/brownian-motion-and-iterated-integrals-on-mathematica/)
    -   [Fractional Orstein-Uhlenbeck
        process](http://chrisladroue.com/software/fractional-orstein-uhlenbeck-process/)
    -   [Granger Causality for large
        networks](http://chrisladroue.com/software/granger/)
    -   [Matlab script for parsing Agilent
        output (microarrays)](http://chrisladroue.com/software/matlab-script-for-parsing-agilent-output-microarrays/)
-   [Scripting](http://chrisladroue.com/scripting/)
    -   [Astronomy Picture of the
        Day](http://chrisladroue.com/scripting/astronomy-picture-of-the-day/)
    -   [Bing.py](http://chrisladroue.com/scripting/bing-py/)
    -   [nationalGeographic.py](http://chrisladroue.com/scripting/nationalgeographic-py/)
    -   [CiteULike
        plugins](http://chrisladroue.com/scripting/citeulike-plugins/)
    -   [Proxy-free CiteULike
        Button](http://chrisladroue.com/scripting/134-2/)
    -   [bashPodder](http://chrisladroue.com/scripting/bashpodder/)
    -   [DVD filler](http://chrisladroue.com/scripting/dvd-filler/)
    -   [GrabRadio.sh](http://chrisladroue.com/scripting/grabradio-sh/)
-   [Blog](http://chrisladroue.com/blog/)
-   [Contact](http://chrisladroue.com/contact/)

</div>

</div>

</div>

</div>

<div id="main">

<div id="container">

<div id="content" role="main">

<div id="nav-above" class="navigation">

<div class="nav-previous">

[<span class="meta-nav">←</span> How to pick up 3 numbers from a uniform
distribution in a transparent
manner?](http://chrisladroue.com/2014/07/how-to-pick-up-3-numbers-from-a-uniform-distribution-in-a-transparent-manner/)

</div>

<div class="nav-next">

</div>

</div>

<div id="post-1134"
class="post-1134 post type-post status-publish format-standard hentry category-uncategorized tag-multilingual tag-r tag-shiny">

Another take on building a multi-lingual shiny app {.entry-title}
==================================================

<div class="entry-meta">

<span class="meta-prep meta-prep-author">Posted on</span> [<span
class="entry-date">November 8,
2014</span>](http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/ "15:58")
<span class="meta-sep">by</span> <span
class="author vcard">[CL](http://chrisladroue.com/author/cl/ "View all posts by CL")</span>

</div>

<div class="entry-content">

[![](http://chrisladroue.com/wp-content/uploads/2014/11/multilingualShinyApp1.png "multilingualShinyApp")](http://chrisladroue.com/wp-content/uploads/2014/11/multilingualShinyApp1.png)I
was reading [this interesting
post](http://withr.me/blog/2014/10/17/design-a-bilingual-shiny-application/)
about how to build a multi-lingual `Shiny` app. I’m also building a
multi-lingual `Shiny` app and came up with slightly different take on
it.

First, I don’t use a function for finding the translation, but a 2D
list. This way I can directly get to the translation with a simple
access to the list.

<div class="my_syntax_box">

<span class="my_syntax_selecall">[Select All](javascript:;) </span><span
class="my_syntax_Bar">Code:</span>
<div class="my_syntax">

+--------------------------------------+--------------------------------------+
|     1                                | ``` {.rsplus style="font-family:mono |
|     2                                | space;"}                             |
|     3                                | translation <- list(                 |
|     4                                |   "youhaveselected" = list("en" = "Y |
|     5                                | ou have selected:", "fr"="Vous avez  |
|     6                                | sélectionné:"),                      |
|     7                                |   "greetings" = list("en" = "Hello", |
|                                      |  "fr"="Bonjour")                     |
|                                      |   )                                  |
|                                      | # then:                              |
|                                      | translation[['greetings']][['en']] # |
|                                      |  Hello                               |
|                                      | translation[['greetings']][['fr']]   |
|                                      | # Bonjour                            |
|                                      | ```                                  |
+--------------------------------------+--------------------------------------+

</div>

</div>

Second, I don’t use `observe`, as I didn’t find it necessary. I simply
have a radio button for switching between languages, and a function
`tr()` to translate a phrase or a list of phrases. Like in the original
post, the UI is built from `server.R` using `renderUI()`.

<div class="my_syntax_box">

<span class="my_syntax_selecall">[Select All](javascript:;) </span><span
class="my_syntax_Bar">Code:</span>
<div class="my_syntax">

+--------------------------------------+--------------------------------------+
|     1                                | ``` {.rsplus style="font-family:mono |
|     2                                | space;"}                             |
|     3                                |   tr <- function(text){ # translates |
|                                      |  text into current language          |
|                                      |     sapply(text,function(s) translat |
|                                      | ion[[s]][[input$language]], USE.NAME |
|                                      | S=FALSE)                             |
|                                      |   }                                  |
|                                      | ```                                  |
+--------------------------------------+--------------------------------------+

</div>

</div>

<div class="my_syntax_box">

<span class="my_syntax_selecall">[Select All](javascript:;) </span><span
class="my_syntax_Bar">Code:</span>
<div class="my_syntax">

+--------------------------------------+--------------------------------------+
|     1                                | ``` {.rsplus style="font-family:mono |
|     2                                | space;"}                             |
|     3                                |                                      |
|     4                                |   # UI                               |
|     5                                |   output$uiObs <- renderUI({         |
|     6                                |     sliderInput("obs", tr("numberOfO |
|     7                                | bservations"),                       |
|     8                                |                   min = 1, max = 100 |
|     9                                | , value = 50)                        |
|     10                               |   })                                 |
|     11                               |                                      |
|     12                               |   output$uiWeekdays <- renderUI({    |
|     13                               |     # Using a named list in order to |
|     14                               |  pass the same value regardless of t |
|     15                               | he label (which changes with the lan |
|     16                               | guage)                               |
|     17                               |     daysValue <- c("Monday", "Tuesda |
|                                      | y", "Wednesday", "Thursday", "Friday |
|                                      | ", "Saturday", "Sunday")             |
|                                      |     days <- structure(daysValue, .Na |
|                                      | mes = tr(daysValue))                 |
|                                      |                                      |
|                                      |     selectInput(inputId   = "weekday |
|                                      | s",                                  |
|                                      |                 label     = tr("Sele |
|                                      | ction:"),                            |
|                                      |                 choices   = days,    |
|                                      |                 multiple  = TRUE)    |
|                                      |   })                                 |
|                                      | ```                                  |
+--------------------------------------+--------------------------------------+

</div>

</div>

To make things easier for the translators, the dictionary is stored as a
csv file, which is easy to edit. A small `R` script turns the csv into
the expected 2D list, and saves it in a binary file, to avoid
re-processing the file every time the user decides to switch language.

<div class="my_syntax_box">

<span class="my_syntax_selecall">[Select All](javascript:;) </span><span
class="my_syntax_Bar">Code:</span>
<div class="my_syntax">

+--------------------------------------+--------------------------------------+
|     1                                | ``` {.rsplus style="font-family:mono |
|     2                                | space;"}                             |
|     3                                | # update the processed translation f |
|     4                                | ile translation.bin                  |
|     5                                | # run this every time dictionary.csv |
|     6                                |  is updated                          |
|     7                                | # it reads the look-up table in dict |
|     8                                | ionary.csv and turns it into a 2D li |
|     9                                | st                                   |
|                                      |                                      |
|                                      | library(plyr)                        |
|                                      | translationContent <- read.delim("di |
|                                      | ctionary.csv", header = TRUE, sep =  |
|                                      | "\t", as.is = TRUE)                  |
|                                      | translation <- dlply(translationCont |
|                                      | ent ,.(key), function(s) key = as.li |
|                                      | st(s))                               |
|                                      |                                      |
|                                      | save(translation, file = "translatio |
|                                      | n.bin")                              |
|                                      | ```                                  |
+--------------------------------------+--------------------------------------+

</div>

</div>

You can consult the whole code on [the github
repository](https://github.com/chrislad/multilingualShinyApp) and run it
directly from `R` using:

<div class="my_syntax_box">

<span class="my_syntax_selecall">[Select All](javascript:;) </span><span
class="my_syntax_Bar">Code:</span>
<div class="my_syntax">

+--------------------------------------+--------------------------------------+
|     1                                | ``` {.rsplus style="font-family:mono |
|                                      | space;"}                             |
|                                      | shiny::runGitHub("multilingualShinyA |
|                                      | pp","chrislad")                      |
|                                      | ```                                  |
+--------------------------------------+--------------------------------------+

</div>

</div>

</div>

<div class="entry-utility">

This entry was posted in
[Uncategorized](http://chrisladroue.com/category/uncategorized/) and
tagged [multilingual](http://chrisladroue.com/tag/multilingual/),
[R](http://chrisladroue.com/tag/r/),
[shiny](http://chrisladroue.com/tag/shiny/). Bookmark the
[permalink](http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/ "Permalink to Another take on building a multi-lingual shiny app").

</div>

</div>

<div id="nav-below" class="navigation">

<div class="nav-previous">

[<span class="meta-nav">←</span> How to pick up 3 numbers from a uniform
distribution in a transparent
manner?](http://chrisladroue.com/2014/07/how-to-pick-up-3-numbers-from-a-uniform-distribution-in-a-transparent-manner/)

</div>

<div class="nav-next">

</div>

</div>

<div id="comments">

### 2 Responses to *Another take on building a multi-lingual shiny app* {#comments-title}

1.  <div id="li-comment-4703">

    </div>

    <div id="comment-4703">

    <div class="comment-author vcard">

    ![](http://1.gravatar.com/avatar/4d9289caf7b5f4e98c283adc88dae382?s=40&r=g)
    [Huidong](http://withr.me) <span class="says">says:</span>

    </div>

    <div class="comment-meta commentmetadata">

    [November 10, 2014 at
    10:05](http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/#comment-4703)

    </div>

    <div class="comment-body">

    Hi, you are right, it’s not necessary to use ‘Observe’. I included
    it because there are other codes (hidden) need it. Anyway, I think
    your blog is valuable!

    </div>

    <div class="reply">

    </div>

    </div>

    -   <div id="li-comment-4704">

        </div>

        <div id="comment-4704">

        <div class="comment-author vcard">

        ![](http://0.gravatar.com/avatar/6a8ffc2770e86084a289a867492df6bb?s=40&r=g)
        CL <span class="says">says:</span>

        </div>

        <div class="comment-meta commentmetadata">

        [November 10, 2014 at
        10:12](http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/#comment-4704)

        </div>

        <div class="comment-body">

        I see! Indeed, I was a bit confused by the use of `observe()`,
        thank you for the clarification!

        Cheers!

        </div>

        <div class="reply">

        </div>

        </div>

</div>

</div>

</div>

<div id="primary" class="widget-area" role="complementary">

-   <div id="text-5">

    </div>

    ### CL’s blog {.widget-title}

    <div class="textwidget">

    An intermittent blog about R, programming and other things I find
    interesting and want to share.

    </div>

-   <div id="text-6">

    </div>

    <div class="textwidget">

    The content of this blog is licensed under [![Creative Commons
    Licence](http://i.creativecommons.org/l/by-nc-sa/3.0/80x15.png)](http://creativecommons.org/licenses/by-nc-sa/3.0/).

    </div>

-   <div id="text-4">

    </div>

    <div class="textwidget">

    ![](http://chrisladroue.com/wp-includes/images/rss.png) [Blog
    feed](http://feeds.feedburner.com/ChristopheLadroueBlog)

    </div>

-   <div id="linkcat-2">

    </div>

    ### Blogroll {.widget-title}

    -   [Active R questions on
        StackOverflow](http://stackoverflow.com/questions/tagged/?tagnames=r&sort=active)
    -   [Flowing
        Data](http://flowingdata.com/ "The visualization and statistics site of Nathan Yau.")
        The visualization and statistics site of Nathan Yau.
    -   [Getting Genetics
        Done](http://gettinggeneticsdone.blogspot.com/ "Software, Tips, & Productivity Hacks For Getting Things Done In Genetics Research")
        Software, Tips, & Productivity Hacks For Getting Things Done In
        Genetics Research
    -   [Information Is
        Beautiful](http://www.informationisbeautiful.net/ "Ideas, issues, knowledge, data – visualized!")
        Ideas, issues, knowledge, data – visualized!
    -   [R-Bloggers](http://www.r-bloggers.com/ "R news and tutorials contributed by (190+) R bloggers")
        R news and tutorials contributed by (190+) R bloggers
    -   [Retraction
        Watch](http://retractionwatch.wordpress.com/ "An interesting side of scientific publishing")
        An interesting side of scientific publishing
    -   [Statistical Modeling, Causal Inference, and Social
        Science](http://www.stat.columbia.edu/~cook/movabletype/mlm/ "(Mostly) Andrew Gelman’s blog") (Mostly)
        Andrew Gelman’s blog
    -   [The
        Endeavour](http://www.johndcook.com/blog/ "John Cook’s blog")
        John Cook’s blog
    -   [The Statistics
        Forum](http://statisticsforum.wordpress.com/ "provides everyone the opportunity to participate in discussions about probability and statistics and their role in important and interesting topics.")
        provides everyone the opportunity to participate in discussions
        about probability and statistics and their role in important and
        interesting topics.

</div>

<div id="secondary" class="widget-area" role="complementary">

-   <div id="recent-posts-2">

    </div>

    ### Latest posts {.widget-title}

    -   [Another take on building a multi-lingual shiny
        app](http://chrisladroue.com/2014/11/another-take-on-building-a-multi-lingual-shiny-app/)
    -   [How to pick up 3 numbers from a uniform distribution in a
        transparent
        manner?](http://chrisladroue.com/2014/07/how-to-pick-up-3-numbers-from-a-uniform-distribution-in-a-transparent-manner/)
    -   [Win a free copy of a new video course on ggplot2 and
        Shiny!](http://chrisladroue.com/2014/07/win-a-free-copy-of-a-new-video-course-on-ggplot2-and-shiny/)
    -   [A two-hour online course on ggplot2 and
        Shiny](http://chrisladroue.com/2014/06/a-two-hour-online-course-on-ggplot2-and-shiny/)
    -   [A very quick introduction to
        ggplot2](http://chrisladroue.com/2012/10/a-very-quick-introduction-to-ggplot2/)

</div>

</div>

<div id="footer" role="contentinfo">

<div id="colophon">

<div id="footer-widget-area" role="complementary">

<div id="first" class="widget-area">

-   <div id="text-3">

    </div>

    ### Credits {.widget-title}

    <div class="textwidget">

    This website is powered by
    [wordpress](http://www.wordpress.org "wordPress"). It uses the
    following plugins:[Portfolio
    Slideshow](http://wordpress.org/extend/plugins/portfolio-slideshow/ "Portfolio Slideshow"),
    [LaTeX](http://wordpress.org/extend/plugins/wp-latex/ "WP LaTeX"),[My
    Syntax](http://wordpress.org/extend/plugins/my-syntax/ "My Syntax").\
     The word clouds were created
    with [wordle.net](http://www.wordle.net "Wordle"). Banner done by
    following instructions from [Heathenx's Inkscape
    tutorials](http://screencasters.heathenx.org/episode-104)

    </div>

</div>

</div>

<div id="site-info">

[Christophe Ladroue](http://chrisladroue.com/ "Christophe Ladroue")

</div>

<div id="site-generator">

[Proudly powered by
WordPress.](http://wordpress.org/ "Semantic Personal Publishing Platform")

</div>

</div>

</div>

</div>
