MAKEFLAGS += --no-print-directory

ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

export

.PHONY: help
help:
	@. ${ROOT_DIR}/scripts/$@.sh
