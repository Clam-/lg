#!/usr/bin/env bash

set -euo pipefail

image_name="${LG_DOCKER_IMAGE:-lg-build-env}"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/.." && pwd)"
dockerfile="${repo_root}/docker/build.Dockerfile"
workspace="${repo_root}"

if [[ ! -f "${dockerfile}" ]]; then
  echo "missing ${dockerfile}" >&2
  exit 1
fi

if [[ $# -eq 0 ]]; then
  target_cmd=(make clean all)
else
  target_cmd=("$@")
fi

docker build -t "${image_name}" -f "${dockerfile}" "${repo_root}"

docker run --rm \
  -v "${workspace}:/src" \
  -w /src \
  "${image_name}" \
  "${target_cmd[@]}"
