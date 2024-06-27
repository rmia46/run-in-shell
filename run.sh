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

# Compile and run the file based on the extension
case "$extension" in
    "cpp")
        if g++ -std=c++17 -Wall -Wextra -Wpedantic $filename -o $filename_no_extension $sfml_flag; then
            ./$filename_no_extension
        else
            echo "Compilation error."
        fi
        ;;
    "c")
        if gcc -Wall -Wextra -Wpedantic $filename -o $filename_no_extension; then
            ./$filename_no_extension
        else
            echo "Compilation error."
        fi
        ;;
    "py")
        python $filename
        ;;
    "lua")
        lua $filename
        ;;
    "js")
        node $filename
        ;;
    "java")
        if javac $filename; then
            # Find the compiled class name
            compiled_class=$(find . -name "*.class" -exec basename {} .class \; | head -n 1)
            java $compiled_class
        else
            echo "Compilation error."
        fi
        ;;
    *)
        echo "Unsupported file extension."
        exit 1
        ;;
esac
