---
generator: 'WordPress 4.5.1'
title: |
    Correctly Reporting P-Values in Summary Tables Reported with xtable |
    Bearded Analytics
...

<div id="container" class="hfeed">

<div id="page" class="blog">

<div id="header">

<div id="site-title">

<span> [Bearded
Analytics](http://www.beardedanalytics.com/ "Bearded Analytics") </span>

</div>

<div id="pic">

[![](http://www.beardedanalytics.com/wp-content/uploads/2015/02/WideLogoForBlog.jpg)](http://www.beardedanalytics.com/)

</div>

<div id="nav" role="navigation">

<div class="skip-link screen-reader-text">

[Skip to content](#content "Skip to content")

</div>

<div class="menu">

-   [Home](http://www.beardedanalytics.com/)
-   [About Todd](http://www.beardedanalytics.com/about-todd/)
-   [About Jeremy](http://www.beardedanalytics.com/about-jeremey/)
-   [About Michael](http://www.beardedanalytics.com/about-michael/)

</div>

</div>

</div>

<div id="content-box">

<div id="content-container">

<div id="content" role="main">

<div id="nav-above" class="navigation">

<div class="nav-previous">

[<span class="meta-nav">←</span> Quick Bar Graph in Sql
Server](http://www.beardedanalytics.com/quick-bar-graph-in-sql-server/)

</div>

<div class="nav-next">

</div>

</div>

<div id="post-302"
class="post-302 post type-post status-publish format-standard hentry category-r tag-r tag-xtable">

<div class="entry-meta">

<span class="by-author"><span class="sep">by</span> <span
class="author vcard">[Michael
Floren](http://www.beardedanalytics.com/author/mfloren/ "View all posts by Michael Floren")</span>
| </span>March 11, 2016 · 5:45 am

</div>

<div class="jump">

[<span class="meta-nav">↓ </span>Jump to
Comments](http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/#comments)

</div>

[Correctly Reporting P-Values in Summary Tables Reported with xtable](http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/) {.entry-title}
===========================================================================================================================================================================

<div class="entry entry-content">

<div class="pf-content">

<div class="printfriendly pf-alignleft">

[![Print Friendly](http://cdn.printfriendly.com/pf-button.gif)](#)

</div>

Often when writing a manuscript in using knitr and xtable I am flustered
by my p-values. In simple summary tables, R conveniently rounds my
p-values to be 0: a mathematically inappropriate task. A colleague
recently commented on the poor reporting of my table (shown below using
print.xtable with the type="html" argument), inspiring a much needed
change.\

                 Estimate       Std.err        Wald           Pr(&gt;|W|)
  -------------- -------------- -------------- -------------- --------------
  (Intercept)    0.001704       0.000005       100409.770956  0.000000
  sizemedium     0.000046       0.000005       90.534705      0.000000
  sizesmall      0.000003       0.000005       0.294331       0.587458
  time           -0.000004      0.000001       11.614917      0.000654

 

The fix is actually fairly straight forward, and can be summarized in a
simple function: "fixp", with the code shown below:

<div id="crayon-572bc23191532857097595"
class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-mac print-yes notranslate"
data-settings=" minimize scroll-mouseover"
style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">

<div class="crayon-toolbar"
data-settings=" mouseover overlay hide delay"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title">fixp Function</span>
<div class="crayon-tools"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<div class="crayon-button crayon-nums-button"
title="Toggle Line Numbers">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-plain-button"
title="Toggle Plain Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-wrap-button" title="Toggle Line Wrap">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-expand-button" title="Expand Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-copy-button" title="Copy">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-popup-button"
title="Open Code In New Window">

<div class="crayon-button-icon">

</div>

</div>

<span class="crayon-language">R</span>

</div>

</div>

<div class="crayon-info"
style="min-height: 16.8px !important; line-height: 16.8px !important;">

</div>

<div class="crayon-plain-wrap">

fixp &lt;- function(x, dig=3){ x &lt;- as.data.frame(x)
if(substr(names(x)\[ncol(x)\],1,2) != "Pr") warning("The name of the
last column didn't start with Pr. This may indicate that p-values
weren't in the last row, and thus, that this function is
inappropriate.") x\[,ncol(x)\] &lt;- round(x\[,ncol(x)\], dig) for(i in
1:nrow(x)){ if(x\[i,ncol(x)\] == 0) x\[i,ncol(x)\] &lt;- paste0("&lt;
.", paste0(rep(0,dig-1), collapse=""), "1") } x }

</div>

<div class="crayon-main" style="">

+--------------------------------------+--------------------------------------+
| <div class="crayon-nums-content"     | <div class="crayon-pre"              |
| style="font-size: 12px !important; l | style="font-size: 12px !important; l |
| ine-height: 15px !important;">       | ine-height: 15px !important; -moz-ta |
|                                      | b-size:4; -o-tab-size:4; -webkit-tab |
| <div class="crayon-num"              | -size:4; tab-size:4;">               |
| data-line="crayon-572bc2319153285709 |                                      |
| 7595-1">                             | <div                                 |
|                                      | id="crayon-572bc23191532857097595-1" |
| 1                                    | class="crayon-line">                 |
|                                      |                                      |
| </div>                               | <span                                |
|                                      | class="crayon-v">fixp</span><span    |
| <div                                 | class="crayon-h"> </span><span       |
| class="crayon-num crayon-striped-num | class="crayon-o">&lt;</span><span    |
| "                                    | class="crayon-o">-</span><span       |
| data-line="crayon-572bc2319153285709 | class="crayon-h"> </span><span       |
| 7595-2">                             | class="crayon-t">function</span><spa |
|                                      | n                                    |
| 2                                    | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
| </div>                               | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
| <div class="crayon-num"              | class="crayon-v">dig</span><span     |
| data-line="crayon-572bc2319153285709 | class="crayon-o">=</span><span       |
| 7595-3">                             | class="crayon-cn">3</span><span      |
|                                      | class="crayon-sy">)</span><span      |
| 3                                    | class="crayon-sy">{</span>           |
|                                      |                                      |
| </div>                               | </div>                               |
|                                      |                                      |
| <div                                 | <div                                 |
| class="crayon-num crayon-striped-num | id="crayon-572bc23191532857097595-2" |
| "                                    | class="crayon-line crayon-striped-li |
| data-line="crayon-572bc2319153285709 | ne">                                 |
| 7595-4">                             |                                      |
|                                      | <span                                |
| 4                                    | class="crayon-h">  </span><span      |
|                                      | class="crayon-v">x</span><span       |
| </div>                               | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">&lt;</span><span    |
| <div class="crayon-num"              | class="crayon-o">-</span><span       |
| data-line="crayon-572bc2319153285709 | class="crayon-h"> </span><span       |
| 7595-5">                             | class="crayon-st">as</span><span     |
|                                      | class="crayon-sy">.</span><span      |
| 5                                    | class="crayon-v">data</span><span    |
|                                      | class="crayon-sy">.</span><span      |
| </div>                               | class="crayon-e">frame</span><span   |
|                                      | class="crayon-sy">(</span><span      |
| <div                                 | class="crayon-v">x</span><span       |
| class="crayon-num crayon-striped-num | class="crayon-sy">)</span>           |
| "                                    |                                      |
| data-line="crayon-572bc2319153285709 | </div>                               |
| 7595-6">                             |                                      |
|                                      | <div                                 |
| 6                                    | id="crayon-572bc23191532857097595-3" |
|                                      | class="crayon-line">                 |
| </div>                               |                                      |
|                                      | <span class="crayon-h">  </span>     |
| <div class="crayon-num"              |                                      |
| data-line="crayon-572bc2319153285709 | </div>                               |
| 7595-7">                             |                                      |
|                                      | <div                                 |
| 7                                    | id="crayon-572bc23191532857097595-4" |
|                                      | class="crayon-line crayon-striped-li |
| </div>                               | ne">                                 |
|                                      |                                      |
| <div                                 | <span                                |
| class="crayon-num crayon-striped-num | class="crayon-h">  </span><span      |
| "                                    | class="crayon-st">if</span><span     |
| data-line="crayon-572bc2319153285709 | class="crayon-sy">(</span><span      |
| 7595-8">                             | class="crayon-e">substr</span><span  |
|                                      | class="crayon-sy">(</span><span      |
| 8                                    | class="crayon-e">names</span><span   |
|                                      | class="crayon-sy">(</span><span      |
| </div>                               | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
| <div class="crayon-num"              | class="crayon-sy">\[</span><span     |
| data-line="crayon-572bc2319153285709 | class="crayon-e">ncol</span><span    |
| 7595-9">                             | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
| 9                                    | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">\]</span><span     |
| </div>                               | class="crayon-sy">,</span><span      |
|                                      | class="crayon-cn">1</span><span      |
| <div                                 | class="crayon-sy">,</span><span      |
| class="crayon-num crayon-striped-num | class="crayon-cn">2</span><span      |
| "                                    | class="crayon-sy">)</span><span      |
| data-line="crayon-572bc2319153285709 | class="crayon-h"> </span><span       |
| 7595-10">                            | class="crayon-o">!=</span><span      |
|                                      | class="crayon-h"> </span><span       |
| 10                                   | class="crayon-s">"Pr"</span><span    |
|                                      | class="crayon-sy">)</span>           |
| </div>                               |                                      |
|                                      | </div>                               |
| <div class="crayon-num"              |                                      |
| data-line="crayon-572bc2319153285709 | <div                                 |
| 7595-11">                            | id="crayon-572bc23191532857097595-5" |
|                                      | class="crayon-line">                 |
| 11                                   |                                      |
|                                      | <span                                |
| </div>                               | class="crayon-h">    </span><span    |
|                                      | class="crayon-r">warning</span><span |
| <div                                 | class="crayon-sy">(</span><span      |
| class="crayon-num crayon-striped-num | class="crayon-s">"The name of the    |
| "                                    | last column didn't start with Pr.    |
| data-line="crayon-572bc2319153285709 | This may indicate that p-values      |
| 7595-12">                            | weren't in the last row, and thus,   |
|                                      | that this function is                |
| 12                                   | inappropriate."</span><span          |
|                                      | class="crayon-sy">)</span>           |
| </div>                               |                                      |
|                                      | </div>                               |
| <div class="crayon-num"              |                                      |
| data-line="crayon-572bc2319153285709 | <div                                 |
| 7595-13">                            | id="crayon-572bc23191532857097595-6" |
|                                      | class="crayon-line crayon-striped-li |
| 13                                   | ne">                                 |
|                                      |                                      |
| </div>                               | <span                                |
|                                      | class="crayon-h">  </span><span      |
| </div>                               | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">\[</span><span     |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-e">ncol</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">\]</span><span     |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">&lt;</span><span    |
|                                      | class="crayon-o">-</span><span       |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-e">round</span><span   |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">\[</span><span     |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-e">ncol</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">\]</span><span     |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-v">dig</span><span     |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-7" |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-h">  </span><span      |
|                                      | class="crayon-st">for</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-i">i</span><span       |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-st">in</span><span     |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-cn">1</span><span      |
|                                      | class="crayon-o">:</span><span       |
|                                      | class="crayon-e">nrow</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">{</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-8" |
|                                      | class="crayon-line crayon-striped-li |
|                                      | ne">                                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-h">    </span><span    |
|                                      | class="crayon-st">if</span><span     |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">\[</span><span     |
|                                      | class="crayon-v">i</span><span       |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-e">ncol</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">\]</span><span     |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">==</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-cn">0</span><span      |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-9" |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-h">      </span><span  |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">\[</span><span     |
|                                      | class="crayon-v">i</span><span       |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-e">ncol</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">x</span><span       |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">\]</span><span     |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">&lt;</span><span    |
|                                      | class="crayon-o">-</span><span       |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-e">paste0</span><span  |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-s">"&lt;               |
|                                      | ."</span><span                       |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-e">paste0</span><span  |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-e">rep</span><span     |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-cn">0</span><span      |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-v">dig</span><span     |
|                                      | class="crayon-o">-</span><span       |
|                                      | class="crayon-cn">1</span><span      |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-v">collapse</span><spa |
|                                      | n                                    |
|                                      | class="crayon-o">=</span><span       |
|                                      | class="crayon-s">""</span><span      |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-s">"1"</span><span     |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-10 |
|                                      | "                                    |
|                                      | class="crayon-line crayon-striped-li |
|                                      | ne">                                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-h">  </span><span      |
|                                      | class="crayon-sy">}</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-11 |
|                                      | "                                    |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      | <span class="crayon-h">  </span>     |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-12 |
|                                      | "                                    |
|                                      | class="crayon-line crayon-striped-li |
|                                      | ne">                                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-h">  </span><span      |
|                                      | class="crayon-i">x</span>            |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191532857097595-13 |
|                                      | "                                    |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      | <span class="crayon-sy">}</span>     |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | </div>                               |
+--------------------------------------+--------------------------------------+

</div>

</div>

All that's going on: the function is pulling in the summary table
(usually through a \$coef), trying to turn it into a dataframe (some
already are, though some tables are numeric (e.g. lm)), throwing a
warning if the last heading doesn't begin with "Pr" (as it may not be
the column that contains p-values), and editing any values that were
rounded to 0 (at the user specified rounding point) to be &lt; the
smallest number that could be rounded to (e.g. &lt;.01). Then we output
the edited table, all ready for reporting! To mimic what was above, we
set our digits to be equal to 6 (so go out 6 decimal places for the
p-value), and re-run:\

                 Estimate       Std.err        Wald           Pr(&gt;|W|)
  -------------- -------------- -------------- -------------- --------------
  (Intercept)    0.001704       0.000005       100409.770956  &lt; .000001
  sizemedium     0.000046       0.000005       90.534705      &lt; .000001
  sizesmall      0.000003       0.000005       0.294331       0.587458
  time           -0.000004      0.000001       11.614917      0.000654

 

Much better! Also, to report a two digit p-value (for some writing
styles), we simply set dig = 2:\

                 Estimate       Std.err        Wald           Pr(&gt;|W|)
  -------------- -------------- -------------- -------------- --------------
  (Intercept)    0.001704       0.000005       100409.770956  &lt; .01
  sizemedium     0.000046       0.000005       90.534705      &lt; .01
  sizesmall      0.000003       0.000005       0.294331       0.59
  time           -0.000004      0.000001       11.614917      &lt; .01

 

By design, the p-values can be manipulated independent of the estimates.
This allows reporting of the estimated coefficients in meaningful units
(in the above example, very small units), while reporting the p-values
on a scale that many writing styles request.

Want to try this yourself? Here's an example that you can try with just
a built in dataset in R:

<div id="crayon-572bc23191545014880955"
class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-mac print-yes notranslate"
data-settings=" minimize scroll-mouseover"
style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">

<div class="crayon-toolbar"
data-settings=" mouseover overlay hide delay"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title"></span>
<div class="crayon-tools"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<div class="crayon-button crayon-nums-button"
title="Toggle Line Numbers">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-plain-button"
title="Toggle Plain Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-wrap-button" title="Toggle Line Wrap">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-expand-button" title="Expand Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-copy-button" title="Copy">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-popup-button"
title="Open Code In New Window">

<div class="crayon-button-icon">

</div>

</div>

<span class="crayon-language">R</span>

</div>

</div>

<div class="crayon-info"
style="min-height: 16.8px !important; line-height: 16.8px !important;">

</div>

<div class="crayon-plain-wrap">

\#this gives a summary table with a small p-value. Trying to report this
with xtable would results in an R rounding issue! (mod &lt;-
coef(summary(lm(uptake \~ conc + Treatment + Type + Plant, data=CO2))))
\#this fixes the p-value to 2 digits, correctly reporting p-values that
would have been rounded to 0 fixp(mod,dig=2)

</div>

<div class="crayon-main" style="">

+--------------------------------------+--------------------------------------+
| <div class="crayon-nums-content"     | <div class="crayon-pre"              |
| style="font-size: 12px !important; l | style="font-size: 12px !important; l |
| ine-height: 15px !important;">       | ine-height: 15px !important; -moz-ta |
|                                      | b-size:4; -o-tab-size:4; -webkit-tab |
| <div class="crayon-num"              | -size:4; tab-size:4;">               |
| data-line="crayon-572bc2319154501488 |                                      |
| 0955-1">                             | <div                                 |
|                                      | id="crayon-572bc23191545014880955-1" |
| 1                                    | class="crayon-line">                 |
|                                      |                                      |
| </div>                               | <span class="crayon-c">\#this gives  |
|                                      | a summary table with a small         |
| <div                                 | p-value. Trying to report this with  |
| class="crayon-num crayon-striped-num | xtable would results in an R         |
| "                                    | rounding issue!</span>               |
| data-line="crayon-572bc2319154501488 |                                      |
| 0955-2">                             | </div>                               |
|                                      |                                      |
| 2                                    | <div                                 |
|                                      | id="crayon-572bc23191545014880955-2" |
| </div>                               | class="crayon-line crayon-striped-li |
|                                      | ne">                                 |
| <div class="crayon-num"              |                                      |
| data-line="crayon-572bc2319154501488 | <span                                |
| 0955-3">                             | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">mod</span><span     |
| 3                                    | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">&lt;</span><span    |
| </div>                               | class="crayon-o">-</span><span       |
|                                      | class="crayon-h"> </span><span       |
| <div                                 | class="crayon-e">coef</span><span    |
| class="crayon-num crayon-striped-num | class="crayon-sy">(</span><span      |
| "                                    | class="crayon-e">summary</span><span |
| data-line="crayon-572bc2319154501488 | class="crayon-sy">(</span><span      |
| 0955-4">                             | class="crayon-e">lm</span><span      |
|                                      | class="crayon-sy">(</span><span      |
| 4                                    | class="crayon-v">uptake</span><span  |
|                                      | class="crayon-h"> </span><span       |
| </div>                               | class="crayon-o">\~</span><span      |
|                                      | class="crayon-h"> </span><span       |
| <div class="crayon-num"              | class="crayon-v">conc</span><span    |
| data-line="crayon-572bc2319154501488 | class="crayon-h"> </span><span       |
| 0955-5">                             | class="crayon-o">+</span><span       |
|                                      | class="crayon-h"> </span><span       |
| 5                                    | class="crayon-v">Treatment</span><sp |
|                                      | an                                   |
| </div>                               | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">+</span><span       |
| </div>                               | class="crayon-h"> </span><span       |
|                                      | class="crayon-v">Type</span><span    |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-o">+</span><span       |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-v">Plant</span><span   |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-h"> </span><span       |
|                                      | class="crayon-v">data</span><span    |
|                                      | class="crayon-o">=</span><span       |
|                                      | class="crayon-v">CO2</span><span     |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">)</span><span      |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191545014880955-3" |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      |                                      |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191545014880955-4" |
|                                      | class="crayon-line crayon-striped-li |
|                                      | ne">                                 |
|                                      |                                      |
|                                      | <span class="crayon-c">\#this fixes  |
|                                      | the p-value to 2 digits, correctly   |
|                                      | reporting p-values that would have   |
|                                      | been rounded to 0</span>             |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | <div                                 |
|                                      | id="crayon-572bc23191545014880955-5" |
|                                      | class="crayon-line">                 |
|                                      |                                      |
|                                      | <span                                |
|                                      | class="crayon-e">fixp</span><span    |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-v">mod</span><span     |
|                                      | class="crayon-sy">,</span><span      |
|                                      | class="crayon-v">dig</span><span     |
|                                      | class="crayon-o">=</span><span       |
|                                      | class="crayon-cn">2</span><span      |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | </div>                               |
+--------------------------------------+--------------------------------------+

</div>

</div>

Here's the final output via print.xtable (dig=2 for fixp and xtable):\

  --------------------------------------------------------------------------
                 Estimate       Std. Error     t value        Pr(&gt;|t|)
  -------------- -------------- -------------- -------------- --------------
  (Intercept)    37.42          4.67           8.00           &lt; .01

  conc           0.02           0.00           7.96           &lt; .01

  Treatmentchill -12.50         5.10           -2.45          0.02
  ed                                                          

  TypeMississipp -23.33         6.01           -3.88          &lt; .01
  i                                                           

  Plant.L        21.58          11.14          1.94           0.06

  Plant.Q        -4.62          2.27           -2.03          0.05

  Plant.C        1.46           5.10           0.29           0.78

  Plant\^4       2.34           2.27           1.03           0.31

  Plant\^5       -0.48          5.77           -0.08          0.93

  Plant\^6       -0.04          2.27           -0.02          0.99

  Plant\^7       -1.91          3.64           -0.53          0.6

  Plant\^8       -3.28          2.27           -1.44          0.15

  Plant\^10      0.55           2.27           0.24           0.81
  --------------------------------------------------------------------------

 

Limitations (ish):

1.  Again, this assumes that the last column is the one to
    be transformed. This is by design, though may be inconvenient in
    some situations. If needed, the change is easily made through the
    definition of the function.
2.  When the last column is manipulated, it becomes a character column
    in the dataframe. Alternatively, when it is rounded but no
    entry rounds to 0, it is numeric.
3.  This assumes a dataframe-style format of your table. Thus, this
    method will NOT be effective at correcting reported p-values for an
    individual test: say a t-test, where only the statistic is reported
    (and not a table). Personally this is not a concern, as I deal with
    these situations in other ways, but for some users seeking an
    overall "p-value fixing" method this may not be the answer.

As with other functions I write posts on, this function is available in
my package (creatively named "myStuff")  via Github. If you'd like to
play with the most current version of the function, I'd encourage you to
check it out
[here](https://github.com/flor3652/myStuff/blob/master/R/fixp.R).
Alternatively, to have access to other fun functions, install the
package directly from GitHub with the code below (requires devtools):

<div id="crayon-572bc23191555760675420"
class="crayon-syntax crayon-theme-classic crayon-font-monaco crayon-os-mac print-yes notranslate"
data-settings=" minimize scroll-mouseover"
style=" margin-top: 12px; margin-bottom: 12px; font-size: 12px !important; line-height: 15px !important;">

<div class="crayon-toolbar"
data-settings=" mouseover overlay hide delay"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<span class="crayon-title">Installing myStuff Package</span>
<div class="crayon-tools"
style="font-size: 12px !important;height: 18px !important; line-height: 18px !important;">

<div class="crayon-button crayon-nums-button"
title="Toggle Line Numbers">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-plain-button"
title="Toggle Plain Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-wrap-button" title="Toggle Line Wrap">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-expand-button" title="Expand Code">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-copy-button" title="Copy">

<div class="crayon-button-icon">

</div>

</div>

<div class="crayon-button crayon-popup-button"
title="Open Code In New Window">

<div class="crayon-button-icon">

</div>

</div>

<span class="crayon-language">R</span>

</div>

</div>

<div class="crayon-info"
style="min-height: 16.8px !important; line-height: 16.8px !important;">

</div>

<div class="crayon-plain-wrap">

devtools::install\_github("flor3652/myStuff")

</div>

<div class="crayon-main" style="">

+--------------------------------------+--------------------------------------+
| <div class="crayon-nums-content"     | <div class="crayon-pre"              |
| style="font-size: 12px !important; l | style="font-size: 12px !important; l |
| ine-height: 15px !important;">       | ine-height: 15px !important; -moz-ta |
|                                      | b-size:4; -o-tab-size:4; -webkit-tab |
| <div class="crayon-num"              | -size:4; tab-size:4;">               |
| data-line="crayon-572bc2319155576067 |                                      |
| 5420-1">                             | <div                                 |
|                                      | id="crayon-572bc23191555760675420-1" |
| 1                                    | class="crayon-line">                 |
|                                      |                                      |
| </div>                               | <span                                |
|                                      | class="crayon-v">devtools</span><spa |
| </div>                               | n                                    |
|                                      | class="crayon-o">::</span><span      |
|                                      | class="crayon-e">install\_github</sp |
|                                      | an><span                             |
|                                      | class="crayon-sy">(</span><span      |
|                                      | class="crayon-s">"flor3652/myStuff"< |
|                                      | /span><span                          |
|                                      | class="crayon-sy">)</span>           |
|                                      |                                      |
|                                      | </div>                               |
|                                      |                                      |
|                                      | </div>                               |
+--------------------------------------+--------------------------------------+

</div>

</div>

</div>

</div>

<div class="entry-links">

[Leave a
Comment](http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/#respond)

Filed under [R](http://www.beardedanalytics.com/category/r/)

Tagged as [R](http://www.beardedanalytics.com/tag/r/),
[xtable](http://www.beardedanalytics.com/tag/xtable/)\

</div>

</div>

<div id="nav-below" class="navigation">

<div class="nav-previous">

[<span class="meta-nav">←</span> Quick Bar Graph in Sql
Server](http://www.beardedanalytics.com/quick-bar-graph-in-sql-server/)

</div>

<div class="nav-next">

</div>

</div>

<div id="comments">

<div id="respond" class="comment-respond">

### Leave a Reply <span id="cancel-comment-reply-link">[Cancel reply](/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/#respond)</span> {#reply-title .comment-reply-title}

You must be [logged
in](http://www.beardedanalytics.com/wp-login.php?redirect_to=http%3A%2F%2Fwww.beardedanalytics.com%2Fcorrectly-reporting-p-values-in-summary-tables-reported-with-xtable%2F)
to post a comment.

</div>

</div>

</div>

</div>

<div id="sidebar" class="widget-area" role="complementary">

-   <div id="search-2">

    </div>

    <div>

    Search for:

    </div>

-   <div id="recent-posts-2">

    </div>

    ### Recent Posts {.widget-title}

    -   [Correctly Reporting P-Values in Summary Tables Reported with
        xtable](http://www.beardedanalytics.com/correctly-reporting-p-values-in-summary-tables-reported-with-xtable/)
    -   [Quick Bar Graph in Sql
        Server](http://www.beardedanalytics.com/quick-bar-graph-in-sql-server/)
    -   [Vectorize a
        Function](http://www.beardedanalytics.com/vectorize-a-function/)
    -   [Tips For Dealing with Large Datasets in Sql
        Server](http://www.beardedanalytics.com/tips-for-dealing-with-large-datasets-in-sql-server/)
    -   [The Keep
        Function](http://www.beardedanalytics.com/the-keep-function/)
-   <div id="category_rss_widgets">

    </div>

    ### Category Specific RSS {.widget-title}

    <div class="cat_specific_rss">

    -   [Assumption
        Checking](http://www.beardedanalytics.com/category/assumption-checking/feed/) (1)
    -   [CSP2015](http://www.beardedanalytics.com/category/csp2015/feed/) (1)
    -   [email](http://www.beardedanalytics.com/category/email/feed/) (1)
    -   [Functional
        Programming](http://www.beardedanalytics.com/category/functional-programming/feed/) (2)
    -   [Productivity](http://www.beardedanalytics.com/category/productivity/feed/) (1)
    -   [R](http://www.beardedanalytics.com/category/r/feed/) (10)
    -   [R\_local](http://www.beardedanalytics.com/category/r_local/feed/) (1)
    -   [Sql
        Server](http://www.beardedanalytics.com/category/sql-server/feed/) (7)
    -   [Statistics](http://www.beardedanalytics.com/category/statistics/feed/) (1)
    -   [Uncategorized](http://www.beardedanalytics.com/category/uncategorized/feed/) (2)

    </div>

-   <div id="archives-2">

    </div>

    ### Archives {.widget-title}

    -   [March 2016](http://www.beardedanalytics.com/2016/03/)
    -   [August 2015](http://www.beardedanalytics.com/2015/08/)
    -   [March 2015](http://www.beardedanalytics.com/2015/03/)
    -   [February 2015](http://www.beardedanalytics.com/2015/02/)
    -   [January 2015](http://www.beardedanalytics.com/2015/01/)
    -   [November 2014](http://www.beardedanalytics.com/2014/11/)
    -   [October 2014](http://www.beardedanalytics.com/2014/10/)
    -   [September 2014](http://www.beardedanalytics.com/2014/09/)
    -   [August 2014](http://www.beardedanalytics.com/2014/08/)
    -   [July 2014](http://www.beardedanalytics.com/2014/07/)
    -   [June 2014](http://www.beardedanalytics.com/2014/06/)
-   <div id="categories-2">

    </div>

    ### Categories {.widget-title}

    -   [Assumption
        Checking](http://www.beardedanalytics.com/category/assumption-checking/)
    -   [CSP2015](http://www.beardedanalytics.com/category/csp2015/)
    -   [email](http://www.beardedanalytics.com/category/email/)
    -   [Functional
        Programming](http://www.beardedanalytics.com/category/functional-programming/)
    -   [Productivity](http://www.beardedanalytics.com/category/productivity/)
    -   [R](http://www.beardedanalytics.com/category/r/)
    -   [R\_local](http://www.beardedanalytics.com/category/r_local/)
    -   [Sql
        Server](http://www.beardedanalytics.com/category/sql-server/)
    -   [Statistics](http://www.beardedanalytics.com/category/statistics/)
    -   [Uncategorized](http://www.beardedanalytics.com/category/uncategorized/)
-   <div id="text-2">

    </div>

    ### Links {.widget-title}

    <div class="textwidget">

    -   [Foundation for Open Access
        Statistics (FOAS)](http://www.foastat.org/)
    -   [R-Bloggers](http://www.r-bloggers.com)
    -   [American Statistical Association (ASA)](http://www.amstat.org/)
    -   [Simply Statistics](http://simplystatistics.org/)
    -   [Statistical Modeling, Causal Inference, and Social
        Science](http://andrewgelman.com/)

    </div>

-   <div id="text-4">

    </div>

    ### Posts by Author {.widget-title}

    <div class="textwidget">

    [Todd's Posts](http://www.beardedanalytics.com/author/spoted21/)\
     [Jeremy's
    Posts](http://www.beardedanalytics.com/author/jeremy-jackson/)\
     [Michaels's Posts](http://www.beardedanalytics.com/author/mfloren/)

    </div>

</div>

</div>

<div id="footer" role="contentinfo">

<div id="colophon">

<div id="site-info">

[Bearded
Analytics](http://www.beardedanalytics.com/ "Bearded Analytics") · For
when the analytics gets hairy

</div>

<div id="site-generator">

[Proudly powered by
WordPress](http://wordpress.org/ "A Semantic Personal Publishing Platform")
· Theme: Pilcrow by [Automattic](http://automattic.com/).

</div>

</div>

</div>

</div>

</div>
