#!/usr/bin/env bash

prefix=/opt/homebrew/bin
mkdir -p ${prefix}/bin
cp $(dirname $0)/zsh ${prefix}/.
