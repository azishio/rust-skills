#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
export CLIPPY_CONF_DIR="$script_dir/../assets"
lint_args_file="$CLIPPY_CONF_DIR/clippy-lints.txt"

if [[ ! -f "$CLIPPY_CONF_DIR/clippy.toml" || ! -f "$lint_args_file" ]]; then
  printf 'strict-clippy.sh: missing Clippy configuration in %s\n' "$CLIPPY_CONF_DIR" >&2
  exit 1
fi

mapfile -t lint_args <"$lint_args_file"

exec cargo clippy "$@" -- "${lint_args[@]}"
