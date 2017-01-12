#! /bin/sh

TRAC_DIR="/var/www/trac/"
BACKUPS_DIR="/var/backups/trac"
TIMESTAMP=$(date +"%Y-%m-%d-%H:%M:%S")
TARGET_DIR="${BACKUPS_DIR}/trac-hotcopy-${TIMESTAMP}"

# Create parent dir if not existant
mkdir -p "${BACKUPS_DIR}"

# Remove existing backups
rm -rfv "${BACKUPS_DIR}"/*

trac-admin "${TRAC_DIR}" hotcopy "${TARGET_DIR}"
