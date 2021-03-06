#!/bin/bash

set -e
set -u

git submodule init
git submodule update

command -v a2x >/dev/null 2>&1 || { echo "Missing command 'a2x'. Try 'brew install asciidoc docbook2X'." >&2; exit 1; }

export XML_CATALOG_FILES=/usr/local/etc/xml/catalog

a2x -d book -D . -f epub ./elasticsearch-definitive-guide/book.asciidoc -v

if hash ebook-convert 2>/dev/null; then
    ebook-convert book.epub book.mobi
else
    echo "Missing command 'ebook-convert', cannot convert to mobi. Try 'brew cask install calibre'."
fi
