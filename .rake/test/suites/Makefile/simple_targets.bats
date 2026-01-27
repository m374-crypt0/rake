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

@test 'help target succeeds and output something' {
  run make -C "${RAKE_ROOT_DIR}" help

  [ -n "$output" ]
}

@test 'a target is forwarded to sub even if a simple target exists in main Makefile' {
  mkdir -p "${RAKE_ROOT_DIR}.rake/mysub"
  cat <<EOF >"${RAKE_ROOT_DIR}.rake/mysub/Makefile"
help:
	@echo mysub help target
EOF

  run make -C "${RAKE_ROOT_DIR}" mysub help

  assert_output 'mysub help target'
}
