---
author: Brendan Rocks
description: |
    A few weeks ago I gave a talk at BARUG (and wrote a post) about blogging
    with the excellent knitr-jekyll repo. Yihui's system is fantastic, but
    it does have one drawback: None of those fancy new htmlwidgets packages
    seem to work...
google-site-verification: 'mN-0GdjM2KkKB8OPxvWfwJvElAOwn0dx9IhWDBbACpI'
og:description: |
    A few weeks ago I gave a talk at BARUG (and wrote a post) about blogging
    with the excellent knitr-jekyll repo. Yihui's system is fantastic, but
    it does have one drawback: None of those fancy new htmlwidgets packages
    seem to work...
og:image: 'http://brendanrocks.com/images/the\_pride.png'
og:title: Using htmlwidgets with knitr and Jekyll
og:url: 'http://brendanrocks.com/htmlwidgets-knitr-jekyll/'
title: Using htmlwidgets with knitr and Jekyll
twitter:card: summary
twitter:creator: '@rocksbrendan'
twitter:description: |
    A few weeks ago I gave a talk at BARUG (and wrote a post) about blogging
    with the excellent knitr-jekyll repo. Yihui's system is fantastic, but
    it does have one drawback: None of those fancy new htmlwidgets packages
    seem to work...
twitter:image:src: 'http://brendanrocks.com/images/the\_pride.png'
twitter:site: '@rocksbrendan'
twitter:title: Using htmlwidgets with knitr and Jekyll
twitter:url: 'http://brendanrocks.com/htmlwidgets-knitr-jekyll/'
viewport: 'width=device-width,initial-scale=1'
...

<div class="container">

<div class="navbar-header">

<span class="sr-only">Toggle navigation</span> <span
class="icon-bar"></span> <span class="icon-bar"></span> <span
class="icon-bar"></span>
[Brendan Rocks](/)

</div>

<div id="navbar" class="navbar-collapse collapse">

-   [About](/about/)
-   [Blog](/blog/)
-   [Work](/work)

</div>

</div>

<div class="page-content">

<div class="wrapper">

<div class="post">

<div id="page-content-wrapper">

<div class="container-fluid">

<div class="row">

<div id="bdy-space" class="col-lg-9 center-block">

<div class="site-section">

[The Blog](/blog)

</div>

Using htmlwidgets with knitr and Jekyll {.post-title}
=======================================

Nov 15, 2015

