#!/usr/bin/env bash
set -ex

meson_options=(
   ${MESON_ARGS:--prefix=${PREFIX} --libdir=lib}
   "--buildtype=release"
   "--default-library=shared"
   "--warnlevel=0"
   "-Dblas=netlib"
)

mkdir -p _build
pushd _build

meson setup "${meson_options[@]}" ..
meson test --print-errorlogs --num-processes 1 -t 5
meson install
