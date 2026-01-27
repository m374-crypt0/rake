#!/bin/env bash

main() {
  local target &&
    target="$1"

  [ "$target" = sub ] &&
    touch "${RAKE_ROOT_DIR}runs/.last_sub"
}

main "$@"
