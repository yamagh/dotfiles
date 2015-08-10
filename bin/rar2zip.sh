#!/bin/sh

usage(){
  echo Usage: foo.rar
  exit 1
}

is_rar(){
  local path=`echo "$1" | tr '[:upper:]' '[:lower:]'`
  local ext=${path##*.}
  [ $ext = 'rar' ] && return 0 || return 1
}

set -eu
: $1

IFS="
"

is_rar "$1"
[ $? -ne 0 ] && usage

zip_name=`basename "$1"`
zip_name=${zip_name%.*}.zip
if [ -e $zip_name ]; then
  echo "Already exists $zip_name"
  exit 1
fi

cd `dirname "$1"`
tmp_dir=$(mktemp -d rar2zip.XXXXXX)
trap "rm -rf $tmp_dir" 0
unrar x -inul `basename "$1"` $tmp_dir
if [ $? -ne 0 ]; then
  echo Invalid rar file
  exit 1
fi

cd $tmp_dir
zip -rq ../$zip_name *
cd ..
rm "$1"
