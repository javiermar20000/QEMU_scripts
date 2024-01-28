#!/bin/bash
#   -device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/002/002 \
qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -M q35 \
    -cpu host \
    -smp cores=4,threads=2,sockets=1 \
    -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
    -global ICH9-LPC.disable_s3=1 -global ICH9-LPC.disable_s4=1 \
    -drive file=debian-12.1.0-amd64-netinst.iso,index=0,media=cdrom \
    -boot menu=on \
    -drive "if=pflash,format=raw,readonly=on,file=OVMF_CODE.fd" \
    -drive "if=pflash,format=raw,file=OVMF_VARS.fd" \
    -drive file=Debian12.qcow2,if=virtio,index=1,media=disk,aio=native,cache.direct=on,cache=unsafe \
    -display sdl,gl=on \
    -device virtio-vga-gl \
    -rtc base=localtime,clock=host \
    -usb -device virtio-keyboard-pci \
    -usb -device virtio-tablet-pci \
    -netdev user,id=network0,net=192.168.155.0/24,dhcpstart=192.168.155.9 \
    -device virtio-net-pci,netdev=network0,mac=52:54:00:12:34:56 \
    -nic bridge,br=red_interna1,model=virtio-net-pci,mac=52:54:00:29:10:12 \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 \
    -chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0 \
