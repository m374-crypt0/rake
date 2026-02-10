setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-assert/load"
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-file/load"

  load "${RAKE_ROOT_DIR}.rake/test/test_helper/test_functions.sh"
}

teardown() {
  :
}

@test 'cannot rake in a non empty directory' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    touch "${BATS_TEST_TMPDIR}/dir/a_file" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}.rake/scripts/rake"

  assert_not_equal $status 0
  assert_output 'rake: call rake within an empty directory'
}

@test 'cannot rake in an existing git repository' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    cd "${BATS_TEST_TMPDIR}/dir" &&
    git init >/dev/null 2>&1 &&
    mkdir inner &&
    cd inner

  run "${RAKE_ROOT_DIR}.rake/scripts/rake"

  assert_not_equal $status 0
  assert_output 'rake: do not rake within an existing git repository'
}

@test 'rake in a valid dir create an empty rake project and initialize a git repository' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}.rake/scripts/rake"

  run git status
  assert_equal $status 0

  run make sub list
  assert_regex "$output" 'There is no sub'
}
