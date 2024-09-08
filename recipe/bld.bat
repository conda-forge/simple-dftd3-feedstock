@echo on
setlocal enabledelayedexpansion

mkdir builddir

set "MESON_RSP_THRESHOLD=320000"
set PKG_CONFIG_PATH=%PREFIX%\lib\pkgconfig

meson setup _build %MESON_ARGS%
if %ERRORLEVEL% neq 0 exit 1

meson compile -C _build
if %ERRORLEVEL% neq 0 exit 1

meson test -C _build --no-rebuild --print-errorlogs
if %ERRORLEVEL% neq 0 exit 1

meson install -C _build --no-rebuild
if %ERRORLEVEL% neq 0 exit 1
