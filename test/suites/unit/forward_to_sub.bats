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

create_sub_and_target() {
  local sub &&
    sub="$1"
  local target &&
    target="$2"

  mkdir -p "${RAKE_ROOT_DIR}subs/${sub}"

  cat <<EOF >"${RAKE_ROOT_DIR}subs/${sub}/makefile"
${target}:
	@echo I am a fancy target
EOF
}

read_sub_from_registered_sub_file() {
  local sub_name &&
    read -r sub_name <<<"$(cat "${RAKE_ROOT_DIR}runs/.registered_sub")"

  echo "$sub_name"
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

@test 'each call to forward_to_sub from different parent process register a new sub' {
  local first_sub &&
    first_sub=first_sub
  local second_sub &&
    second_sub=second_sub

  call_forward_to_sub "$first_sub"
  run read_sub_from_registered_sub_file
  assert_output "$first_sub"

  call_forward_to_sub "$second_sub"
  run read_sub_from_registered_sub_file
  assert_output "$second_sub"
}
