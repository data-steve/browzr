remove  these

[^'class="']
[^'style="
[^'<span']
[^'title=']
[^'data-settings="']
data-settings="
['">'$]
" "

consider trimming anything before  "","[.*?]","=================","" 

and after "<span id=\"commentform\"></span>" 


how to clean this up
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


<div class="crayon-plain-wrap">



[218] "+--------------------------------------+--------------------------------------+"                                                                                                                               
[219] "|     1                                | ``` {.rsplus style=\"font-family:mono |"                                                                                                                              
[220] "|                                      | space;\"}                             |"                                                                                                                              
[221] "|                                      | shiny::runGitHub(\"multilingualShinyA |"                                                                                                                              
[222] "|                                      | pp\",\"chrislad\")                      |"                                                                                                                            
[223] "|                                      | ```                                  |"                                                                                                                               
[224] "+--------------------------------------+--------------------------------------+"