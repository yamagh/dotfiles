#!/bin/sh
touch --date="`ls --full-time "$1" | ruby -e "require 'Time'; puts Time.parse(gets).strftime('%Y-%m-%d %H:%M:%S')"`" "$2"

