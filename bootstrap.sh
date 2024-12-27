#!/usr/bin/env bash

set -ex

d=$(dirname "${BASH_SOURCE}")
ln -sf "$d"/{bin,.gitconfig,.gitignore,.vimrc,.profile,.zshrc} .

