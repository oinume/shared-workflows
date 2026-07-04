#!/usr/bin/env bash
set -euo pipefail

body="${1:-${BODY:-}}"
body_lower=$(printf '%s' "$body" | tr '[:upper:]' '[:lower:]')

contains_keyword() {
  local keyword="$1"
  [[ "$body_lower" =~ (^|[^[:alnum:]_])${keyword}([^[:alnum:]_]|$) ]]
}

if contains_keyword "opus48" || contains_keyword "opus"; then
  model="claude-opus-4-8"
elif contains_keyword "opus47"; then
  model="claude-opus-4-7"
elif contains_keyword "sonnet5" || contains_keyword "sonnet"; then
  model="claude-sonnet-5"
elif contains_keyword "sonnet46"; then
  model="claude-sonnet-4-6"
elif contains_keyword "haiku45" || contains_keyword "haiku"; then
  model="claude-haiku-4-5"
else
  model="claude-sonnet-5"
fi

if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  echo "model=$model" >> "$GITHUB_OUTPUT"
fi

printf '%s\n' "$model"
