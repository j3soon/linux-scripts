#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
COMMAND="export PATH=$DIR:\$PATH"
if cat $HOME/.bashrc | grep "$COMMAND"
then
    echo "Error: Already installed."
    exit 1
else
    echo $COMMAND >> $HOME/.bashrc
    echo "Done."
    printf "Type the following to reload\n\n    source $HOME/.bashrc\n\n"
fi
