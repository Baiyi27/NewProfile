#!/bin/bash

# Prompt for the project name
read -p "Enter the name of the project: " projectName

# Function to create directories and check for success
create_dir() {
  for dir in "$@"; do
    mkdir -p "$dir"
    if [ $? -ne 0 ]; then
      echo "Failed to create directory: $dir"
      exit 1
    fi
  done
}

# Function to create files and check for success
create_file() {
  for file in "$@"; do
    touch "$file"
    if [ $? -ne 0 ]; then
      echo "Failed to create file: $file"
      exit 1
    fi
  done
}

# Directories to create
dirs=(
  "$projectName/cmake"
  "$projectName/cmake/deps"
  "$projectName/cmake/Moudels"
  "$projectName/src"
  "$projectName/src/include"
  "$projectName/src//include/module"
  "$projectName/apps"
  "$projectName/tests"
  "$projectName/docs"
  "$projectName/3rdparty"
  "$projectName/scripts"
)

# Files to create
files=(
  "$projectName/README.md"
  "$projectName/CMakeLists.txt"
  "$projectName/CMakePresets.json"
  "$projectName/cmake/Moudels/module.cmake"
  "$projectName/src/include/module/lib.hh"
  "$projectName/src/include/module/lib.hpp"
  "$projectName/src/CMakeLists.txt"
  "$projectName/src/lib.cc"
  "$projectName/apps/CMakeLists.txt"
  "$projectName/apps/app.cc"
  "$projectName/tests/CMakeLists.txt"
  "$projectName/tests/testlib.cc"
  "$projectName/docs/CMakeLists.txt"
  "$projectName/scripts/helper.py"
)

# Create the directories
create_dir "${dirs[@]}"

# Create the files
create_file "${files[@]}"

cp $GIT_LOCAL_REPO/NewProfile/GitEcosystem/.gitignore $projectName

echo "Project structure for '$projectName' created successfully."

