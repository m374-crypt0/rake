setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}.rake/test/test_helper/test_functions.sh"

  setup_copy_rake_in_tmpdir
}

teardown() {
  teardown_remove_rake_from_tmpdir
}

@test 'sub list outputs an existing sub with alias information for very different subs' {
  create_sub_and_target foo target
  create_sub_and_target bar target

  run make -C "$RAKE_ROOT_DIR" sub list

  assert_output 'bar
foo'
}
