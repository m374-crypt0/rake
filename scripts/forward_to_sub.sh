#!/bin/env bash

main() {
  touch "${RAKE_ROOT_DIR}"runs/.registered_sub
}

main "$@"
