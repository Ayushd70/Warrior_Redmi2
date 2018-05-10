#!/sbin/sh

# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=rifle007 @xda
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
cp -rpf $patch/init.d/99trim_partitions /system/bin/zpxtrim
cp -rpf $patch/init.d /system/etc
cp -rpf $patch/cron.d /system/etc
chmod -R 755 /system/etc/init.d
chmod -R 755 /system/etc/cron.d
chmod -R 755 /system/bin/zpxtrim
#rm /system/etc/init.d/99zpx_zram
#mv /system/bin/vm_bms /system/bin/vm_bms.bak
#chmod 644 $ramdisk/sbin/media_profiles.xml

## AnyKernel install
find_boot;
dump_boot;

# begin ramdisk changes

#change minfreq buildprop
sed -i '/ro.min_freq_0/d' /system/build.prop
sed -i '/^$/d' /system/build.prop
echo "ro.min_freq_0=400000" >> /system/build.prop

replace_line fstab.qcom "/dev/block/zram0" "/dev/block/zram0                              none        swap            defaults             zramsize=1073741824,notrim";
replace_line init.qcom.power.rc "write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq" "    write /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq 400000";
replace_line init.qcom.power.rc "    start perfd" "    stop perfd"
replace_line init.qcom.power.rc "setprop sys.io.scheduler" "    setprop sys.io.scheduler \"cfq"\";

## end ramdisk changes

write_boot;

## end install
