#!/usr/bin/env bash

set -e

if ! command -v go &> /dev/null ; then
  echo "Missing golang installation, please install go >=1.19"
  exit 1
fi

SOURCE_DIR=$(realpath $(dirname ${BASH_SOURCE[0]}))
echo "+ SOURCE_DIR=$SOURCE_DIR go run main.go"
SOURCE_DIR=$SOURCE_DIR go run main.go