![](../images/the_pride.png)
\
A few weeks ago I gave a talk at [BARUG](http://www.meetup.com/R-Users/)
(and wrote a [post](/blogging)) about blogging with the excellent
[`knitr-jekyll`](https://github.com/yihui/knitr-jekyll) repo. Yihui’s
system is fantastic, but it does have one drawback: None of those fancy
new [htmlwidgets](htmlwidgets.org) packages seem to work…

A [few](https://twitter.com/bradleyboehmke/status/657384057697902593)
[people](https://github.com/yihui/knitr-jekyll/issues/8) have run into
this. I recently figured out how to fix it for this blog (which required
a bit of time reading through the rmarkdown source), so I thought I’d
write it up in case it helps anyone else, or my future-self.

TL;DR
=====

You can add a line to `build.R` which calls a small wrapper function I
cobbled together
([`brocks::htmlwidgts_deps`](https://github.com/brendan-R/brocks/blob/master/R/blog_stuff.R)),
add a [snippet](#including-the-extra-html) of liquid syntax to
`./_layouts/post.html`, and you’re away.

What’s going on?
================

Often, when you ‘knit’ an .Rmd file to HTML, (perhaps without knowing
it) you’re doing it via the `rmarkdown` package, which adds its own
invisible magic to the process. Behind the scenes, `rmarkdown` uses
`knitr` to convert the file to markdown format, and then uses `pandoc`
to convert the markdown to HTML.

While `knitr` executes R code and embeds results, htmlwidgets packages
(such as `leaflet`, `DiagrammR`, `threejs`, and `metricsgraphics`) also
have js and css dependencies. These are handled by `rmarkdown`’s second
step, and so don’t get included when using `knitr` alone.

The `rmarkdown` invisible magic works as follows:

-   It parses the .Rmd for special dependencies objects, linking to the
    js/css source (by calling `knitr::knit_meta`)
-   It then (by default) combines their source-code into a huge
    `data:uri` blob, which it writes to a temp-file
-   This is injected into the the final HTML file, by passing it to
    `pandoc`’s `--include-in-header` argument

A fix: htmlwdigets\_deps
========================

Happily, including bits of HTML in other bits of HTML is one of Jekyll’s
strengths, and it’s possible to high-jack the
[internals](https://github.com/rstudio/rmarkdown/blob/8a8d3d58d57e36647ffd20aa5ec181228cc77b97/R/html_dependencies.R#L73)
of `rmarkdown` to do something appropriate. I did this with a little
function `htmlwdigets_deps`, which:

-   Copies the js/css dependencies from the R packages, into a dedicated
    assets folder within in your blog

-   Writes a little HTML file, containing the links to the source code
    above

With a small tweak to the `post.html` file, Jekyll’s liquid templating
system can be used to pull in that little HTML file, if htmlwidgets are
detected in your post.

If you’re using `knitr-jekyll`, all that’s needed to make everything
work as you’d expect, is to call the function from your `build.R` file,
like so:

``` {.r}
local({
  # Your existing configurations...
  # See https://github.com/yihui/knitr-jekyll/blob/gh-pages/build.R
  brocks::htmlwidgets_deps(a)
})
```

(The parameter `a` refers to the input file — if you’re using a build
file anything like Yihui’s example, this will work fine.)

If you’d like to have a look at the internals of `htmlwidgets_deps`
yourself, it’s in my personal package [up on
GitHub](https://github.com/brendan-R/brocks/blob/master/R/blog_stuff.R).
Long story short, it mimicks the process of
[`rmarkdown:::html_dependencies_as_string`](https://github.com/rstudio/rmarkdown/blob/8a8d3d58d57e36647ffd20aa5ec181228cc77b97/R/html_dependencies.R#L73),
using functions from the
[htmltools](https://cran.rstudio.com/web/packages/htmltools/) package.
The rest of this post walks through what it actually does to your files.

1. Copying dependencies to your site
------------------------------------

To keep things transparent, the dependency *source* files are kept in
their own folder (`./htmlwidgets_deps`). If it doesn’t exist, it’ll be
created. This behaviour is different to the `rmarkdown` default of
compressing everything into huge in-line `data:uri` blobs. While that
works great for keeping everything in one big self-contained file
(e.g. to email to someone), it makes for a very slow web page. Having
separate files is preferable for a blog, as it allows the browser to
load files *asynchronously*, reducing the load time.

After compiling your site, if you’ve used htmlwidgets you’ll have the
extra `./htmelwidgets_deps` directory within your blog, containing the
source for all the dependencies, a bit like this:

    - _includes
    - _layouts
    - _posts
    - _sass
    - _site
    - _source
    - js/
    - css/
    - htmlwidgets_deps/
        - d3-3.5.3/
            - LICENCE
            - bower.json
            - d3.js
            - d3.min.js
        - jquery-1.11.1
            - AUTHORS.txt
            - jquery.min.js
        - ...
    - ...

2. Writing the extra HTML
-------------------------

Once all the dependencies are ready to be served from your site, you
still need to add HTML pointers to your blog post, so that it knows
where to find them. `htmlwidgets_deps` automates this, by adding a file
for each htmlwidgets post to the `./_includes` directory (which is where
Jekyll goes to look for HTML files to include). For each post which
requires it, the extra HTML file will be generated in the `htmlwidgets`
sub-directory, like this:

    - _includes/
        - htmlwidgets/
            - my-new-htmlwidgets-post.html
        - footer.html
        - head.html
        - header.html
    - _layouts/
    ...

The file itself if pretty simple. Here’s an example:

``` {.html}
<script src="{{ "/htmlwidgets_deps/htmlwidgets-0.5/htmlwidgets.js" | prepend: site.baseurl }}"></script>
<script src="{{ "/htmlwidgets_deps/jquery-2.1.3/dist/jquery.min.js" | prepend: site.baseurl }}"></script>
<script src="{{ "/htmlwidgets_deps/d3-3.5.3/d3.min.js" | prepend: site.baseurl }}"></script>
<link href="{{ "/htmlwidgets_deps/metrics-graphics-2.1.0/dist/metricsgraphics.css" | prepend: site.baseurl }}" rel="stylesheet" />
<script src="{{ "/htmlwidgets_deps/metrics-graphics-2.1.0/dist/metricsgraphics.min.js" | prepend: site.baseurl }}"></script>
<script src="{{ "/htmlwidgets_deps/metricsgraphics-binding-0.8.5/metricsgraphics.js" | prepend: site.baseurl }}"></script>
```

The HTML comes pre-wrapped in the usual liquid syntax.

3. Including the extra HTML
---------------------------

Now you have a little file to include, you just need to get it into the
HTML of the blog post. Jekyll’s templating system liquid is all about
doing this.

Because `htmlwdigets_deps` gives the dependency file the same name as
your `.Rmd` input (and thus the post), it’s quite easy to write a short
`{% include %}` statement, based on the name of the page itself.
However, things get tricky if the file doesn’t exist. By default,
`htmlwdigets_deps` only produces files when necessary (e.g. when you are
actually using htmlwidgets). To handle this, I used a
[plugin](https://github.com/michaelx/jekyll_file_exists), providing the
`file_exists` function.

Adding the following the bottom of `./_layouts/default.html` did the
trick. You could also use `./_layouts/post.html` if you wanted to. It’s
a good idea to put it towards to the bottom, otherwise the page won’t
load until all the htmlwdigets dependencies are loaded, which could make
things feel rather slow.

``` {.html}
<!-- htmlwidgets dependencies --> 
{% assign dep_file = page.url | split: '/' | last | prepend : 'htmlwidgets/' %}
{% assign dep_file_inc = dep_file | prepend : '_includes/' %}
{% capture hw_used %}{% file_exists {{ dep_file_inc }} %}{% endcapture %}

{% if hw_used == "true" %}
{% include {{dep_file}} %}
{% endif %}
```

### With GitHub Pages

The solution above proves a little tricky if you’re using GitHub pages,
as this doesn’t allow plugins. While I’m sure an expert with the liquid
templating engine could come up with a brilliant solution to this, in
lieu, I present a filthy untested hack.

By setting the `htmlwdigets_deps` parameter `always = TRUE`, a
dependencies file will always be produced, even if there’s no
htmlwidgets detected (the file will be empty). This means that you can
do-away with the logic part (and the plugin), and simply add the lines:

``` {.html}
<!-- htmlwidgets dependencies --> 
{% assign dep_file = page.url | split: '/' | last | prepend : 'htmlwidgets/' %}
{% include {{dep_file}} %}
```

The disadvantage is that you’ll end up with some empty HTML files in
`./_includes/htmlwidgets/`, which may or may not bother you. If you’re
only going to be using htmlwidgets for blog posts (and not the rest of
your site) I’d recommend doing this for the `./_layouts/post.html` file,
(as opposed to `default.html`) so that other pages don’t have trouble
finding dependencies they don’t need.

If you give this a crack, let me know!

How to do the same
==================

In summary:

-   Add the [snippet](#including-the-extra-html) of liquid syntax to one
    of your layout files

-   Add the following line to your `build.R` file, just below the call
    to `knitr::knit`

``` {.r}
brocks::htmlwidgets_deps(a)
```

And you should be done!

Showing Off
===========

After all that, it would be a shame not to show off some interactive
visualisations. Here are some of the htmlwidgets packages I’ve had the
chance to muck about with so far.

MetricsGraphics
---------------

[MetricsGraphics.js](http://metricsgraphicsjs.org/) is a JavaScript API,
built on top of [d3.js](http://d3js.org/), which allows you to produce a
lot of common plots very quickly (without having to start from scratch
each time). There’s a few libs like this, but MetricsGraphics is
especially pleasing. Huge thanks to [Ali
Almossawi](http://almossawi.com/) and Mozilla, and also to [Bob
Rudis](http://rud.is/b/) for the R interface.

``` {.r}
library(metricsgraphics)

plots <- lapply(1:4, function(x) {
  mjs_plot(rbeta(1000, x, x), width = 300, height = 300, linked = TRUE) %>%
    mjs_histogram(bar_margin = 2) %>%
    mjs_labs(x_label = sprintf("Plot %d", x))
})

mjs_grid(plots)
```

+--------------------------------------+--------------------------------------+
| <div                                 | <div                                 |
| id="mjs-8f1051875a49d0df9f0db0673121 | id="mjs-965257cb88c3e90f251c61ce4649 |
| db"                                  | db"                                  |
| class="metricsgraphics"              | class="metricsgraphics"              |
| style="width:300px;height:300px">    | style="width:300px;height:300px">    |
|                                      |                                      |
| </div>                               | </div>                               |
|                                      |                                      |
| <div                                 | <div                                 |
| id="mjs-8f1051875a49d0df9f0db0673121 | id="mjs-965257cb88c3e90f251c61ce4649 |
| db-legend"                           | db-legend"                           |
| class="metricsgraphics-legend">      | class="metricsgraphics-legend">      |
|                                      |                                      |
| </div>                               | </div>                               |
+--------------------------------------+--------------------------------------+
| <div                                 | <div                                 |
| id="mjs-723da1d290b3a67d43c4ccd60cf9 | id="mjs-13b1945ec3c64286f8308ceec6b1 |
| 10"                                  | 48"                                  |
| class="metricsgraphics"              | class="metricsgraphics"              |
| style="width:300px;height:300px">    | style="width:300px;height:300px">    |
|                                      |                                      |
| </div>                               | </div>                               |
|                                      |                                      |
| <div                                 | <div                                 |
| id="mjs-723da1d290b3a67d43c4ccd60cf9 | id="mjs-13b1945ec3c64286f8308ceec6b1 |
| 10-legend"                           | 48-legend"                           |
| class="metricsgraphics-legend">      | class="metricsgraphics-legend">      |
|                                      |                                      |
| </div>                               | </div>                               |
+--------------------------------------+--------------------------------------+

leaflet
-------

[leaflet.js](http://leafletjs.com/) allows you to create *beautiful*,
mobile-friendly maps (based on
[OpenStreetMap](http://www.openstreetmap.org/) data), incredibly easily.
Hat tip to [Vladimir Agafonkin](http://agafonkin.com/en/), and [Joe
Cheng](https://twitter.com/jcheng) et al for the R interface!

Here’s the *Pride of Spitalfields*, which I occasionally pine for, from
beneath the palm trees of sunny California.

``` {.r}
library(leaflet)

m <- leaflet() %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  addMarkers(lng = -0.07125, lat = 51.51895, 
             popup = "Reasonably Priced Stella Artois")
m
```

<div id="htmlwidget-4244" class="leaflet"
style="width:504px;height:504px">

</div>

threejs
-------

[three.js](http://threejs.org/) is a gobsmackingly brilliant library for
creating animated, interactive 3D graphics from within a Web browser.
Here’s an interactive 3D globe with the world’s populations mapped as,
erm, light-sabers. Probably not as informative as a base graphics plot,
but it is much more *Bond villianish*. Drag it around and have a zoom!

``` {.r}
library(threejs)
library(maps)
## 
##  # ATTENTION: maps v3.0 has an updated 'world' map.        #
##  # Many country borders and names have changed since 1990. #
##  # Type '?world' or 'news(package="maps")'. See README_v3. #
data(world.cities, package = "maps")
cities <- world.cities[order(world.cities$pop,decreasing = TRUE)[1:1000],]
value  <- 100 * cities$pop / max(cities$pop)

# Set up a data color map and plot
col <- rainbow(10, start = 2.8 / 6, end = 3.4 / 6)
col <- col[floor(length(col) * (100 - value) / 100) + 1]
globejs(lat = cities$lat, long = cities$long, value = value, color = col,
        atmosphere = TRUE)
```

<div id="htmlwidget-5002" class="globe"
style="width:504px;height:504px">

</div>

\
\
Kudos to [Ricardo Cabello/mrdoob](http://mrdoob.com/) for three.js, and
[Bryan W. Lewis](http://illposed.net/) for the [R
package](https://github.com/bwlewis/rthreejs).

Wrapping up
-----------

So, there we go. I hope this might be useful to someone. If you do have
a go at using this, let me know how you get on!

### EDIT: 2015-12-07

Thanks to Suren K in the comments below, I noticed that a plugin
dependency had snuck in to my liquid markup for GitHub pages. Now fixed
to use ‘pluginless’ liquid!

To see if the changes worked, I forked Yihui’s repo, and put a
‘htmlwidgets-proofed’ version up on GitHub
[here](https://github.com/brendan-r/knitr-jekyll), in case it helps
anyone get this going.

<div id="refs" class="references">

</div>

<div id="share-bar" class="social-container">

<div>

Share

</div>

<div>

[**](https://twitter.com/intent/tweet?text=Using+htmlwidgets+with+knitr+and+Jekyll&url=http://brendanrocks.com/htmlwidgets-knitr-jekyll/&via=rocksbrendan&related=rocksbrendan "Share on Twitter")

</div>

<div>

[**](http://www.linkedin.com/shareArticle?mini=true&url=http://brendanrocks.com/htmlwidgets-knitr-jekyll/)

</div>

<div>

[**](javascript:window.open('https://facebook.com/sharer.php?u=http://brendanrocks.com/htmlwidgets-knitr-jekyll/',%20'_blank',%20'width=400,height=500');void(0);)

</div>

<div>

[**](https://news.ycombinator.com/submitlink?u=http://brendanrocks.com/htmlwidgets-knitr-jekyll/)

</div>

</div>

<div id="disqus_thread">

</div>

Please enable JavaScript to view the [comments powered by
Disqus.](https://disqus.com/?ref_noscript)

</div>

<div class="col-lg-3">

<div class="hidden-print hidden-xs hidden-sm hidden-md affix-top"
role="complementary">

<div id="post-sidebar"
style="line-height:180%;margin-left:60px;font-size:16px">

[**   Twitter\
](https://twitter.com/rocksbrendan) [**   Email\
](mailto:rocks.brendan@gmail.com) [**   GitHub\
](https://github.com/brendan-r) [**   LinkedIn\
](https://linkedin.com/in/brendanrocks) [**   RSS\
](/feed.xml)\
\
**Tags**

<div class="tags">

[nps (3)](/tag/nps)\
[benchmarks (3)](/tag/benchmarks)\
[finance (1)](/tag/finance)\
[retail (1)](/tag/retail)\
[technology (1)](/tag/technology)\
[travel (1)](/tag/travel)\
[comcast (1)](/tag/comcast)\
[netflix (1)](/tag/Netflix)\
[telco (1)](/tag/telco)\
[entertainment (1)](/tag/entertainment)\
[r (2)](/tag/R)\
[statistics (2)](/tag/statistics)\

</div>

\
\
**Blogroll**

[Andrew Gelman](http://andrewgelman.com)\
[Mike Bostock](http://bl.ocks.org/mbostock)\
[Flowing Data](http://flowingdata.com/)\
[Tomasz Tunguz](http://tomtunguz.com/)\
[r-bloggers](http://r-bloggers.com)\
[statsblogs](http://www.statsblogs.com/)\
[Satmetrix](http://www.satmetrix.com/)\
[netpromoter.com](http://www.netpromoter.com/)\

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

</div>

<div class="container">

\
© Brendan Rocks 2016

[CONTENT POLICY](/content-policy/) | [TERMS](/terms-of-use/) |
[PRIVACY](/privacy-statement/)

</div>
