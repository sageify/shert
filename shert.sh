# shellcheck shell=sh
# shellcheck disable=SC2031

shert_success() {
  eval "$1" >/dev/null 2>&1 && return 0
  printf "assert success: %s: found: %s\n" "$1" "$?"
}

shert_fail() {
  ! eval "$1" >/dev/null 2>&1 && return 0
  printf "assert fail: %s: found: 0\n" "$1"
}

shert_equals() {
  eval '__="$('"$1"')"'
  [ "$2" = "$__" ] && return 0
  printf "assert equals: %s: %s: found: %s\n" "$1" "$2" "$__"
  return 1
}

shert_stderr() {
  eval '__="$('"$1"' 2>&1)"'
  [ "$2" = "$__" ] && return 0
  printf "assert stderr: %s: %s: found: %s\n" "$1" "$2" "$__"
  return 1
}

shert_empty() {
  eval '__="$('"$1"')"'
  ! [ "$__" ] && return 0
  printf "assert stdout empty: %s: found: %s\n" "$1" "$__"
  return 1
}

shert_not_empty() {
  eval '__="$('"$1"')"'
  [ "$__" ] && return 0
  printf "assert stdout not empty: %s: found nothing\n" "$1"
  return 1
}

assert_equals() {
  [ "$1" = "$2" ] && return 0
  printf "assert equals: %s: found: %s%s\n" "$1" "$2" "${3+": $3"}"
  return 1
}
