#!/bin/bash

execute_and_check() {
    "$@"
    if [ $? -ne 0 ]; then
        echo "Command failed: $@"
        exit 1
    fi
}

base_dir=$(pwd)

# Clean and build binaries
execute_and_check pio run --target clean
execute_and_check pio run

output_dir=$base_dir/out
platformio_build_dir=$base_dir/.pio/build/"esp32dev"
rm -rf $output_dir
mkdir -p $output_dir

cp $platformio_build_dir/bootloader.bin $output_dir/bootloader.bin
cp $platformio_build_dir/partitions.bin $output_dir/partitions.bin
cp $platformio_build_dir/firmware.bin $output_dir/firmware.bin
cp $platformio_build_dir/spiffs.bin $output_dir/spiffs.bin
cp ~/.platformio/packages/framework-arduinoespressif32/tools/partitions/boot_app0.bin $output_dir/boot_app0.bin

# Zip the folder
zip_cmd="zip $output_dir/biometric-esp32-group-c.zip"
[ -f "$output_dir/bootloader.bin" ] && zip_cmd="$zip_cmd $output_dir/bootloader.bin"
[ -f "$output_dir/partitions.bin" ] && zip_cmd="$zip_cmd $output_dir/partitions.bin"
[ -f "$output_dir/firmware.bin" ] && zip_cmd="$zip_cmd $output_dir/firmware.bin"
[ -f "$output_dir/spiffs.bin" ] && zip_cmd="$zip_cmd $output_dir/spiffs.bin"
[ -f "$output_dir/boot_app0.bin" ] && zip_cmd="$zip_cmd $output_dir/boot_app0.bin"
eval $zip_cmd
