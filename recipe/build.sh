#!/usr/bin/env bash
set -ex

meson_options=(
   ${MESON_ARGS:--prefix=${PREFIX} --libdir=lib}
   "--buildtype=release"
   "--default-library=shared"
   "--warnlevel=0"
   "-Dblas=netlib"
   ".."
)

mkdir -p _build
pushd _build

if [[ "$(uname)" = Darwin ]]; then
    # Hack around issue, see contents of fake-bin/cc1 for an explanation
    PATH=${PATH}:${RECIPE_DIR}/fake-bin meson "${meson_options[@]}"
else
    meson "${meson_options[@]}"
fi

meson test --print-errorlogs --num-processes 1 -t 5
meson install
