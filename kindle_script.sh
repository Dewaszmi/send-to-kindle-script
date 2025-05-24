#!/usr/bin/bash

# get smtp credentials from another file (or env variables)
source ./kindle_credentials.sh

for arg in "$@"; do
    if [[ -f "$arg" ]]; then
        ext="${arg##*.}"
        if [[ "$ext" != "epub" ]]; then
            ebook-convert "$arg" "${arg%.*}.epub"
        fi

        # add books to array
        books+=("${arg%.*}.epub")
        # add basename to title array
        titles+=($(basename "$arg"))
    else
        echo "No file $arg."
    fi
done

# uses gmail server with SSL by default
relay="smtp.gmail.com"
port="465"
encryption="SSL"

clb_sender_mail="$sender_mail"
clb_kindle_mail="$kindle_mail"
clb_username="$username"
clb_password="$password"

# include attachments
attachments=""
for book in "${books[@]}"; do
    attachments+=" --attachment \"$book\""
done

cmd="calibre-smtp \
    --relay \"$relay\" --port \"$port\" --encryption \"$encryption\" \
    --username \"$clb_username\" --password \"$clb_password\" \
    $attachments --subject \"Send to Kindle: ${titles[*]}\" \
    \"$clb_sender_mail\" \"$clb_kindle_mail\" \"Book files in attachments, happy reading :)\""

echo "Sending ${#books[@]} book(s) to Kindle: ${titles[*]} via following command:"
echo "$cmd"
eval "$cmd"

if [ $? -eq 0 ]; then
    echo "Books sent successfully."
else
    echo "Failed to send books."
fi

for book in "${books[@]}"; do
    rm "$book"
done