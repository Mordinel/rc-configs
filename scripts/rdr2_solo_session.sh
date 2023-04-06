#!/bin/sh

pid=`pgrep '^RDR2.exe'`
kill -19 "$pid"
sleep 8
kill -18 "$pid"

