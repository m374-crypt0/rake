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

# bats file_tags=bats:focus
@test 'invoking rake alone print a man page' {
  run "${RAKE_ROOT_DIR}.rake/scripts/rake"

  assert_not_equal $status 0

  assert_regex "$output" NAME
  assert_regex "$output" SYNOPSIS
  assert_regex "$output" DESCRIPTION
  assert_regex "$output" 'RAKE COMMANDS'
  assert_regex "$output" 'RAKE NEW ARGS'
}

@test 'invoking rake with anything than supported command fails' {
  run "${RAKE_ROOT_DIR}.rake/scripts/rake" foo

  assert_not_equal $status 0

  assert_regex "$output" 'error: unrecognized command: <foo>'
  assert_regex "$output" 'type rake without argument to read the manual'
}

@test 'cannot rake new in a non empty directory' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    touch "${BATS_TEST_TMPDIR}/dir/a_file" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}.rake/scripts/rake" new

  assert_not_equal $status 0
  assert_output 'rake new error: current directory must be empty'
}

@test 'can rake new in a non empty directory if --force is passed' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    touch "${BATS_TEST_TMPDIR}/dir/a_file" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}.rake/scripts/rake" new --force

  assert_equal $status 0
}

@test 'cannot rake new in an existing git repository' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    cd "${BATS_TEST_TMPDIR}/dir" &&
    git init >/dev/null 2>&1 &&
    mkdir inner &&
    cd inner

  run "${RAKE_ROOT_DIR}.rake/scripts/rake" new

  assert_not_equal $status 0
  assert_output 'rake new error: do not rake new within an existing git repository'
}

@test 'can rake new in an existing git repository if --force is passed' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    cd "${BATS_TEST_TMPDIR}/dir" &&
    git init >/dev/null 2>&1 &&
    mkdir inner &&
    cd inner

  run "${RAKE_ROOT_DIR}.rake/scripts/rake" new --force

  assert_equal $status 0
}

@test 'rake new in a valid dir create an empty rake project and initialize a git repository' {
  mkdir -p "${BATS_TEST_TMPDIR}/dir" &&
    cd "${BATS_TEST_TMPDIR}/dir"

  run "${RAKE_ROOT_DIR}.rake/scripts/rake" new

  run git status
  assert_equal $status 0

  run make sub list
  assert_regex "$output" 'There is no sub'
}
