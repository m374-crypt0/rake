# TODO: specific option settings
MAKEFLAGS += --no-print-directory

# TODO: specific rake variable settiings
SHELL := /bin/bash
RAKE_ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# TODO: specific dependency setup
FUNCSHIONAL_ROOT_DIR := ${RAKE_ROOT_DIR}scripts/lib/funcshional/

export
.PHONY: help

# simple targets
# TODO: first, present compound targets then simple targets that are more for
# internal purposes
help: init_submodules
	@. ${RAKE_ROOT_DIR}/scripts/help.sh

.PHONY: init_submodules
init_submodules:
	@git submodule update --init --recursive >/dev/null 2>&1

.PHONY: run_rake_tests
run_rake_tests: init_submodules
	@. ${RAKE_ROOT_DIR}/test/test.sh

.PHONY: watch_rake_tests
watch_rake_tests: init_submodules
	@. ${RAKE_ROOT_DIR}/test/watch.sh

# compound targets are forwarded to a potential sub
# NOTE: putting a dependency for this target breaks all the thing
.PHONY: %
%:
	@. ${RAKE_ROOT_DIR}/scripts/forward_to_sub.sh $@
