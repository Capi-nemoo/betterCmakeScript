#!/bin/bash

# This script will:
# - Ensure the "build" folder exists or create it, then go into it
# - Configure the project using CMake with Ninja and enable the generation of compile commands
# - Compile the project
# - Run the compiled application

set -e
mkdir -p build && cd build
cmake -GNinja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
ninja
./ftxui_app

