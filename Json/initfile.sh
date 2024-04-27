#!/bin/bash

# Function to check if a folder exists, if not, create it
create_folder() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

# Main function
main() {
    folders=("backup" "include" "src")

    # Create folders
    for folder in "${folders[@]}"; do
        create_folder "$folder"
    done

    # Create Makefile
    if [ ! -f "Makefile" ]; then
        touch Makefile
    else
        echo "Makefile already exists."
    fi

    # Create CMakeLists.txt
    if [ ! -f "CMakeLists.txt" ]; then
        touch CMakeLists.txt
    else
        echo "CMakeLists.txt already exists."
    fi

    echo "Folders and files created successfully."

    # Prompt user to delete the script file
    read -p "Do you want to delete this script file? (y/n): " choice
    case "$choice" in
        y|Y ) rm "$0";;
        n|N ) echo "Script file not deleted.";;
        * ) echo "Invalid choice. Script file not deleted.";;
    esac
}

# Execute the main function
main

