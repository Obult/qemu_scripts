#!/bin/sh

# BOOT=rhel-8.1-x86_64-dvd.iso
# BOOT=CentOS-Stream-9-latest-x86_64-dvd1.iso
# BOOT=debian-11.1.0-amd64-netinst.iso
BOOT=manjaro-gnome-21.1.6-211017-linux513.iso

qemu-system-x86_64 --enable-kvm \
-boot menu=on \
-m 4096 \
-cpu host \
-smp sockets=1,cores=2,threads=1 \
-rtc base=localtime,clock=host \
-drive file=/dev/sda,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native \
-device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0 \
-vga virtio \
-display sdl \
-nic user,model=virtio-net-pci \
-usb -device usb-tablet
# -drive file=${BOOT},index=3,media=cdrom 


# BOOT=				Place your iso images after the "="

# --enable-kvm		Enable kvm acceleration.
# -boot menu=on		Enable boot menu, used for booting from a live CD (picking the CD to boot from).
# -m 4096			Amount of ram your VM has 4096 == 4GB, could also use -m 4G

# -cpu host								Emulate same cpu (architecture?) as host system.
# -smp sockets=1,cores=2,threads=1		Practically how many cores you want to "give" to the VM, threads = per core.
# -rtc base=localtime,clock=host		Use host clock in VM and start from host localtime. (so time is synced with host)

# -drive file=/dev/sda,format=raw,if=none,id=drive-virtio-disk0,cache=none,aio=native \
# -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x4,drive=drive-virtio-disk0,id=virtio-disk0
# 												   ^
# This is how I add a physical drive to my system. Be aware that the 4 I pointed out in the second line
# is the virtual pcie slot it uses, so if you encounter errors like that the pcie slot is already in use. (error msg below)
# You could increase the slot it should use untill you find one available. Emulated devices use these slots aswell.
# 
# error msg:		PCI: slot 3 function 0 not available for virtio-blk-pci, in use by virtio-net-pci

# -vga virtio		Emulate a gpu with virtio. Other options would be none (gpu passthrough), qxl and others
# -display sdl		Virtual display type other option would be gtk for example.

# -nic user,model=virtio-net-pci		This sets the internet connection where "user" is the host side (could also be referred to as tap)
# 										and the model= defines the emulated cards model for available models run qemu with -nic model=help
# 										model could also be left out for simple configuration where model does not matter. (-nic tap)
# 										This is what I used before and has likely caused me input lag:	-net nic,model=virtio -net user

# -usb -device usb-tablet				I am not sure on this one yet.
# 										It makes it so that your mouse in the VM is in the same spot as your real mouse.
# 										I used to think it caused the input lag but need to experiment further with this option.

# -drive file=${BOOT},index=3,media=cdrom 	turn this on (and add a "\" on the line prior) to add the selected iso file as virtual CD