#!/bin/bash -e

if git log > /dev/null 2>&1; then
    echo "Error: Your git repository already contains commits."
    exit 1
else
    git commit -m "Initial empty commit" --allow-empty
    echo "Done."
fi
