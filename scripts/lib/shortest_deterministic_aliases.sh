# shellcheck source=../funcshional/src/funcshional.sh
. "${FUNCSHIONAL_ROOT_DIR}/src/funcshional.sh"

split_letter_sequences() {
  local line && line="$1" &&
    local i && local sequences &&
    sequences="${line:0:1}" &&
    for ((i = 2; i <= ${#line}; ++i)); do
      sequences="$sequences ${line:0:$i}"
    done

  echo "$sequences"
}

to_stream() {
  local line && line="$1"
  local acc && acc="$2"
  local stream_part &&
    stream_part="$(sed -E 's/ /\n/g' <<<"$line")"

  append_string_to_stream "$acc" "$stream_part"
}

check_and_sort_stream() {
  #shellcheck disable=SC2000
  local input_size && local size &&
    input_size="$(echo "$1" | wc -m)" &&
    local stream &&
    stream="$(echo "$1" | sort | uniq)" &&
    size="$(echo "$stream" | wc -m)" &&
    [ "$input_size" -eq "$size" ] &&
    echo "$stream" ||
    return 1
}

in_stream() {
  local line && line="$1"
  local searched && searched="$2"

  [ "$line" = "$searched" ]
}

find_unaliased_line_in_stream() {
  local stream && stream="$1"
  local line && line="$2"

  echo "$stream" | filter_first in_stream "$line"
}

find_unaliased_latest_alias() {
  local stream && stream="$1"
  local latest_alias_in_accumulator && latest_alias_in_accumulator="$2"

  echo "$stream" | filter_first in_stream "$latest_alias_in_accumulator"
}

to_shortest_aliases() {
  local line && line="$1"
  local acc && acc="$2"
  local stream && stream="$3"

  if [ -z "$acc" ]; then
    acc="$line"
  else
    local unaliased_line &&
      unaliased_line="$(find_unaliased_line_in_stream "$stream" "$line")"

    local latest_alias_in_acc &&
      latest_alias_in_acc="$(echo "$acc" | sort -r | take 1)"

    local unaliased_latest_alias_in_acc &&
      unaliased_latest_alias_in_acc="$(find_unaliased_latest_alias "$stream" "$latest_alias_in_acc")"

    # NOTE: OK a bit of explanation is needed here.
    #       - First, sorting stream content gives interesting properties the
    #         following conditions rely on
    #       - This set of condition ensure both:
    #         - shortest aliases are included in the accumulator
    #         - entries that cannot be aliased are also included
    #         - take a look at tests to figure out
    #           (shortest_deterministic_aliases.bats)
    [[ "$line" == "$latest_alias_in_acc"* ]] &&
      [ "$line" = "$unaliased_line" ] &&
      [ "$latest_alias_in_acc" = "$unaliased_latest_alias_in_acc" ] ||
      [[ "$line" != "$latest_alias_in_acc"* ]] &&
      acc="$acc"$'\n'"$line"
  fi

  echo "$acc"
}

remove_all_duplicate() {
  sink | sort | uniq -u
}

ensure_original_strings_are_included() {
  sink | append "$stream" | sort | uniq
}

output_shortest_aliases() {
  sink | fold_first to_shortest_aliases '' "$stream"
}

shortest_deterministic_aliases() {
  local stream &&
    stream="$(check_and_sort_stream "$1")" &&
    echo "$stream" |
    transform_first split_letter_sequences |
      fold_first to_stream '' |
      remove_all_duplicate |
      ensure_original_strings_are_included |
      output_shortest_aliases
}
