## Simple utility script to convert and send your ebooks to your Kindle using Calibre's file conversion and SMTP features.

*<small>Running this saves you about 2 lines of code so probably not that useful but if it helps your fingers then it can't be bad</small>*

Requirements:
Docker (with the user added to docker group)
secret-tool for credentials encryption

Arguments are files to be sent and optionally "-l", accepts most of the common ebook formats and converts them to .epub, which then get converted by Amazon to their format (currently it's .kfx for newer Kindles i think, older models use .mobi)

The conversion part is there because Calibre manages more formats then Amazon on their side, so there is less chance of failure

Uses Google's SMTP server with SSL encryption by default

### Install

curl -s https://raw.githubusercontent.com/Dewaszmi/send-to-kindle-script/main/INSTALL.sh | bash

Make sure that $HOME/.local/bin is included in your path

### Usage

send-to-kindle [args] [files]

Only currently supported argument is "-l [language_code]" which changes the language metadata, useful when downloading books in a foreign language.
