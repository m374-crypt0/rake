# bats file_tags=bats:focus
setup_copy_rake_in_tmpdir() {
  cp -r "${RAKE_ROOT_DIR}" "$BATS_TEST_TMPDIR"
  export RAKE_ROOT_DIR="${BATS_TEST_TMPDIR}/rake/"
}

teardown_remove_rake_from_tmpdir() {
  rm -rf "${BATS_TEST_TMPDIR}/rake"
}

call_forward_to_sub() {
  bash -c ". ${RAKE_ROOT_DIR}scripts/forward_to_sub.sh $1 $2"
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
    local ppid &&
    read -r sub_name ppid <<<"$(cat "${RAKE_ROOT_DIR}runs/.registered_sub")"

  echo "$sub_name $ppid"
}

testing_ppid_provider() {
  echo "'echo 42'"
}

setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-file/load"

  setup_copy_rake_in_tmpdir
}

teardown() {
  teardown_remove_rake_from_tmpdir
}

@test 'call to forward_to_sub without a target does not create .last_sub file in runs directory' {
  run call_forward_to_sub

  assert_file_not_exists "${RAKE_ROOT_DIR}runs/.last_sub"
}

@test 'each call to forward_to_sub from different parent process register a new sub' {
  local first_read_sub && local second_read_sub
  local first_read_ppid && local second_read_ppid

  run call_forward_to_sub first_sub
  read -r first_read_ppid first_read_sub <<<"$(read_sub_from_registered_sub_file)"

  run call_forward_to_sub second_sub
  read -r second_read_ppid second_read_sub <<<"$(read_sub_from_registered_sub_file)"

  assert_not_equal "$first_read_ppid" "$second_read_ppid"
  assert_equal "$first_read_sub" first_sub
  assert_equal "$second_read_sub" second_sub
}

@test "two calls to forward_to_sub from the same parent process register the sub and call the sub's Makefile target" {
  create_sub_and_target testing_sub print

  local direct_make_output &&
    direct_make_output="$(make -C "${RAKE_ROOT_DIR}subs/testing_sub" print)"

  run call_forward_to_sub testing_sub "$(testing_ppid_provider)"
  run call_forward_to_sub print "$(testing_ppid_provider)"

  assert_equal "$output" "$direct_make_output"
}
