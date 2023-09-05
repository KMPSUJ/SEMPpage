# Webpage for KMPSUJ

## How to view this page
First install Julia from the official website [julialang.org](https://julialang.org/).

Then after cloning this repo, start an interactive `julia` session from this directory.
From the REPL execute those commands:
```julia
import Pkg
Pkg.activate(".")
Pkg.instantiate()

using Franklin
serve()
```

If you pulled new changes consider running `rm -r __site` before running `serve()` in Julia.

## How to edit?
First view the page as explained above.
Than just modify any part of the source code.
The changes will be shown as you save edited files.

For more examples and documentation see Franklin.jl webpage [franklinjl.org](https://franklinjl.org)

