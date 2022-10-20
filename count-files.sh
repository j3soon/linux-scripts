#!/bin/bash -e

# Ref: https://stackoverflow.com/a/39622947
du -a | cut -d/ -f2 | sort | uniq -c | sort -nr
