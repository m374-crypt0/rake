# bats file_tags=bats:focus
copy_rake_in_tmpdir() {
  cp -r "${RAKE_ROOT_DIR}" "$BATS_TEST_TMPDIR"
  export RAKE_ROOT_DIR="${BATS_TEST_TMPDIR}/rake/"
}

remove_rake_from_tmpdir() {
  rm -rf "${BATS_TEST_TMPDIR}/rake"
}

call_forward_to_sub() {
  bash -c ". ${RAKE_ROOT_DIR}scripts/forward_to_sub.sh $1"
}

setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  copy_rake_in_tmpdir
}

teardown() {
  remove_rake_from_tmpdir
}

@test 'call to forward_to_sub without a target does not create .last_sub file in runs directory' {
  run call_forward_to_sub

  [ ! -f "${RAKE_ROOT_DIR}runs/.last_sub" ]
}

@test 'call to forward_to_sub with sub target creates .last_sub file in runs directory' {
  run call_forward_to_sub sub

  [ -f "${RAKE_ROOT_DIR}runs/.last_sub" ]
}
