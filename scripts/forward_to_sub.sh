#!/bin/env bash

main() {
  local target &&
    target="$1"

  echo "$target" >"${RAKE_ROOT_DIR}"runs/.registered_sub
}

main "$1"
