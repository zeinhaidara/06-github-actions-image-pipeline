#!/usr/bin/env bash
# Fails if the workflow loses one of its gates.
set -u
wf="$(dirname "$0")/../.github/workflows/image.yml"
fail=0

check() {
  if grep -Eq "$2" "$wf"; then
    echo "ok:      $1"
  else
    echo "MISSING: $1"
    fail=1
  fi
}

check "trivy scan step"            'aquasecurity/trivy-action@'
check "scan fails on HIGH,CRITICAL" 'severity: HIGH,CRITICAL'
check "scan exit-code 1"           'exit-code: "1"'
check "push limited to main"       "if: .*github\.ref == 'refs/heads/main'"
check "cosign sign step"           'cosign sign '

exit "$fail"
