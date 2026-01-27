#!/bin/env bash

# shellcheck source=error_codes.sh
. "${RAKE_ROOT_DIR}scripts/error_codes.sh"

error() {
  echo "$@" >&2
}

add_target_to_compound_target_chain() {
  local target &&
    target="$1"

  if [ "$target" != sub ]; then
    error There is no sub

    return $RAKE_NO_SUB
  fi

  return 0
}

execute_compound_target_if_ready() {
  :
}

main() {
  add_target_to_compound_target_chain "$1" &&
    execute_compound_target_if_ready
}

main "$@"
