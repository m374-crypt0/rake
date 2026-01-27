setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"
}

teardown() {
  :
}

@test 'sub list compound target output nothing if there is no sub' {
  run make -C "$RAKE_ROOT_DIR" sub list

  assert_output ''
}
