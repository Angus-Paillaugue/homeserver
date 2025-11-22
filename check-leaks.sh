#!/usr/bin/env bash

HERE="$(dirname "$(realpath "$0")")"
echo $HERE
docker pull ghcr.io/gitleaks/gitleaks:latest
docker run -v $HERE:/path ghcr.io/gitleaks/gitleaks:latest detect --source /path -v
