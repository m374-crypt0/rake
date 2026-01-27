#!/bin/env bash

function run_test() {
  # shellcheck source=/dev/null
  . "${RAKE_ROOT_DIR}.rake/test/test.sh"
}

run_test

# TODO: replace with an infinite loop using inotifywatch to avoid multiple
# executions
inotifywait -mqr \
  --event modify \
  "${RAKE_ROOT_DIR}" \
  --exclude "\.git" |
  while read -r; do
    clear && run_test
  done
