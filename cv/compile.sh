#!/bin/bash

# CV Compilation Script
FILE="main"

# Check if latexmk is installed
if ! command -v latexmk &> /dev/null
then
    echo "Error: latexmk is not installed. Please install a TeX distribution."
    exit 1
fi

echo "--- Building CV ---"

# Compile using latexmk
latexmk -xelatex -interaction=nonstopmode -silent "$FILE.tex"

if [ $? -eq 0 ]; then
    if command -v pdftoppm &> /dev/null
    then
        rm -f "${FILE}_preview-"*.png
        pdftoppm -png -r 180 "$FILE.pdf" "${FILE}_preview"
        echo "PNG previews generated: ${FILE}_preview-*.png"
    else
        echo "Warning: pdftoppm is not installed; skipped PNG preview generation."
    fi

    echo "------------------------------------------"
    echo "Success! PDF generated: $FILE.pdf"
    echo "------------------------------------------"
else
    echo "------------------------------------------"
    echo "Error: Compilation failed."
    echo "------------------------------------------"
    exit 1
fi
