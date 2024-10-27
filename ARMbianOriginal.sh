#!/bin/bash
#  qemu-img resize -f raw Armbian_23.8.1_Rpi4b_jammy_current_6.1.50.img 8G
# -usb \
# -device usb-host,hostbus=001,hostaddr=002 \
qemu-system-aarch64 \
    -kernel vmlinuz \
    -initrd initrd.img \
    -dtb bcm2710-rpi-3-b.dtb \
    -serial stdio \
    -m 1G \
    -machine raspi3b \
    -cpu cortex-a72 \
    -device usb-mouse \
    -device usb-kbd \
    -smp cores=4 \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 \
    -device usb-net,netdev=net0 \
    -sd Armbian_24.8.1_Rpi4b_bookworm_current_6.6.45_minimal.img \
    -no-reboot \
    -append "root=/dev/mmcblk0p2 noresume rw" \
    -display sdl \
    -usb -device usb-kbd \
