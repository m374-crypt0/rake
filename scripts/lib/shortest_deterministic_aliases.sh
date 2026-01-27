# shellcheck source=../funcshional/src/funcshional.sh
. "${FUNCSHIONAL_ROOT_DIR}/src/funcshional.sh"

expand_to_prefixes() {
  local line && line="$1"
  local sequences && sequences="${line:0:1}"

  # NOTE: example: ABCD gives A AB ABC ABCD
  local i &&
    for ((i = 2; i <= ${#line}; ++i)); do
      sequences="$sequences ${line:0:$i}"
    done

  echo "$sequences"
}

each_prefix_to_stream() {
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

output_shortest_aliases() {
  sink | fold_first to_shortest_aliases '' "$stream"
}

apply_non_shuffling_algorithm() {
  local stream && stream="$1"

  echo "$stream" |
    transform_first expand_to_prefixes |
    fold_first each_prefix_to_stream '' |
    remove_all_duplicate |
    output_shortest_aliases
}

alias_is_2_or_less_in_size() {
  local alias && alias="$1"

  [ ${#alias} -le 2 ]
}

stop_if_aliases_are_short_enough() {
  sink |
    filter_first alias_is_2_or_less_in_size |
    any
}

apply_shuffling_algorithm() {
  local stream && stream="$1"

  echo "$stream"
}

shortest_deterministic_aliases() {
  local stream &&
    stream="$(check_and_sort_stream "$1")" &&
    lift apply_non_shuffling_algorithm "$stream" |
    and_then stop_if_aliases_are_short_enough |
      or_else apply_shuffling_algorithm "$stream" |
      unlift
}

# TODO: help to design, delete as soon as possible
: '
There are some steps to add to ensure aliases are computed from left to right
and from right to left:
- First, determine if shuffling-based algorithm is needed:
  - if non shuffling aliases are both less than 3 in size: not needed
  - if either non shuffling aliases is 3 or more in size: needed
- Then, need to quantify how many time at maximum the shuffle based algorithm
  must apply:
  - it depends on the smallest string in the stream
  - it is actually the size of the smallest string at maximum
    - it could be less if any of resulting aliases are of size 2.
- Then, determine how many shuffling are needed for all string in the stream
- A shuffling is a way to well, shuffle string this way:
  - consider the string ABCD
  - by shuffling the string you will obtain:
    - ADCB
    - ABDC
  - More shuffling is unnecessary cause you will find the origin ABCD string
  - The number of shuffles is depending of the string size: N - 2
  - after each shuffle, apply the already designed algorithm
- Then, select resulting aliases tuple that are the shortest
'
