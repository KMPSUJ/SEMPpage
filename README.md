# Webpage for KMPSUJ

## How to view this page
First install Julia from [here](https://julialang.org/)

Then after cloning this repo, start an interactive `julia` session from this directory.
From the REPL execute those commands:
```julia
pkg> activate .
pkg> instantiate

julia> using Franklin
julia> serve()

```

If you pulled new changes consider running `rm -r __site` before running `serve()` in julia.
This will force julia to rebiuld the whole site.
