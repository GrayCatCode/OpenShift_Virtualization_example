#!/usr/bin/env bash
set -euo pipefail
CHART_DIR="$(dirname "$0")/../charts/vm-chart"
NAMESPACE="$(yq e '.namespace' ${CHART_DIR}/values.yaml)"
helm upgrade --install vm-helm "${CHART_DIR}" -n "${NAMESPACE}" --create-namespace
