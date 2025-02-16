#!/bin/bash

# This script will:
# - Ensure the "build" folder exists or create it, then navigate into it
# - Configure the project using CMake with Ninja and enable the generation of compile commands
# - Compile the project
# - Run the compiled application
# - ask you if you wanna save the source code and executable in a "prevBuilds" folder for versioning

set -e
mkdir -p build && cd build
cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
ninja

# Run the compiled application
./ftxui_app

# Ask if the user wants to save a sample of the source code and executable
read -p "Do you want to save this version (source and executable) in 'prevBuilds'? (y/n): " save_choice
if [[ "$save_choice" == "y" || "$save_choice" == "Y" ]]; then

	read -p "Enter a custom name for this version: " custom_name

	# Generaate the date and then format it 
	date_display=$(date +"%Y/%m/%d")
	date_part=$(date +"%Y_%m_%d")

	save_folder="../prevBuilds/${custom_name}_${date_part}"
	mkdir -p "$save_folder"

	echo "version will be saved as '$custom_name' on date '$date_display' in folder '$save_folder'."

  cp ./ftxui_app "$save_folder"
  cp ../src/* "$save_folder"

  echo "Version saved in '$save_folder'."
else
  echo "Version not saved."
fi

exit 
