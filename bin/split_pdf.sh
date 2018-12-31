#!/bin/zsh

while read fp
do
  d=`dirname "$fp"`/`basename "$fp" ".pdf"`
  mkdir "$d"
  /usr/local/bin/pdfseparate "$fp" "$d/%d.pdf"
done

