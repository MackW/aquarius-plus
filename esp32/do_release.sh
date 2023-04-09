#!/bin/bash
idf.py build

mkdir -p $1 $1/bootloader $1/partition_table
cp build/aquarius-plus.bin $1/
cp build/partition_table/partition-table.bin $1/partition_table/
cp build/bootloader/bootloader.bin $1/bootloader/
cp build/flash_args $1/
echo "esptool.py --chip esp32s2 -p COM3 write_flash `cat build/flash_args | tr '\n' ' '`" > $1/write.bat
unix2dos $1/write.bat
zip -rv $1.zip $1
rm -rf $1
