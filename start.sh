#!/bin/sh

# BOOT=rhel-8.1-x86_64-dvd.iso
# BOOT=CentOS-Stream-9-latest-x86_64-dvd1.iso
# BOOT=debian-11.1.0-amd64-netinst.iso
BOOT=manjaro-gnome-21.1.6-211017-linux513.iso

qemu-system-x86_64 --enable-kvm \
-boot menu=on \
-m 4096 \
-vga virtio -display sdl \
-net nic,model=virtio -net user \
-rtc base=localtime,clock=host -smp sockets=1,cores=2,threads=1 -cpu host \
-drive file=/dev/sda,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native \
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x5,drive=drive-virtio-disk0,id=virtio-disk0 \
-usb -device usb-tablet \
-net nic,model=virtio -net user 
# -drive file=${BOOT},index=3,media=cdrom 

# -net user,smb=$HOME 