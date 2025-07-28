#!/usr/bin/env bash

# Check if credentials are already saved in GNOME Keyring
if command -v secret-tool &> /dev/null; then
    SENDER_MAIL=$(secret-tool lookup send-to-kindle sender_mail)
    KINDLE_MAIL=$(secret-tool lookup send-to-kindle kindle_mail)
    USERNAME=$(secret-tool lookup send-to-kindle username)
    PASSWORD=$(secret-tool lookup send-to-kindle password)

    if [[ -z "$SENDER_MAIL" || -z "$KINDLE_MAIL" || -z "$USERNAME" || -z "$PASSWORD" ]]; then
        echo "Credentials not found in GNOME Keyring. Please enter them now."

        # Prompt for user credentials to store
        read -p "Enter your sender email: " sender_mail
        read -p "Enter your Kindle email: " kindle_mail
        read -p "Enter your email username: " username
        read -sp "Enter your email password: " password
        echo ""

        # Save credentials to GNOME Keyring
        secret-tool store --label="send-to-kindle sender email" send-to-kindle sender_mail <<< "$sender_mail"
        secret-tool store --label="send-to-kindle kindle email" send-to-kindle kindle_mail <<< "$kindle_mail"
        secret-tool store --label="send-to-kindle username" send-to-kindle username <<< "$username"
        secret-tool store --label="send-to-kindle password" send-to-kindle password <<< "$password"
        echo "Credentials saved securely in GNOME Keyring."
    else
        echo "Credentials already exist in GNOME Keyring. Skipping credential setup."
    fi
else
    echo "Error: GNOME Keyring (secret-tool) is not installed. Please install it or provide credentials manually."
    exit 1
fi

# create the wrapper script
WRAPPER_SCRIPT="$HOME/.local/bin/send-to-kindle"
mkdir -p "$HOME/.local/bin"

cat > "$WRAPPER_SCRIPT" << EOF
"$(pwd)/bin/docker_wrapper.sh" "\$@"
EOF

chmod +x "$WRAPPER_SCRIPT"

# build the docker image
if docker build -t send-to-kindle .; then
    echo "Docker image 'send-to-kindle' built successfully."
else
    echo "Failed to build the Docker image."
    exit 1
fi
