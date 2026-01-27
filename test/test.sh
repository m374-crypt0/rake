#!/bin/env bash

"${RAKE_ROOT_DIR}"test/bats/bin/bats -pr "${RAKE_ROOT_DIR}"test/suites/main_makefile/*.bats \
  "${RAKE_ROOT_DIR}"test/suites/unit/*.bats
