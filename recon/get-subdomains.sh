#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <domain> <output_folder>"
  exit 1
fi

# Get the directory where the current script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Extract the domain and output file from the parameters
domain="$1"

# Remove the "https://" prefix if it's present
domain="${domain#https://}"

output_folder="$2"
output_file="$output_folder/$domain.txt"

# Create the directory if it doesn't exist already
mkdir $output_folder



# Command to run with the given domain and output file
chaos -d $domain | anew  $output_file

amass enum -passive -d $domain --config $script_dir/../../bugbounty-private/config/amass.cfg | anew $output_file


# Check the exit status of the command
if [ $? -eq 0 ]; then
  echo "Output saved to $output_file"
  grep -ve "\*\." $output_file > $output_file-tidy

  sh $script_dir/prepend-https.sh $output_file-tidy $output_file
 # rm $output_file-tidy
else
  echo "Command failed. Check the error message for details."
fi
