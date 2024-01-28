#!/bin/bash
#qemu-img resize -f raw Armbian_23.8.1_Rpi4b_jammy_current_6.1.50.img 4G
qemu-system-aarch64 \
    -kernel vmlinuz \
    -initrd initrd.img \
    -dtb bcm2710-rpi-3-b-plus.dtb \
    -serial stdio \
    -m 1G \
    -machine raspi3b \
    -cpu cortex-a72 \
    -device usb-mouse \
    -device usb-kbd \
    -smp 4 \
    -net nic -net user,hostfwd=tcp::2222-:22 \
    -sd Armbian_23.8.1_Rpi4b_jammy_current_6.1.50.img \
    -no-reboot \
    -append "root=/dev/mmcblk0p2 noresume rw" \
    -display sdl \
    -usb -device usb-kbd \
