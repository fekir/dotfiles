#!/usr/bin/env bash

prog_files=$(cygpath "$PROGRAMFILES")/
# since you cannot have ( or ) in a variable name, we are guessing the correct path...
if [ -d "$PROGRAMFILES (x86)" ]; then
  prog_files_6432=$(cygpath "$PROGRAMFILES (x86)")/;
fi

# similar to append_to_path, but more convenient if a program may be 32 or 64 bit
append_program_dir_to_path(){
  if append_to_path "$prog_files""$1"; then
    return 0;
  fi
  # in case we have 64 bit windows and 32 bit program
  if [ -v prog_files_6432 ]; then
    if append_to_path "$prog_files_6432""$1"; then
      return 0;
    fi
  fi
  return 1;
}

# not real sudo, but better than nothing
as_admin() {
  cygstart --action=runas "$@"
}

load_vs() {
  if [ -f "$prog_files""Microsoft Visual Studio 14.0/VC/vcvarsall.bat" ]; then
    "$prog_files_6432""Microsoft Visual Studio 14.0/VC/vcvarsall.bat"
  fi
  if [ -f "$prog_files_6432""Microsoft Visual Studio 14.0/VC/vcvarsall.bat" ]; then
    "$prog_files_6432""Microsoft Visual Studio 14.0/VC/vcvarsall.bat"
  fi
}


if [ -f "$prog_files""Notepad++/notepad++.exe" ]; then
    define_alias_ifndef "npp" '"$prog_files""Notepad++/notepad++.exe"'
elif [ -f "$prog_files_6432""Notepad++/notepad++.exe" ]; then
    define_alias_ifndef "npp" '"$prog_files_6432""Notepad++/notepad++.exe"'
fi


append_program_dir_to_path "WiX Toolset v3.10/bin"

alias ls="ls --color=auto --append-exe"
