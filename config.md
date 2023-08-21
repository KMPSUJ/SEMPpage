<!--
Add here global page variables to use throughout your website.
-->
@def isnewspage = false
+++
using Dates
author = "KMPS UJ"
mintoclevel = 2

# make place to store tmp index files
isdir("_layout/tmp") || mkdir("_layout/tmp")



# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/", "_assets/original/", "_layout/tmp/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "KMPS UJ"
website_descr = "Strona główna KMPS UJ"
website_url   = "smp.if.uj.edu.pl" 
fd_mtime = Dates.format(today(), "yyyy-mm-dd")

function get_news_title(f)
    title = "TBA"
    for l in readlines(f)
        if startswith(l, """@def title""")
            title = split(l, "\"")[2]
            break
        end
    end
    return string(title)
end

function get_news_time(f)
    return stat(f).mtime
end

function aktualnosci_toc()
    dir = "aktualnosci/"
    all = [(i, get_news_time(dir * i)) for i in readdir(dir)]
    filter!(x -> x[1] != "index.md" && x[1] != "all.md", all)
    sort!(all, by = x -> x[2], rev = true)

    open("_layout/tmp/aktualnosci_full_toc.html", "w") do f
        write(f, """<nav class="news-toc">\n""")
        for i in all
            fpath = dir * split(i[1], ".")[1]
            nicename = get_news_title(dir * i[1]) * (Dates.format(Dates.unix2datetime(i[2]), " (yyyy-mm-dd)"))
            write(f, """<a class="news-toc-item" href="/$(fpath)">$(nicename)</a>\n""")
        end
        write(f, """</nav>\n""")
    end

    #=
    open("_layout/tmp/aktualnosci_side_bar.html", "w") do f
        for i in 1:min(length(all), 3)
            nf = all[i]
            fpath = dir * split(nf[1], ".")[1]
            nicename = split(nf[1], ".")[1] * (Dates.format(Dates.unix2datetime(nf[2]), " (yyyy-mm-dd)"))
            write(f, """<a class="sidebar-nav-item" href="/$(fpath)">$(nicename)</a>\n""")
        end
    end
    =#

    open("_layout/tmp/aktualnosci_recent.html", "w") do f
        write(f, """<nav class="news-toc">\n""")
        for i in 1:min(length(all), 20)
            nf = all[i]
            fpath = dir * split(nf[1], ".")[1]
            nicename = get_news_title(dir * nf[1]) * (Dates.format(Dates.unix2datetime(nf[2]), " (yyyy-mm-dd)"))
            write(f, """<a class="news-toc-item" href="/$(fpath)">$(nicename)</a>\n""")
        end
        write(f, """</nav>\n""")
    end
    
end

aktualnosci_toc()
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
