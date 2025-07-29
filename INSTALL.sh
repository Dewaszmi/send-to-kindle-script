#!/usr/bin/env bash

# dependency check
if ! command -v calibre &> /dev/null; then
    echo "Missing Calibre installation."
    exit 1
fi

if ! command -v secret-tool &> /dev/null; then
    echo "Missing secret-tool installation."
    exit 1
fi

# check if credentials are already saved in gnome keyring
SENDER_MAIL=$(secret-tool lookup send-to-kindle sender_mail)
KINDLE_MAIL=$(secret-tool lookup send-to-kindle kindle_mail)
USERNAME=$(secret-tool lookup send-to-kindle username)
PASSWORD=$(secret-tool lookup send-to-kindle password)

if [[ -z "$SENDER_MAIL" || -z "$KINDLE_MAIL" || -z "$USERNAME" || -z "$PASSWORD" ]]; then
    echo "Credentials not found in GNOME keyring, please enter them now."

    read -p "Enter your sender email: " sender_mail
    read -p "Enter your Kindle email: " kindle_mail
    read -p "Enter your email username: " username
    read -sp "Enter your email password: " password
    echo ""

    secret-tool store --label="send-to-kindle sender email" send-to-kindle sender_mail <<< "$sender_mail"
    secret-tool store --label="send-to-kindle kindle email" send-to-kindle kindle_mail <<< "$kindle_mail"
    secret-tool store --label="send-to-kindle username" send-to-kindle username <<< "$username"
    secret-tool store --label="send-to-kindle password" send-to-kindle password <<< "$password"
    echo "Credentials saved in GNOME Keyring."
else
    echo "Credentials already exist in GNOME Keyring. Skipping credential setup."
fi

mkdir -p "$HOME/.local/bin"
cp "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin/send-to-kindle" "$HOME/.local/bin"
chmod +x "$HOME/.local/bin"

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo "$HOME/.local/bin not included in PATH, please update accordingly"
fi

echo "Installation succesfull."