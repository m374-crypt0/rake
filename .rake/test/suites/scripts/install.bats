# shellcheck disable=SC2031,SC2030
setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-assert/load"
  load "${RAKE_ROOT_DIR}.rake/test/test_helper/bats-file/load"

  load "${RAKE_ROOT_DIR}.rake/test/test_helper/test_functions.sh"

  load "${RAKE_ROOT_DIR}.rake/scripts/error_codes.sh"
}

teardown() {
  :
}

@test 'executing install from cURL installs rakeup in a specified directory' {
  export HOME="${BATS_TEST_TMPDIR}"
  export RAKE_INSTALL_DIR="${HOME}/.rake/"

  run install_from_curl

  assert_file_exists "${RAKE_INSTALL_DIR}/rakeup"
  assert_file_exists "${RAKE_INSTALL_DIR}/rake"
}

@test 'install does only support bash for path registration' {
  export HOME="${BATS_TEST_TMPDIR}"
  export RAKE_INSTALL_DIR="${HOME}/.rake/"
  export SHELL="/bin/badsh"

  run install_from_curl

  assert_regex "$output" "rake: cannot detect your shell. Do manually add $RAKE_INSTALL_DIR to your PATH"

  export SHELL="/bin/bash"

  run install_from_curl

  assert_regex "$output" "Added rake to your PATH. Source ${HOME}/.bashrc or start a new terminal session to use rake."

  load "${HOME}/.bashrc"
  [[ ":$PATH:" == *":${RAKE_INSTALL_DIR}:"* ]]

  run rake

  assert_not_equal $status 127
}
