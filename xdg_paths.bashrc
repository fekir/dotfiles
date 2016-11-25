#!/usr/bin/env bash

# from https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
#declare -r XDG_DATA_DIRS=
#declare -r XDG_CONFIG_DIRS=
XDG_CACHE_HOME="${XDG_CONFIG_HOME:-$HOME/.cache}"
#declare -r XDG_RUNTIME_DIR=

