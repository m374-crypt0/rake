#!/bin/env bash

get_ppid() {
  if [ -n "$1" ]; then
    eval "$1"
  else
    echo "$PPID"
  fi
}

is_sub_registered_for_ppid() {
  local ppid && ppid="$1"

  local registered_sub_ppid &&
    read -r registered_sub_ppid _ <<<"$(cat "${RAKE_ROOT_DIR}runs/.registered_sub")"

  [ -n "$registered_sub_ppid" ] &&
    [ "$ppid" = "$registered_sub_ppid" ]
}

register_sub() {
  local ppid && ppid="$1"
  local target && target="$2"

  echo "$ppid $target" >"${RAKE_ROOT_DIR}"runs/.registered_sub
}

make_sub_target() {
  local target && target="$1"

  local sub &&
    read -r _ sub <<<"$(cat "${RAKE_ROOT_DIR}"runs/.registered_sub)"

  make -s -C "${RAKE_ROOT_DIR}subs/${sub}" "$target"
}

main() {
  local target && target="$1"
  local ppid_provider && ppid_provider="$2"

  local ppid && ppid="$(get_ppid "$ppid_provider")"

  if is_sub_registered_for_ppid "$ppid"; then
    make_sub_target "$target"
  else
    register_sub "$ppid" "$target"
  fi
}

main "$1" "$2"
