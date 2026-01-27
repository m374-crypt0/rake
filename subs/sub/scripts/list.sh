#!/bin/env bash

# shellcheck source=../../../scripts/error_codes.sh
. "${RAKE_ROOT_DIR}scripts/error_codes.sh"

main() {
  echo There is no sub >&2

  return $RAKE_NO_SUB
}

main
