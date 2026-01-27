setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-file/load"

  load "${RAKE_ROOT_DIR}test/test_helper/test_functions.sh"

  load "${RAKE_ROOT_DIR}scripts/error_codes.sh"
}

teardown() {
  :
}

@test 'executing install from cURL installs rakeup in a specified directory' {
  export RAKEUP_INSTALL_DIR="${BATS_TEST_TMPDIR}/.rake/"

  curl "file://${RAKE_ROOT_DIR}scripts/install" | bash

  assert_file_exists "${RAKEUP_INSTALL_DIR}/rakeup"
}
