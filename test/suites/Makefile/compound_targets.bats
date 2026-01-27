setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}test/test_helper/test_functions.sh"

  load "${RAKE_ROOT_DIR}scripts/error_codes.sh"

  setup_copy_rake_in_tmpdir
}

teardown() {
  teardown_remove_rake_from_tmpdir
}

@test 'sub list reports if there is no sub and fails' {
  run make -C "$RAKE_ROOT_DIR" sub list

  assert_not_equal $status 0
  assert_regex "$output" "There is no sub"
  assert_regex "$output" ".*Error ${RAKE_NO_SUB}"
}

@test 'Sub list reports invalid subs found and fails' {
  create_sub_directory invalid_sub_1
  create_sub_directory invalid_sub_2

  run make -C "$RAKE_ROOT_DIR" sub list

  assert_not_equal $status 0
  assert_regex "$output" ".*Error ${RAKE_NO_VALID_SUB}"
  assert_regex "$output" "There is no valid sub"
  assert_regex "$output" "Following sub directories are missing a 'Makefile':"
  assert_regex "$output" "- invalid_sub_1"
  assert_regex "$output" "- invalid_sub_2"
}

@test 'Sub list reports all valid sub found' {
  create_sub_and_target fancy_sub print
  create_sub_and_target snappy_sub yell
  create_sub_and_target shitty_sub poop

  run make -C "$RAKE_ROOT_DIR" sub list

  assert_equal $status 0
  assert_output 'shitty_sub
snappy_sub
fancy_sub'
}
