#!/bin/sh

if !(which brew >> /dev/null); then
  echo "install homebrew"
  exit 0
fi

brew install swiftformat swiftlint pre-commit

pre-commit install
pre-commit run
