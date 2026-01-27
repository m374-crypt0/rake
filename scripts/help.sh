#!/bin/env bash

main() {
  cat <<EOF
rake: redone with make

usage:

make <SIMPLE TARGET> where <SIMPLE TARGET> belongs to:

- init_submodules: init required git submodules (testing and dependencies)
- help: print this message
- run_rake_tests: run all test suites
- watch_rake_tests: continuously run all test suites (for dev purposes)

Aditionally, you can provide <COMPOUND TARGETS> to this make project, that is,
several words targets such as:

- sub list: list existing subs
EOF
}

main
