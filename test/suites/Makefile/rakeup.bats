setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}test/test_helper/test_functions.sh"

  load "${RAKE_ROOT_DIR}scripts/error_codes.sh"
}

teardown() {
  :
}

@test 'todo' {
  refute
}
