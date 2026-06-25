#!/usr/bin/env bash
set -euo pipefail

echo "Required GitHub repository settings:"
echo
echo "1. Settings -> Actions -> General -> Workflow permissions"
echo "2. Select: Read and write permissions"
echo "3. Save"
echo
echo "No repository secrets are required. The update workflow uses GITHUB_TOKEN."
