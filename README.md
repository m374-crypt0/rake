# rake - Because Your Mono-repo Deserves Better

Welcome to the `rake` world, where complexity meets simplicity and sanity is
restored to your multi-project universe.

## What is rake?

Think of `rake` as **a single make to rule them all** – it's the beautifully
simple solution that lets you stop wrestling with build orchestration and get
back to what actually matters: your code.

At its heart, `rake` is just a clever `Makefile` that knows how to talk to
other `Makefiles`. That's it. No fancy frameworks, no mysterious magic, no PhD
required. Just good old battle-tested `make` and `bash` doing what they've done
reliably for decades.

## Why You'll Get Raked With Joy

**Perfect for the modern mono-repo reality:** Got a repo mixing Python
microservices, React frontends, Go APIs, and maybe some Rust sprinkled in?
`rake` doesn't care. Each sub-project lives in its own directory with its own
`Makefile`, and `rake` orchestrates them like a conductor with a very chill
attitude.

**Zero mental overhead:** `rake` is designed to be invisible infrastructure. It's
the boring, reliable tool that Just Works™ so you can focus on your actually
interesting problems. No new concepts to learn, no configuration files to
maintain, no surprise behaviors.

**Compound targets made easy:** Want to test everything in your backend
project? `make backend test`. Want to build just the frontend? `make frontend
build`. Want to deploy the whole shebang? `make frontend deploy && make backend
deploy`. `rake` gives you the power to compose complex operations from simple,
predictable building blocks.

**Battle-tested foundation:** Built on `make` and `bash` – tools that have been
solving build problems since before most of us were born. If it works on one
Unix-like system, it works everywhere. No runtime dependencies, no version
conflicts, no surprises.

## The rake Philosophy

`rake` believes that build orchestration should be **simple, predictable, and
boring**. It's not trying to reinvent the wheel or be the next big thing in
DevOps. It's just trying to make your life a little easier when you're juggling
multiple projects that need to work together.

In a world of over-engineered build systems and complex CI/CD pipelines, `rake`
is the refreshingly simple alternative that lets you get back to building cool
stuff instead of fighting with your tooling.

Ready to enter the `rake` world? Your future self will thank you for choosing
simplicity.

## Rough unserious and simple roadmap

- [x] provides a `help` target that is the default one
- [ ] getting started section in README to show how the f*ck things are simple
      and under user's control
- [x] can list all existing `sub`s
  - [ ] only if rake has been initialized in another user specified directory
    - [ ] otherwise tell the user what to do
    - [ ] enrich README and help system in that sense
- separate contribution from usage (see below)
- [ ] can initialize `rake` in a user specified directory
  - [ ] directory must not exist or be empty
  - [ ] initialize a git repository or does not, depends on the user
  - [ ] unlocks `compound targets` execution once initialized.
