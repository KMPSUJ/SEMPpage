<!--
Add here global page variables to use throughout your website.
-->
+++
using Dates
author = "KMPS UJ"
mintoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/", "_assets/original/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "KMPS UJ"
website_descr = "Strona główna KMPS UJ"
website_url   = "smp.if.uj.edu.pl" 
fd_mtime = Dates.format(today(), "yyyy-mm-dd")
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

\newcommand{\figwidth}[2]{
~~~
<img src="#1" style="width: #2;" />
~~~
}


\newcommand{\figcaption}[3]{
@@fig
~~~
<img src="#1" />
~~~
#2

autor: #3
@@
}

