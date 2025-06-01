#!/usr/bin/env bash

SCRIPT_SRC="./bin/send-to-kindle"
INSTALL_DIR="$HOME/.local/bin"
TARGET="$INSTALL_DIR/send-to-kindle"

CRED_SRC="./bin/kindle_credentials.sh"
CRED_DIR="$HOME/.config/send-to-kindle"
CRED_TARGET="$CRED_DIR/kindle_credentials.sh"

if [[ ! -f "$SCRIPT_SRC" ]]; then
    echo "Error: $SCRIPT_SRC not found."
    exit 1
fi

mkdir -p "$INSTALL_DIR"
cp "$SCRIPT_SRC" "$TARGET"
chmod +x "$TARGET"

echo "Copied send-to-kindle to $TARGET"

if [[ -f "$CRED_SRC" ]]; then
    mkdir -p "$CRED_DIR"
    if [[ -f "$CRED_TARGET" ]]; then
        echo "$CRED_TARGET already exists, not overwriting."
    else
        cp "$CRED_SRC" "$CRED_TARGET"
        echo "Copied kindle_credentials.sh to $CRED_TARGET"
    fi
else
    echo "Warning: $CRED_SRC not found, skipping credentials copy."
fi

echo ""
echo "Make sure the script is added to your PATH:"
echo "export PATH=\"\$HOME/.local/bin:\$PATH\""
echo ""
echo "Remember to edit/check your credentials in:"
echo "$CRED_TARGET"
