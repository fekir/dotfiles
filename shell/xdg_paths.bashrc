#!/usr/bin/env bash

# from https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
#declare -r XDG_DATA_DIRS=
#declare -r XDG_CONFIG_DIRS=
export XDG_CACHE_HOME="${XDG_CONFIG_HOME:-$HOME/.cache}"
#declare -r XDG_RUNTIME_DIR=

