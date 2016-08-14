#!/bin/sh
set -eu
: $1
convert "$1/*{jpg,jpeg,png}" "$1.pdf"

