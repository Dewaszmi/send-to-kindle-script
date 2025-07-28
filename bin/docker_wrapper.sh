#!/usr/bin/env bash

# wrapper script to run the calibre docker image

IMAGE_NAME="send-to-kindle"

# check if the Docker image exists
if ! docker image inspect "$IMAGE_NAME" &> /dev/null; then
    echo "Error: Docker image '$IMAGE_NAME' not found. Please run INSTALL.sh to build it."
    exit 1
fi

# retrieve credentials from GNOME Keyring
SENDER_MAIL=$(secret-tool lookup send-to-kindle sender_mail)
KINDLE_MAIL=$(secret-tool lookup send-to-kindle kindle_mail)
USERNAME=$(secret-tool lookup send-to-kindle username)
PASSWORD=$(secret-tool lookup send-to-kindle password)

if [[ -z "$SENDER_MAIL" || -z "$KINDLE_MAIL" || -z "$USERNAME" || -z "$PASSWORD" ]]; then
    echo "Error: Missing credentials. Please set them up using the INSTALL.sh script."
    exit 1
fi

# Check if the first argument (ebook file) is provided
if [[ -z "$1" ]]; then
    echo "Error: No ebook file provided. Usage: send-to-kindle <path-to-ebook>"
    exit 1
fi

# Get the absolute path of the ebook file
EBOOK_PATH=$(realpath "$1")
EBOOK_DIR=$(dirname "$EBOOK_PATH")

# Check if the ebook file exists
if [[ ! -f "$EBOOK_PATH" ]]; then
    echo "Error: File '$EBOOK_PATH' does not exist."
    exit 1
fi

# Run the Docker container with credentials and the ebook file
docker run --rm -v "$EBOOK_DIR:/ebooks" \
    -e SENDER_MAIL="$SENDER_MAIL" \
    -e KINDLE_MAIL="$KINDLE_MAIL" \
    -e USERNAME="$USERNAME" \
    -e PASSWORD="$PASSWORD" \
    "$IMAGE_NAME" "/ebooks/$(basename "$EBOOK_PATH")"