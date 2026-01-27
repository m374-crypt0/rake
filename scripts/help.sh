#!/bin/env bash

main() {
  cat <<EOF
rake: redone with make - the utility your mono-repo deserves

  Here is the power of rake, you can specify a list of targets separated by
  spaces and execute them seamlessly.

usage:
  make <COMPOUND TARGETS> where <COMPOUND TARGETS> is a list of valid make
  targets built as following:

    make <SUB> <TARGET1> <TARGET2> ... <TARGETN> where <SUB> is a sub-directory
    located in the special 'subs' directory of rake. A valid <SUB> must contain
    a valid Makefile having the targets you have specified in
    <COMPOUND TARGETS>

examples:
  Let's say you have a 'backend' and a 'frontend' sub in subs:

    make backend build test deploy

  It will:
  - build the backend
  - if successful test it
  - if successful deploy it

  Then you could:

    make frontend lint transpile deploy

  It will:
  - lint the frontend
  - if successful transpile it
  - if successful deploy it

  Everything at the root of rake, simple, obvious, idiot and boring.

contribution:

  Aditionally, you can provide <SIMPLE TARGETS> to this make project.
  These targets are specific to rake and aim at either:
    - providing some help:
      - make
      - make help
    - contribution purposes:
      - run_rake_tests: run all test suites
      - watch_rake_tests: continuously run all test suites
      - init_submodules: init required git submodules
EOF
}

main
