<!--This file was generated, do not modify it.-->
# Tutorial 3: Franklin
\toc
According to its [website](https://franklinjl.org/), "Franklin is a simple, customisable static site generator oriented towards technical blogging and light, fast-loading pages."

Here are some features of the package:

- LaTeX maths expressions rendered via KaTeX, code via highlight.js both can be pre-rendered
- Can live-evaluate Julia code blocks
- Live preview of modifications

## Installation

To install Pluto [2], type ] to enter package manager Pkg in Julia:

```julia-repl
julia> ]
```

Enter `add Franklin` to add the package:

```julia-repl
(@v1.9) pkg> add Franklin
```

To exit package manager, press Ctrl+C or Backspace

```julia-repl
(@v1.9) pkg> ^C
```

## Quick start

We may create your website (say, for example, titled \"TestWebsite\") from the existing template. It will create a folder with the name \"TestWebsite\" under the current folder [^1].

```julia-repl
julia> using Franklin
julia> newsite("TestWebsite"; template="vela")
```

Have a look at [here](https://github.com/tlienart/FranklinTemplates.jl#fixingadding-a-template) to learn more about the available templates.

To have a live preview of the site we can call the following function:

```julia-repl
julia> cd("TestWebsite")
julia> serve()
```

The functionality re-renders the site whenever changes are made.

### Create your first page

If you create a page `[path]/page.md`, it will create a page in `__site/[path]/page.md`, which could be access at `[website]/page/` after deployment. For example, you can create a page `blog.md`:

```yml
+++
title = "Blog"
date = Date(2023, 6, 7)
tags = ["blog"]
+++
# Blog
- [Julia Learning](julia-learning/) - personal note for Julia.
```

You will see an HTML file at `__site/blog/index.html`, which can be accessed at http://s92077.github.io/blog/.

## A closer look into Franklin

After generating the site, you will see the folowing folder structure:

```plaintext
├── __site/: the path for the rendered site
├── _assets/: the path for the files/images/videos/etc for the site
├── _css/: the path of css files
├── _layout/: the path of html components of the site
├── _libs/: the path of javascript codes, including katex.js and highlight.js
├── _rss/: the path of rss
├── 404.md: the 404 page
├── config.md: the configuration file for the site
├── index.md
└── utils.jl
```

### config.md

To make your site rendered properly, you need to properly set the variable `website_url` to the url of your github page (You need to replace `AccountName` by your actual GitHub account):

```bash
website_url = "https://AccountName.github.io/"
```

### LaTeX

In your created markdown page, you can use \$...\$ to type math in LaTeX.

### HTML

In your created markdown page, you can use ~~~...~~~ to enclose HTML code.

### CSS

Cascading Style Sheets (CSS) is a style sheet language used for describing the presentation of a document written in a markup language such as HTML or XML. In a nutshell, it allows you to tweak how your website look. For more information, have a look at [here](https://franklinjl.org/styling/templates/#adapting_the_stylesheet).

### Function

You can define your own functions and call them from your markdown pages. To learn more about it, check out [here](https://franklinjl.org/syntax/utils/index.html).

## Deploy your website to github pages

### Create you GitHub account

Create a new account at [https://github.com](https://github.com) if you do not have one. Note that your account name will be used in the url of your github page (in this case, your website).

### Install GitHub CLI

Go to [https://cli.github.com](https://cli.github.com) to download the latest GitHub command-line interface (GitHub CLI) and install it.

> * For __*Windows*__ users, it is recommanded download `git` from [here](https://git-scm.com/download/win).
> * For __*Mac*__ users, you may follow [this guide](https://git-scm.com/download/mac) to install `git`.
> * For __*Linux*__ users, you may follow [this guide](https://git-scm.com/download/linux) to install `git`.

### Create repositories

Suppose your account name is `AccountName`. In this tutorial, we will need two repositories.

> - `blog`: a private repository for your pre-rendered files
> - `AccountName.github.io`: a public repository for your github page

Since we need to set up the automatic deployment later, at this point we should follow [this guide](https://github.com/marketplace/actions/github-pages-action#%EF%B8%8F-create-ssh-deploy-key) to set public key for `AccountName.github.io` and private key for `blog`. If you don't have ssh-keygen installed, you may use online RSA key generator (e.g. [here](https://cryptotools.net/rsagen)) to generate 4096-bit public and private keys.

After creating the website, we clone the former repository to local.

```bash
git clone https://github.com/AccountName/blog.git
```

We may now copy all files from the folder `TestWebsite` of the generated site to the local git repository folder `blog`.

### Add git action files

We need to create a file the automatically deploy the website for us. To this end, create, under folder `blog`, a file at `.github/workflow/deploy.yml` (You need to replace `AccountName` by you actual name of account, and replace `publish_branch` by your actual branch):

```yml
name: Build and Deploy
on:
  push:
    branches:
      - Franklin
jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
    - name: Checkout
      uses: actions/checkout@v3
      with:
        persist-credentials: false
    # NOTE: Python is necessary for the pre-rendering (minification) step
    - name: Install python
      uses: actions/setup-python@v2
      with:
        python-version: '3.8'
    # NOTE: Here you can install dependencies such as matplotlib if you use
    # packages such as PyPlot.
    # - run: pip install matplotlib
    - name: Install Julia
      uses: julia-actions/setup-julia@v1
      with:
        version: '1' # Latest stable Julia release.
    - name: Cache Julia
      uses: julia-actions/cache@v1
      with:
        cache-registries: "true"
    # NOTE
    #   The steps below ensure that NodeJS and Franklin are loaded then it
    #   installs highlight.js which is needed for the prerendering step
    #   (code highlighting + katex prerendering).
    #   Then the environment is activated and instantiated to install all
    #   Julia packages which may be required to successfully build your site.
    #   The last line should be `optimize()` though you may want to give it
    #   specific arguments, see the documentation or ?optimize in the REPL.
    - run: julia -e '
            using Pkg; Pkg.activate("."); Pkg.instantiate();
            using NodeJS; run(`$(npm_cmd()) install highlight.js`);
            using Franklin;
            optimize()'
    - name: Build and Deploy
      uses: peaceiris/actions-gh-pages@v3
      with:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        deploy_key: ${{ secrets.ACTIONS_DEPLOY_KEY }}
        external_repository: AccountName/AccountName.github.io
        publish_branch: master
        publish_dir: ./__site
```

### Deploy the site

We now can push our website. To this end, we need to confirm our changes to the folder `blog`.

```bash
git add .
git commit -m "first commit "
```

After that, you can push the repository to the remote.

```bash
git push
```

## Final notes

[^1]: You may use the command `pwd()` to print your working directory, and use `cd(path)` to change your working directory to `path`.

