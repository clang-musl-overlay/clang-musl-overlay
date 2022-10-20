#!/bin/sh
TMPPATH="$(mktemp -d lua-language-server.XXXX --tmpdir)"
exec /usr/libexec/lua-language-server/bin/lua-language-server -E /usr/libexec/lua-language-server/main.lua \
    --logpath="$TMPPATH/log" --metapath="$TMPPATH/meta" \
    "$@"
