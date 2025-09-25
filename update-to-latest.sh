#!/bin/bash

# Script to automatically update dev-tools formula to the latest npm version

set -euo pipefail

FORMULA_FILE="Formula/dev-tools.rb"
CURRENT_VERSION=$(grep 'version "' "${FORMULA_FILE}" | cut -d'"' -f2)

LATEST_VERSION=$(curl -s "https://registry.npmjs.org/@builder.io/dev-tools" | jq -r '.["dist-tags"].latest')

if [[ "${CURRENT_VERSION}" = "${LATEST_VERSION}" ]]; then
    echo "Already up to date with version ${LATEST_VERSION}"
    exit 0
fi

echo "Updating from ${CURRENT_VERSION} to ${LATEST_VERSION}..."

PACKAGE_URL="https://registry.npmjs.org/@builder.io/dev-tools/-/dev-tools-${LATEST_VERSION}.tgz"
TEMP_FILE="builder-dev-tools-${LATEST_VERSION}.tgz"

if ! curl -L -o "${TEMP_FILE}" "${PACKAGE_URL}"; then
    echo "Failed to download package"
    exit 1
fi

NEW_SHA256=$(shasum -a 256 "${TEMP_FILE}" | cut -d' ' -f1)

rm "${TEMP_FILE}"

sed -i '' "s/version \"${CURRENT_VERSION}\"/version \"${LATEST_VERSION}\"/" "${FORMULA_FILE}"
sed -i '' "s/dev-tools-${CURRENT_VERSION}.tgz/dev-tools-${LATEST_VERSION}.tgz/" "${FORMULA_FILE}"
sed -i '' "s/sha256 \".*\"/sha256 \"${NEW_SHA256}\"/" "${FORMULA_FILE}"
