#!/usr/bin/env bash

# Shared helpers for Husky hooks.

is_ci() {
  [[ -n "${CI:-}" || -n "${GITHUB_ACTIONS:-}" || -n "${GITLAB_CI:-}" || -n "${CIRCLECI:-}" || -n "${TRAVIS:-}" || -n "${BUILDKITE:-}" || -n "${TF_BUILD:-}" ]]
}

skip_hook() {
  local reason="${1:-}"
  if [[ -n "$reason" ]]; then
    echo "Skipping hook: $reason"
  else
    echo "Skipping hook"
  fi
  exit 0
}

print_header() {
  echo ""
  echo "----------------------------------------"
  echo "$1"
  echo "----------------------------------------"
}

print_info() {
  echo "$1"
}

print_success() {
  echo "$1"
}

exit_with_error() {
  local message="$1"
  local hint="${2:-}"
  echo "$message" >&2
  if [[ -n "$hint" ]]; then
    echo "$hint" >&2
  fi
  exit 1
}

_HOOK_START=0

start_timer() {
  _HOOK_START=$(date +%s)
}

end_timer() {
  local label="${1:-Hook}"
  local end elapsed
  end=$(date +%s)
  elapsed=$((end - _HOOK_START))
  echo "$label finished in ${elapsed}s"
}
