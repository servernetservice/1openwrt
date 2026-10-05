#!/bin/sh
set -eu

make defconfig
make download -j"$(nproc)"
make -j"$(nproc)" V=s
