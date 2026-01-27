#!/bin/env bash

# shellcheck source=error_codes.sh
. "${RAKE_ROOT_DIR}scripts/error_codes.sh"

add_target_to_compound_target_chain() {
  local target &&
    target="$1"

  if [ "$target" != sub ]; then
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
