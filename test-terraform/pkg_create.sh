
#!/bin/bash

echo "Executing pkg_create.sh..."

cd $path_cwd
dir_name=lambda_dist_pkg/
mkdir $dir_name

# Create and activate virtual environment...
#virtualenv -p $runtime env_$function_name
#source $path_cwd/env_$function_name/bin/activate

# Installing python dependencies...
FILE=$path_cwd/lambda_function/requirements.txt

if [ -f "$FILE" ]; then
  echo "Installing dependencies..."
  echo "From: requirement.txt file exists..."
  pip3 install -r "$FILE"

else
  echo "Error: requirements.txt does not exist!"
fi

# Deactivate virtual environment...
#deactivate

# Create deployment package...
echo "Creating deployment package..."
cd env_$function_name/lib/$runtime/site-packages/
cp -r . $path_cwd/$dir_name
#cp -r $path_cwd/lambda_function/ $path_cwd/$dir_name

# Removing virtual environment folder...
#echo "Removing virtual environment folder..."
#rm -rf $path_cwd/env_$function_name

echo "Finished script execution!"