#!/bin/bash

# Script to calculate SHA256 hash for the Builder Dev Tools npm package
# This is needed for the Homebrew formula

VERSION="1.11.43"
PACKAGE_URL="https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-${VERSION}.tgz"

echo "Downloading @builder.io/dev-tools version ${VERSION}..."
curl -L -o "builder-dev-tools-${VERSION}.tgz" "${PACKAGE_URL}"

if [ $? -eq 0 ]; then
    echo "Download successful!"
    echo "Calculating SHA256 hash..."
    SHA256_HASH=$(shasum -a 256 "builder-dev-tools-${VERSION}.tgz" | cut -d' ' -f1)
    echo "SHA256 hash: ${SHA256_HASH}"
    echo ""
    echo "Update the formula with this hash:"
    echo "sha256 \"${SHA256_HASH}\""
    echo ""
    echo "Cleaning up downloaded file..."
    rm "builder-dev-tools-${VERSION}.tgz"
else
    echo "Download failed!"
    exit 1
fi
