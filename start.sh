#!/bin/sh
# Starts the bot inside a Linux container (Pella, Railway, Render, Fly, a VPS...).
# - fonts: the bundled Noto fonts are installed into ~/.fonts so fontconfig picks up the emoji font.
# - data: the SQLite file lives in FRIENDTCG_DATA_DIR when set (mount a volume there), otherwise ./data.
set -e
cd "$(dirname "$0")"

if [ -f image/fonts/emoji.ttf ] && [ -n "$HOME" ] && [ -d "$HOME" ]; then
    mkdir -p "$HOME/.fonts"
    cp -f image/fonts/emoji.ttf "$HOME/.fonts/" 2>/dev/null || true
    command -v fc-cache >/dev/null 2>&1 && fc-cache -f >/dev/null 2>&1 || true
fi

mkdir -p "${FRIENDTCG_DATA_DIR:-./data}"
# A ZIP built on Windows loses the executable bit, so set it before starting the binary.
chmod +x ./FriendTCG.Bot 2>/dev/null || true
exec ./FriendTCG.Bot "$@"
