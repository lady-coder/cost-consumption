#!/bin/bash

cd $path_cwd/lambda_function

chmod +x requirements.txt

FILE=requirements.txt

if [ -f "$FILE" ]; then
  echo "Installing dependencies..."
  echo "From: requirement.txt file exists..."
  pip3 install --target ./package -r "$FILE"

else
  echo "Error: requirements.txt does not exist!"
fi
