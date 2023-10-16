#!/bin/bash

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 input_file output_file"
    exit 1
fi

input_file="$1"
output_file="$2"

while IFS= read -r line; do
    echo "https://$line" >> "$output_file"
done < "$input_file"

echo "Done! Modified content written to $output_file."
