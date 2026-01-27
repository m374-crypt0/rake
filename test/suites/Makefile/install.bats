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

@test 'ensure install is executable' {
  run "${RAKE_ROOT_DIR}scripts/install"

  assert_equal $status 0
}

@test 'executing install from cURL installs rakeup in a specified directory' {
  local dest_dir && dest_dir="${BATS_TEST_DIR}/rake_install/"

  assert_dir_exists "${dest_dir}.rakeup"
}
