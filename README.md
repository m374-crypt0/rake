# rake - aka redone with make

## Glossary

- `main Makefile` the entry point. The user is intended to use this `Makefile` only.
- `root directory` the directory where the `main Makefile` is located.
- `sub` a sub-project located in a sub-directory within the `subs directory`
- `subs directory` a special directory within the `root directory` that is not
  tracked by git as it contains all existing `sub`s

## What is it?

- A single root `main Makefile` that is able to delegate tasks to sub Makefiles
- features
  - [x] provides a `help` target that is the default one
  - [ ] can list all existing `sub`s
