#!/usr/bin/env bash

# quotes are important here: `cd ""` isn't the same as `cd`.
cd "$GIT_PREFIX"

git status "$@"
GIT_PAGER=cat git stash list
