#!/bin/bash -eux

if [ -t 0 ]; then
  echo 'USAGE: $0 <<< extracted-image-directory'
  exit 2
fi

# This is intentional -- it is designed to be called in a pipe
extracted_image_path=$(cat)

converted_raw_path=$(mktemp -d)

# The size of the VHD for Azure must be a whole number in megabytes.
qemu-img convert -O vpc -o subformat=fixed $extracted_image_path $converted_raw_path/root.vhd

echo $converted_raw_path/root.vhd
