setup_copy_rake_in_tmpdir() {
  cp -r "${RAKE_ROOT_DIR}" "$BATS_TEST_TMPDIR"
  RAKE_ROOT_DIR="${BATS_TEST_TMPDIR}/rake/"
}

teardown_remove_rake_from_tmpdir() {
  rm -rf "${BATS_TEST_TMPDIR}/rake"
}

call_forward_to_sub() {
  bash -c ". ${RAKE_ROOT_DIR}.rake/scripts/forward_to_sub.sh $1 $2"
}

create_sub_directory() {
  local sub && sub="$1"

  mkdir -p "${RAKE_ROOT_DIR}${sub}"
}

create_sub_target() {
  local sub && sub="$1"
  local target && target="$2"

  mkdir -p "${RAKE_ROOT_DIR}${sub}"

  cat <<EOF >"${RAKE_ROOT_DIR}${sub}/Makefile"
${target}:
	@echo I am $target target
EOF
}

create_sub_and_target() {
  create_sub_directory "$1" &&
    create_sub_target "$1" "$2"
}

read_sub_from_registered_sub_file() {
  local sub_name && local ppid &&
    read -r sub_name ppid <<<"$(cat "${RAKE_ROOT_DIR}.rake/.registered_sub")"

  echo "$sub_name $ppid"
}

testing_ppid_provider() {
  echo "'echo 42'"
}

pause_test() {
  echo ">>> $BATS_TEST_TMPDIR" >&3
  read -er
}

install_from_curl() {
  curl "file://${RAKE_ROOT_DIR}.rake/scripts/install" | bash
}
