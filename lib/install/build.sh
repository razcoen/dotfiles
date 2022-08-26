#!/usr/bin/env bash

GO_VERSION=$(go version 2> /dev/null)
if [[ -z $GO_VERSION ]]; then
  echo "\"build.sh\" requires Go installed."
  echo "Please use the https://github.com/razcoen/dotfiles/install.sh script to install Go for you."
  exit 1
fi


BUILD_DIR=$(dirname $(realpath $0))
cd $BUILD_DIR

CHECKSUM=($(sha1sum ../../dotfiles))
LDFLAGS="-X main.dotfilesChecksum=$CHECKSUM -X main.version=$(git rev-list HEAD -n 1) "
GOOS=darwin

mkdir -p bin
GOARCH=arm64 go build -ldflags "$LDFLAGS" -o ./bin/install-arm64
GOARCH=amd64 go build -ldflags "$LDFLAGS" -o ./bin/install-amd64
