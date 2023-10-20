#!/bin/bash

# Create or clean working directories
echo $(date +%H:%M:%S)
echo "Creating/cleaning work directories"

rm -rf output
rm -rf rotate

mkdir output
mkdir rotate

# Rotate all images upright
echo -e "\e[32m\e[1mRotating images\e[0m"
counter=0

for filename in ./data/*; do
	extension="${filename##*.}"
	output="rotate/${counter}.${extension}"

	echo $(date +%H:%M:%S)
	echo "Converting ${filename}"
	echo "Output: ${output}\n\n"

	convert "${filename}" -auto-orient -rotate "90>" $output
	counter=$((counter + 1))
done


# Convert images to grayscale, fix contrast and shaddows
echo -e "\e[32m\e[1mCleaning up colors and contrast\e[0m"
echo $(date +%H:%M:%S)
counter=0
for filename in ./data/*; do
        extension="${filename##*.}"
        output="output/${counter}.${extension}"

	echo $(date +%H:%M:%S)
	echo "Converting ${filename}"
        echo "Output: ${output}\n\n"

	convert "${filename}" -colorspace Gray -contrast-stretch 0x10% $output
        counter=$((counter + 1))
done

# Images to PDF file
echo -e "\e[32m\e[1mDone! Compiling PDF output...\e[0m"
echo $(date +%H:%M:%S)
img2pdf output/* -o compiled.pdf

echo "Finished! Opening compiled.pdf..."
open compiled.pdf

