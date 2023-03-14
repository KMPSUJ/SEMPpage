# Webpage for KMPSUJ

## How to view this page
First install Julia from [here](https://julialang.org/)

Then after cloning this repo, start an interactive `julia` sestion from this directory.
From the REPL execute those commands:
```julia
] activate .
] instantiate

using Franklin
serve()
```

If you pulled new changes consider running `rm -r __site` running `serve()` in julia.
