### Simple bash script utilising Calibre's file conversion and SMTP utilities to automatically convert your ebooks to .epub and send them to your Kindle via SMTP server.

*<small>Running this saves you about 2 lines of code so probably not that useful but if it helps your fingers then it can't be bad</small>*

Requires [Calibre](https://calibre-ebook.com/download_linux)

Arguments are files to be sent, accepts most of the common ebook formats and converts them to .epub, which then get converted by Amazon to their format (currently it's .kfx for newer Kindles i think, older models use .mobi)

The conversion part is there because Calibre manages more formats then Amazon on their side, so there is less chance of failure

Uses Google's SMTP server with SSL encryption by default

**Remember to paste your credentials to kindle_credentials.sh!**