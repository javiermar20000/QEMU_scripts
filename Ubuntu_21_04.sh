#!/bin/bash
#   -device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/002/002 \
qemu-system-x86_64 \
    -enable-kvm \
    -m 2G \
    -M q35 \
    -cpu host \
    -smp cores=2,threads=4,sockets=1 \
    -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
    -global ICH9-LPC.disable_s3=1 -global ICH9-LPC.disable_s4=1 \
    -boot menu=on \
    -drive file=Ubuntu21.04.qcow2,if=virtio,index=0,media=disk,aio=native,cache.direct=on,cache=unsafe \
    -display sdl,gl=on \
    -device virtio-vga-gl \
    -rtc base=localtime,clock=host \
    -usb -device virtio-keyboard-pci \
    -usb -device virtio-tablet-pci \
    -device virtio-net-pci,netdev=net0 \
    -netdev user,id=net0,hostfwd=tcp::5555-:22 \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 \
    -chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0 \
