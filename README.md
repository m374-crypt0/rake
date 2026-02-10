# rake - Because Your Mono-repo Deserves Better

> Welcome to the *rake* world, where complexity meets simplicity and sanity is
> restored to your multi-project universe.

<!--toc:start-->
- [rake - Because Your Mono-repo Deserves Better](#rake-because-your-mono-repo-deserves-better)
  - [What is rake?](#what-is-rake)
  - [Getting started](#getting-started)
  - [Why You'll Get Raked With Joy](#why-youll-get-raked-with-joy)
  - [The rake Philosophy](#the-rake-philosophy)
<!--toc:end-->

## What is rake?

Think of *rake* as **a single make to rule them all** – it's the beautifully
simple solution that lets you stop wrestling with build orchestration and get
back to what actually matters: your code.

At its heart, *rake* is just a clever *Makefile* that knows how to talk to
other *Makefiles*. That's it. No fancy frameworks, no mysterious magic, no PhD
required. Just good old battle-tested *make*, *git* and *bash* doing what
they've done reliably for decades.

## Getting started

For a first installation:

```bash
curl -L https://raw.githubusercontent.com/m374-crypt0/rake/refs/heads/main/.rake/scripts/install | bash
```

It will install *rake* and *rakeup* in your user directory and you'll be able
to *rake* everything:

- `rakeup` to update your *rake* installation
- `rake --help` to get some hints
- `mkdir my-fancy-monorepo`
- `cd my-fancy-monorepo`
- `rake new`

It'll create a brand new git repository.
All you need is to create some stuff (your project folders) in this directory.
Let's call those projects *subs*.
Each *sub* is a part of your project (frontend, backend, git submodule,
whatever...).

==The must is that you have to have a Makefile== in the `sub` you create.

## Why You'll Get Raked With Joy

**Perfect for the modern mono-repo reality:** Got a repo mixing Python
microservices, React frontends, Go APIs, and maybe some Rust sprinkled in?
*rake* doesn't care. Each sub-project lives in its own directory with its own
*Makefile*, and *rake* orchestrates them like a conductor with a very chill
attitude.

**Zero mental overhead:** *rake* is designed to be invisible infrastructure. It's
the boring, reliable tool that Just Works™ so you can focus on your actually
interesting problems. No new concepts to learn, no configuration files to
maintain, no surprise behaviors.

**Compound targets made easy:** Want to test everything in your backend
project? `make backend test`. Want to build just the frontend? `make frontend
build`. Want to deploy the whole shebang? `make frontend deploy && make backend
deploy`. *rake* gives you the power to compose complex operations from simple,
predictable building blocks.
Icing on the cake, due to how *rake* is built, you can perfectly rely on
autocomplete features of your shell to make *rake* even easier to use: your
*subs* are directories.

**Battle-tested foundation:** Built on *git*, *make* and *bash* – tools that
have been solving build problems since before most of us were born. If it works
on one Unix-like system, it works everywhere. No runtime dependencies, no
version conflicts, no surprises.

## The rake Philosophy

*rake* believes that build orchestration should be **simple, predictable, and
boring**. It's not trying to reinvent the wheel or be the next big thing in
DevOps. It's just trying to make your life a little easier when you're juggling
multiple projects that need to work together.

In a world of over-engineered build systems and complex CI/CD pipelines, *rake*
is the refreshingly simple alternative that lets you get back to building cool
stuff instead of fighting with your tooling.

> Ready to enter the *rake* world? Your future self will thank you for choosing
> simplicity.
