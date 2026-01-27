#!/bin/env bash

FUNCSHIONAL_ROOT_DIR="${RAKE_ROOT_DIR}scripts/lib/funcshional/"

# shellcheck source=/dev/null
. "${FUNCSHIONAL_ROOT_DIR}src/funcshional.sh"

function run_test() {
  # shellcheck source=/dev/null
  . "${RAKE_ROOT_DIR}"test/test.sh
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
