# rake - aka redone-make

## Glossary

- `main Makefile` the entry point. The user is intended to use this `Makefile` only.
- `root directory` the directory where the main `Makefile` is located.

## What is it?

- A single root `Makefile` that is able to delegate tasks to sub Makefiles
- features
  - [ ] automatically enumerate target mirroring directory structure of the
        root directory
    - [ ] if there is not any `sub directory` containing a Makefile, clearly
          indicates there are not any target to execute
  - [x] provides a `help` target that is the default one
  - [ ] the first target specified for the `main Makefile` targets the `sub
        directory`, subsequent targets are rules to be executed by the `sub
        Makefile` within this directory
