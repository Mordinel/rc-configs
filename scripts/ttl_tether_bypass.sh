#!/usr/bin/env sh

os="`uname`"
case $os in
    Darwin) sysctl -w net.inet.ip.ttl=65;;
    Linux)  sysctl -w net.ipv4.ip_default_ttl=129;;
    *)      echo "IDK how on $os."
esac

