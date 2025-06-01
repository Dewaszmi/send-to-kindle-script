## Simple utility script to convert and send your ebooks to your Kindle using Calibre's file conversion and SMTP features.

*<small>Running this saves you about 2 lines of code so probably not that useful but if it helps your fingers then it can't be bad</small>*

Requires [Calibre](https://calibre-ebook.com/download_linux)

Arguments are files to be sent and optionally "-l", accepts most of the common ebook formats and converts them to .epub, which then get converted by Amazon to their format (currently it's .kfx for newer Kindles i think, older models use .mobi)

The conversion part is there because Calibre manages more formats then Amazon on their side, so there is less chance of failure

Uses Google's SMTP server with SSL encryption by default

### Install

curl -s https://raw.githubusercontent.com/Dewaszmi/send-to-kindle-script/main/INSTALL.sh | bash

Then go to $HOME/.config/send-to-kindle and paste your SMTP credentials to the kindle_credentials.sh file

### Usage

send-to-kindle [args] [files]

Only currently supported argument is "-l [language_code]" which changes the language metadata, useful when downloading books in a foreign language.
