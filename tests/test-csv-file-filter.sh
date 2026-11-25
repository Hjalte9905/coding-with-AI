#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

"${CXX:-g++}" -std=c++20 "$repo_root/src/CSV-file-filter.c" -o "$tmpdir/csv-file-filter"

printf 'A' >"$tmpdir/input.csv"
"$tmpdir/csv-file-filter" 18 "$tmpdir/input.csv" \
  >"$tmpdir/actual.stdout" 2>"$tmpdir/actual.stderr"

if [[ -s "$tmpdir/actual.stdout" ]]; then
  echo "Expected no standard output for a row missing its age." >&2
  exit 1
fi

actual_stderr="$(<"$tmpdir/actual.stderr")"
if [[ "$actual_stderr" != "Line 1: Age missing." ]]; then
  echo "Unexpected standard error: $actual_stderr" >&2
  exit 1
fi

echo "CSV file filter regression test passed."
