#!/bin/bash -e

myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo "${myip}"
