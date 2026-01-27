#!/bin/env bash

main() {
  cat <<EOF
rake: redone make

usage:

make <TARGET> where <TARGET> belongs to:

- help: print this message
- run_rake_tests: run all test suites
- watch_rake_tests: continuously run all test suites (for dev purposes)
EOF
}

main
