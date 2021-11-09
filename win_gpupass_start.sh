#!/bin/sh

# WINIMG=~/vm/Win10_1803_English_x64.iso
# VIRTIMG=~/vm/virtio-win-0.1.149.iso
# qemu-system-x86_64 --enable-kvm -drive driver=raw,file=~/vm/win10.img,if=virtio -m 6144 \
# -net nic,model=virtio -net user -cdrom ${WINIMG} \
# -drive file=${VIRTIMG},index=3,media=cdrom \
# -rtc base=localtime,clock=host -smp cores=4,threads=8 \
# -usb -device usb-tablet \
# -net user,smb=$HOME


WINIMG=Win10_20H2_v2_English_x64.iso
VIRTIMG=virtio-win-0.1.190.iso
qemu-system-x86_64 \
	-enable-kvm \
	-cpu host \
	-drive driver=raw,file=strix_win10.img,if=virtio \
	-m 12G \
	-smp sockets=1,cores=4,threads=1 \
	-net nic,model=virtio -net user \
	-rtc base=localtime,clock=host \
	-device vfio-pci,host=02:00.0 \
	-device vfio-pci,host=02:00.1 \
	-usb -device usb-host,hostbus=1,hostport=3 \
	-device usb-host,hostbus=1,hostport=4 \
	-display none \
	-daemonize
	# -cdrom ${WINIMG} \
	# -drive file=${VIRTIMG},index=3,media=cdrom \
	# -usb -device usb-tablet \
	# -net user,smb=$HOME \
	# -vga qxl

