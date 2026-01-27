#!/bin/env bash

"${RAKE_ROOT_DIR}"test/bats/bin/bats -pr "${RAKE_ROOT_DIR}"test/suites/Makefile/*.bats \
  "${RAKE_ROOT_DIR}"test/suites/scripts/*.bats \
  "${RAKE_ROOT_DIR}"test/suites/subs/*.bats
