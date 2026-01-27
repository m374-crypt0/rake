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
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    touch "${BATS_TEST_TMPDIR}/dir/a_file" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}scripts/rakeup"

  assert_equal $status "$RAKE_INVALID_PROJECT_DIR"
}
