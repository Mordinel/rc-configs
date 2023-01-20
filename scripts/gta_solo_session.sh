#!/bin/sh

pid=`pgrep GTA5.exe`
kill -19 "$pid"
sleep 8
kill -18 "$pid"

