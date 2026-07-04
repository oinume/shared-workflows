#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
SCRIPT="$ROOT_DIR/scripts/determine-claude-model.sh"

assert_model() {
  local keyword="$1"
  local expected="$2"
  local actual

  actual=$("$SCRIPT" "Please run Claude with ${keyword}")

  if [[ "$actual" != "$expected" ]]; then
    printf 'keyword %s: expected %s, got %s\n' "$keyword" "$expected" "$actual" >&2
    return 1
  fi
}

assert_model "opus" "claude-opus-4-8"
assert_model "opus48" "claude-opus-4-8"
assert_model "opus47" "claude-opus-4-7"
assert_model "sonnet" "claude-sonnet-5"
assert_model "sonnet5" "claude-sonnet-5"
assert_model "sonnet46" "claude-sonnet-4-6"
assert_model "haiku" "claude-haiku-4-5"
assert_model "haiku45" "claude-haiku-4-5"
assert_model "no explicit model" "claude-sonnet-5"

printf 'determine-claude-model tests passed\n'
