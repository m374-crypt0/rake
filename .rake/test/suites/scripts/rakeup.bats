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

# # bats file_tags=bats:focus
# @test 'rakeup update an existing installation of rake' {
#   install_from_curl
#   true >"${RAKE_ROOT_DIR}".rake/install
#   true >"${RAKE_ROOT_DIR}".rake/rake

#   assert_not_equal 0 "$(cat "${RAKE_ROOT_DIR}.rake/rakeup" | wc -m)"
#   assert_equal 0 "$(cat "${RAKE_ROOT_DIR}.rake/install" | wc -m)"
#   assert_equal 0 "$(cat "${RAKE_ROOT_DIR}.rake/rake" | wc -m)"

# }
