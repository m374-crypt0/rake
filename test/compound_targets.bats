copy_rake_in_tmpdir() {
  cp -r "${RAKE_ROOT_DIR}" "$BATS_TEST_TMPDIR"
  export RAKE_ROOT_DIR="${BATS_TEST_TMPDIR}/rake"
}

remove_rake_from_tmpdir() {
  rm -rf "${BATS_TEST_TMPDIR}/rake"
}

setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}scripts/error_codes.sh"

  copy_rake_in_tmpdir
}

teardown() {
  remove_rake_from_tmpdir
}

@test 'sub list reports if there is no sub and fails' {
  run make -C "$RAKE_ROOT_DIR" sub list

  assert_not_equal $status 0
  assert_regex "$output" "There is no sub"
  assert_regex "$output" ".*Error ${RAKE_NO_SUB}"
}

@test 'Sub list reports invalid subs found and fails' {
  mkdir -p "$RAKE_ROOT_DIR/subs/invalid_sub"

  run make -C "$RAKE_ROOT_DIR" sub list

  assert_not_equal $status 0
  assert_regex "$output" "There is no sub"
  assert_regex "$output" "There is some dir though:"
  assert_regex "$output" "- invalid_sub"
  assert_regex "$output" ".*Error ${RAKE_NO_VALID_SUB}"
}
