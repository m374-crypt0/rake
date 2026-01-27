#!/bin/env bash

"${RAKE_ROOT_DIR}".rake/test/bats/bin/bats -pr "${RAKE_ROOT_DIR}".rake/test/suites/Makefile/*.bats \
  "${RAKE_ROOT_DIR}".rake/test/suites/scripts/*.bats \
  "${RAKE_ROOT_DIR}".rake/test/suites/subs/*.bats
