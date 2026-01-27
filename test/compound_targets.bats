setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}scripts/error_codes.sh"
}

teardown() {
  :
}

@test 'sub list output nothing if there is no sub' {
  run make -s -C "$RAKE_ROOT_DIR" sub list

  assert_not_equal $status 0
  assert_regex "$output" "There is no sub"
  assert_regex "$output" ".*Error ${RAKE_NO_SUB}"
}
