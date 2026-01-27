MAKEFLAGS += --no-print-directory

RAKE_ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

SHELL := /bin/bash

export

# simple targets

.PHONY: help
help:
	@. ${RAKE_ROOT_DIR}/scripts/help.sh

.PHONY: run_rake_tests
run_rake_tests:
	@. ${RAKE_ROOT_DIR}/test/test.sh

.PHONY: watch_rake_tests
watch_rake_tests:
	@. ${RAKE_ROOT_DIR}/test/watch.sh

# compound targets

.PHONY: sub
sub:
	@:

.PHONY: list
list:
	@:
