using Dates

function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function month2plstring(mnum)
    plmonths = Dict(1 => "Styczeń", 2 => "Luty", 3 => "Marzec", 4 => "Kwiecień",
        5 => "Maj", 6 => "Czerwiec", 7 => "Lipiec", 8 => "Sierpień",
        9 => "Wrzesień", 10 => "Październik", 11 => "Listopad", 12 => "Grudzień")
    return plmonths[mnum]
end

# based on www.julialang.org blog section
# https://github.com/JuliaLang/www.julialang.org/blob/main/utils.jl
# but see also:
# https://github.com/tlienart/Franklin.jl/issues/331
# https://github.com/tlienart/Franklin.jl/issues/391#issuecomment-612810743
#
# In case of pagevar errors: https://github.com/tlienart/Franklin.jl/issues/995
# which tells to pin Franklin at version 0.10.58
"""
    {{newslist}}

Plug in the list of blog posts contained in the `/aktualnosci/` folder.
"""
function hfun_newslist()
    curyear = year(Dates.today())
    io = IOBuffer()
    for postyear in curyear:-1:2023
        ys = "$postyear"
        postyear < curyear && write(io, "\n## $ys\n")

        for m in 12:-1:1
            ms = lpad(m, 2, '0')
            base = joinpath("aktualnosci", ys, ms)
            isdir(base) || continue
            posts = filter!(p -> endswith(p, ".md"), readdir(base))
            days  = zeros(Int, length(posts))
            lines = Vector{String}(undef, length(posts))

            if length(posts) > 0 && m < month(Dates.today())
                write(io, "\n### $(month2plstring(m))\n")
            end

            # Manage post
            for (i, post) in enumerate(posts)
                ps  = splitext(post)[1]
                url = "/aktualnosci/$ys/$ms/$ps/"
                surl = strip(url, '/')
                title = pagevar(surl, :title)
                title === nothing && (title = "Nie ma tytułu :o ???")
                pubdate = pagevar(surl, :published)
                if isnothing(pubdate)
                    date    = "$ys-$ms-01"
                    days[i] = 1
                else
                    date    = Date(pubdate, dateformat"d U Y")
                    days[i] = day(date)
                end
                lines[i] = "\n* [$title]($url) \\\\ ~~~<small>dodano: $date</small>~~~ \n"
            end

            # sort by day
            foreach(line -> write(io, line), lines[sortperm(days, rev=true)])
        end
    end
    # markdown conversion adds `<p>` beginning and end but
    # we want to  avoid this to avoid an empty separator
    r = Franklin.fd2html(String(take!(io)), internal=true)
    return r
end

