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

@test 'rakeup update an existing installation of rake' {
  export HOME="${BATS_TEST_TMPDIR}"
  export RAKE_INSTALL_DIR="${HOME}/.rake/"

  run install_from_curl

  true >"${RAKE_INSTALL_DIR}rake"
  assert_equal 0 "$(cat "${RAKE_INSTALL_DIR}rake" | wc -m)"

  run "${RAKE_INSTALL_DIR}rakeup"

  assert_not_equal 0 "$(cat "${RAKE_INSTALL_DIR}rake" | wc -m)"
}
