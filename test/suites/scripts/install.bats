# shellcheck disable=SC2031,SC2030
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

@test 'executing install from cURL installs rakeup in a specified directory' {
  export HOME="${BATS_TEST_TMPDIR}"
  export RAKEUP_INSTALL_DIR="${HOME}/.rake/"

  run install_from_curl

  assert_file_exists "${RAKEUP_INSTALL_DIR}/rakeup"
}

@test 'install only support does only support bash for path registration' {
  export HOME="${BATS_TEST_TMPDIR}"
  export RAKEUP_INSTALL_DIR="${HOME}/.rake/"
  export SHELL="/bin/badsh"

  run install_from_curl

  assert_regex "$output" "rakeup: cannot detect your shell. Do manually add $RAKEUP_INSTALL_DIR to your PATH"

  export SHELL="/bin/bash"

  run install_from_curl

  assert_regex "$output" "Added rakeup to your PATH. Source ${HOME}/.bashrc or start a new terminal session to use rakeup."

  load "${HOME}/.bashrc"
  [[ ":$PATH:" == *":${RAKEUP_INSTALL_DIR}:"* ]]
}
