setup_file() {
  bats_require_minimum_version 1.5.0
}

setup() {
  load "${RAKE_ROOT_DIR}test/test_helper/bats-support/load"
  load "${RAKE_ROOT_DIR}test/test_helper/bats-assert/load"

  load "${RAKE_ROOT_DIR}scripts/lib/shortest_deterministic_aliases.sh"
}

teardown() {
  :
}

# bats file_tags=bats:focus
@test 'for empty string, shortest alias is empty output' {
  run shortest_deterministic_aliases

  assert_output ''
}

@test 'for strings starting differently, aliases are first letter of each strings' {
  run shortest_deterministic_aliases $'foo\nbar'

  assert_output $'b\nf'
}

@test 'for identical strings, shortest_deterministic_aliases issues an error' {
  run shortest_deterministic_aliases $'foo\nfoo'

  assert_not_equal $status 0
}

@test 'for strings starting with the same letter, aliases are first two letters of each string' {
  run shortest_deterministic_aliases $'bar\ncar\nfar\nfoo'

  assert_output $'b\nc\nfa\nfo'
}

@test 'strings that differentiate by only their last string do not have aliases' {
  run shortest_deterministic_aliases $'foo\nfooo\nfoooo'

  assert_output $'foo\nfooo\nfoooo'
}
