#!/bin/env bash

"${RAKE_ROOT_DIR}"test/bats/bin/bats -pr "${RAKE_ROOT_DIR}"test/*.bats
