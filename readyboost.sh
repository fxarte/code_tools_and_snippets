#!/bin/bash
## http://ubuntuforums.org/showthread.php?t=395435
if [ -z "$1" ]; then
  echo "Usage $0  [ad]. Make sure the target is the correct usb device partition, like /dev/sdb1"
  exit 1
fi

DEVICE='/dev/sdb1'
MOUNTED=false
INSWAP=false

## Assuming this message: dev/sdb1 on /media/felix/055B-50B0 type vfat (rw,nosuid,nodev,uid=1000,gid=1000,shortname=mixed,dmask=0077,utf8=1,showexec,flush,uhelper=udisks2)
p=(`mount | grep $DEVICE`)
if [ "${p[0]}" == "$DEVICE" ]; then
  MOUNT_POINT=${p[2]}
  MOUNTED=true
fi

if cat /proc/swaps | grep $DEVICE; then
  INSWAP=true
fi

#echo "mount pint is: $MOUNT_POINT"
#if $INSWAP ; then
#  echo "use as swap already"
#else
#  echo "NOT used in swap"
#fi
#exit 0


#DEVICE='/dev/sdb1'
#MOUNT_POINT='/media/felix/3057-60FC'

if [  "$1" ==  "a" ]; then
  if $INSWAP; then
    echo "device already used as swap"
    exit 0
  else
    if $MOUNTED; then
      sudo umount $MOUNT_POINT
    fi
    sudo mkswap $DEVICE
    sudo swapon -p 32767 $DEVICE
  fi
  cat /proc/swaps
  
  
elif [ "$1" == "d" ]; then
  sudo swapoff $DEVICE
  cat /proc/swaps
fi
