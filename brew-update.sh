#! /bin/bash

# verbose if --verbose is first argument
if [[ "$1" == "--verbose" ]]
then
  VERBOSE=true
fi

# if mtime of temp file is < 1d skip check
if [[ -f "${TMPDIR}"/dev-tools-livecheck ]]
then
  MTIME=$(stat -f "%m" "${TMPDIR}"/dev-tools-livecheck)
  if [[ "$MTIME" -gt $(date -v -1d +%s) ]]
  then
    if [[ "$VERBOSE" == true ]]
    then
      MTIME_DATE=$(date -r "$MTIME")
      echo "Skipping check, last checked ${MTIME_DATE} ago"
    fi
    exit 0
  fi
fi

OUTPUT=$(brew livecheck dev-tools)

# Check the output for the latest version
LATEST_VERSION=$(echo "$OUTPUT" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)

CURRENT_VERSION=$(grep 'url.*dev-tools-' "Formula/dev-tools.rb" | sed 's/.*dev-tools-\([0-9.]*\)\.tgz.*/\1/')

if [[ "$VERBOSE" == true ]]
then
  echo "Latest version: $LATEST_VERSION"
  echo "Current version: $CURRENT_VERSION"
fi

# Check if the latest version is different from the current version
if [[ "$LATEST_VERSION" != "$CURRENT_VERSION" ]]
then
  brew upgrade dev-tools
fi

touch "${TMPDIR}"/dev-tools-livecheck
