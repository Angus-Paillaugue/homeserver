#!/usr/bin/env bash

# This script creates a backup of the Immich data directory and stores it in a specified backup location.
HERE="$(dirname "$(realpath "$0")")"
OUTPUT_LOCATION="/mnt/storage/backups/immich"
SOURCE_LOCATION="$HERE/immich"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_LOCATION"

# Use rsync to copy files from source to output location
rsync -av --delete "$SOURCE_LOCATION/" "$OUTPUT_LOCATION/"
