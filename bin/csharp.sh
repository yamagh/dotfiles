#!/bin/sh
mcs $1 -out:out.exe
mono out.exe
rm out.exe