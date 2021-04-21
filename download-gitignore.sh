#!/bin/bash
set -e

ARG_LOWER="$(echo $1 | tr '[:upper:]' '[:lower:]')"
if [ "$ARG_LOWER" = "python" ]; then
    LANG="Python"
elif [ "$ARG_LOWER" = "c" ]; then
    LANG="C"
elif [ "$ARG_LOWER" = "cpp" ]; then
    LANG="C++"
else
    LANG="$1"
fi

URL="https://github.com/github/gitignore/raw/master/$LANG.gitignore"

if [ -f ".gitignore" ]; then
    echo "Error: .gitignore exists."
    exit 1
fi

if curl --head --silent --fail $URL > /dev/null 2>&1; then
    curl $URL --output .gitignore
    echo "Done."
else
    echo "Error: Language not supported."
    exit 1
fi
