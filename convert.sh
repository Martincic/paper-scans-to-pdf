#!/bin/bash

# Rotate all images upright
echo $(date +%H:%M:%S)
echo -e "\e[32m\e[1mRotating images\e[0m"

counter=0

for filename in ./data/*; do
	convert ./data/*.jpg -auto-orient -rotate "90>" rotate/${counter}.jpg
	counter=$((counter+1))
	echo "${counter}"
done

echo 'exiting'
exit

echo "Rotating *.JPGs"
convert ./data/*.jpg -auto-orient -rotate "90>" rotate/outputA.jpg

echo $(date +%H:%M:%S)
echo "Rotating *.JPEGs"
convert ./data/*.jpeg -auto-orient -rotate "90>" rotate/outputC.jpeg

echo $(date +%H:%M:%S)
echo "Rotating *.PNGs"
convert ./data/*.png -auto-orient -rotate "90>" rotate/outputB.png


# Convert images to grayscale, fix contrast and shaddows
echo -e "\e[32m\e[1mCleaning up colors and contrast\e[0m"
echo $(date +%H:%M:%S)
echo "Cleaning jpgs.."
convert rotate/*.jpg -colorspace Gray -contrast-stretch 0x10% output/outA.jpg

echo $(date +%H:%M:%S)
echo "Cleaning jpegs.."
convert rotate/*.jpeg -colorspace Gray -contrast-stretch 0x3% -normalize output/outB.jpeg

echo $(date +%H:%M:%S)
echo "Cleaning pngs.."
convert rotate/*.png -colorspace Gray -contrast-stretch 0x1% -normalize output/outC.png


# Images to PDF file
echo -e "\e[32m\e[1mDone! Compiling PDF output...\e[0m"
echo $(date +%H:%M:%S)
img2pdf output/* -o compiled.pdf

echo "Finished! Opening compiled.pdf..."
open compiled.pdf

