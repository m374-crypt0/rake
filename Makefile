MAKEFLAGS += --no-print-directory

RAKE_ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

SHELL := /bin/bash

export

.PHONY: help
help:
	@. ${RAKE_ROOT_DIR}/scripts/help.sh

run_rake_tests:
	@. ${RAKE_ROOT_DIR}/test/test.sh

watch_rake_tests:
	@. ${RAKE_ROOT_DIR}/test/watch.sh
