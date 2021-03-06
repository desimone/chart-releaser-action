#!/usr/bin/env bash

# Copyright The Helm Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")

main() {
    owner=$(cut -d '/' -f 1 <<<"$GITHUB_REPOSITORY")
    repo=$(cut -d '/' -f 2 <<<"$GITHUB_REPOSITORY")

    args=(--owner "$owner" --repo "$repo")
    args+=(--charts-dir "${INPUT_CHARTS_DIR?Input 'charts_dir' is required}")

    if [[ -n "${INPUT_VERSION:-}" ]]; then
        args+=(--version "${INPUT_VERSION}")
    fi

    if [[ -n "${INPUT_CHARTS_REPO_URL:-}" ]]; then
        args+=(--charts-repo-url "${INPUT_CHARTS_REPO_URL}")
    fi

    "$SCRIPT_DIR/cr.sh" "${args[@]}"
}

main
