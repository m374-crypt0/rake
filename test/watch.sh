#!/bin/env bash

FUNCSHIONAL_ROOT_DIR="${RAKE_ROOT_DIR}scripts/lib/funcshional/"

# shellcheck source=/dev/null
. "${FUNCSHIONAL_ROOT_DIR}src/funcshional.sh"

function run_test() {
  # shellcheck source=/dev/null
  . "${RAKE_ROOT_DIR}"test/test.sh
}

run_test

inotifywait -mqr \
  --event modify \
  "${RAKE_ROOT_DIR}test" \
  "${RAKE_ROOT_DIR}scripts" |
  while read -r; do
    clear && run_test
  done
