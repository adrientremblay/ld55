#!/bin/sh
echo -ne '\033c\033]0;LD55\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/DarkAltar.x86_64" "$@"
