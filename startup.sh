#!/bin/bash

mkdir -p /data/dists/termux/sc/main/binary-aarch64/
exec /usr/bin/supervisord -n
