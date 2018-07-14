#!/sbin/sh

# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=Zero ProjectX
do.devicecheck=0
do.initd=1
do.modules=0
do.cleanup=1
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=

# shell variables
#leave blank for automatic search boot block
#block=
#is_slot_device=0;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## AnyKernel permissions
# set permissions for included ramdisk files
mount /system;
mount -o remount,rw /system;
chmod -R 755 $ramdisk

## AnyKernel install
find_boot;
dump_boot;

# begin ramdisk changes

## end ramdisk changes

write_boot;

## end install
