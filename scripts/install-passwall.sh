#!/bin/sh
set -eu

./scripts/feeds update passwall_packages passwall_luci
./scripts/feeds install -p passwall_packages -a
./scripts/feeds install -p passwall_luci -a
