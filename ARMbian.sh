#!/bin/bash
#qemu-img resize -f raw Armbian_23.8.1_Rpi4b_jammy_current_6.1.50.img 4G
qemu-system-aarch64 \
    -kernel vmlinuz \
    -initrd initrd.img \
    -m 2G \
    -M virt \
    -cpu cortex-a72 \
    -smp 4 \
    -drive if=none,file=Armbian_23.8.1_Rpi4b_jammy_current_6.1.50.img \
    -no-reboot \
    -append "console=ttyAMA0 root=/dev/mmcblk0p2 noresume rw" \
    -nographic \
