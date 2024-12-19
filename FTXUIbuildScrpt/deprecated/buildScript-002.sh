#!/bin/bash

# This script will:
# - Ensure the "build" folder exists or create it, then navigate into it
# - Configure the project using CMake with Ninja and enable the generation of compile commands
# - Compile the project
# - Run the compiled application
# - ask you if you wanna save the source code and executable in a "pastvers" folder for versioning

set -e
mkdir -p build && cd build
cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
ninja

# Run the compiled application
./ftxui_app

# Ask if the user wants to save a sample of the source code and executable
read -p "Do you want to save this version (source and executable) in 'pastvers'? (y/n): " save_choice
if [[ "$save_choice" == "y" || "$save_choice" == "Y" ]]; then
  # Create the "pastvers" folder if it doesn't exist
  mkdir -p ../pastvers

  # Define a unique folder name based on the current date and time
  timestamp=$(date +"%Y%m%d_%H%M%S")
  save_folder="../pastvers/version_$timestamp"
  mkdir -p "$save_folder"

  # Copy the executable and source files to the new folder
  cp ./ftxui_app "$save_folder"
  cp -r ../* "$save_folder"

  echo "Version saved in '$save_folder'."
else
  echo "Version not saved."
fi

