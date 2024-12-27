#!/usr/bin/env bash

set -ex

prefix=/opt/homebrew/bin
mkdir -p ${prefix}/bin
cp $(dirname $0)/zsh ${prefix}/.
