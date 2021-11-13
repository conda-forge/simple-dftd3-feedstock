#!/usr/bin/env bash
set -ex

meson_options=(
   ${MESON_ARGS:---prefix=${PREFIX} --libdir=lib}
   "--buildtype=release"
   "--default-library=shared"
   "--warnlevel=0"
   "-Dblas=netlib"
)

meson setup _build "${meson_options[@]}"
meson compile -C _build
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-0}" == 1 ]]; then
  meson test -C _build --print-errorlogs --num-processes 1 -t 5
fi
meson install -C _build
