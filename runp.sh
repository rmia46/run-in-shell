#!/bin/bash

# Check if file name argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <file> [sfml]"
    exit 1
fi

# Get the file name from the command-line argument
filename="$1"

# Get the file extension
extension="${filename##*.}"

# Remove the extension from the file name
filename_no_extension="${filename%.*}"

# Check if SFML flag is provided
if [ "$2" == "sfml" ]; then
    sfml_flag="-lsfml-graphics -lsfml-window -lsfml-system"
else
    sfml_flag=""
fi

# Create output.txt if it doesn't exist
touch output.txt

# Compile and run the file based on the extension
case "$extension" in
    "cpp")
        if g++ -std=c++17 -Wall -Wextra -Wpedantic $filename -o $filename_no_extension $sfml_flag; then
            ./$filename_no_extension < input.txt > output.txt
        else
            echo "Compilation error."
        fi
        ;;
    "c")
        if gcc -Wall -Wextra -Wpedantic $filename -o $filename_no_extension; then
            ./$filename_no_extension < input.txt > output.txt
        else
            echo "Compilation error."
        fi
        ;;
    "py")
        python $filename < input.txt > output.txt
        ;;
    "lua")
        lua $filename < input.txt > output.txt
        ;;
    "js")
        node $filename < input.txt > output.txt
        ;;
    *)
        echo "Unsupported file"
        exit 1
        ;;
esac
