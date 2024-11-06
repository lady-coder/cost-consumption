#!/bin/bash

cd $path_cwd/lambda_function

chmod +x requirements.txt

FILE=requirements.txt

if [ -f "$FILE" ]; then
  echo "Installing dependencies for infra..."
  echo "From: requirement.txt file exists..."
  pip3 install -U --target . -r "$FILE"

else
  echo "Error: requirements.txt does not exist!"
fi


