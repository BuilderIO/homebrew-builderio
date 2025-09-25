#!/bin/bash

# Script to calculate SHA256 hash for the Builder Dev Tools npm package
# This is needed for the Homebrew formula

VERSION="1.11.43"
PACKAGE_URL="https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-${VERSION}.tgz"

if curl -L -o "builder-dev-tools-${VERSION}.tgz" "${PACKAGE_URL}"
then
  SHA256_HASH=$(shasum -a 256 "builder-dev-tools-${VERSION}.tgz" | cut -d' ' -f1) || true
  echo "sha256 \"${SHA256_HASH}\""
  rm "builder-dev-tools-${VERSION}.tgz"
else
  echo "Download failed!"
  exit 1
fi
