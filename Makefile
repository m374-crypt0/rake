# TODO: specific option settings
MAKEFLAGS += --no-print-directory

# TODO: specific rake variable settiings
SHELL := /bin/bash
RAKE_ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# TODO: specific dependency setup
FUNCSHIONAL_ROOT_DIR := ${RAKE_ROOT_DIR}scripts/lib/funcshional/

export

# simple targets
.PHONY: init_submodules
init_submodules:
	@git submodule update --init --recursive

.PHONY: help
help: init_submodules
	@. ${RAKE_ROOT_DIR}/scripts/help.sh

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
	@. scripts/forward_to_sub.sh $@
