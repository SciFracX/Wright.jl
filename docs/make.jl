using Documenter, Wright

makedocs(
    modules = [Wright],
    sitename = "Wright.jl",
    format = Documenter.HTML(
        assets = ["assets/favicon.ico"],
    ),

    pages = [
        "index.md",
    ]
)

deploydocs(
    repo = "github.com/SciFracX/Wright.jl.git";
)