# bats file_tags=bats:focus
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

@test 'cannot rakeup in a non empty directory' {
  export RAKEUP_INSTALL_DIR="${BATS_TEST_TMPDIR}/.rake/"
  run touch "${RAKEUP_INSTALL_DIR}a_file"
  run install_from_curl

  run "${RAKEUP_INSTALL_DIR}rakeup"

  assert_output abc
  assert_equal $status "$RAKE_INVALID_PROJECT_DIR"
}
