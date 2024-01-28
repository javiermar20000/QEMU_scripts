#-usb -device usb-kbd -usb -device usb-tablet \
#   -usb -device virtio-keyboard-pci \
#   -usb -device virtio-tablet-pci \
#   -device qemu-xhci,id=xhci -device usb-host,hostdevice=/dev/bus/usb/002/002 \
#para tpm usar comando:
#swtpm socket --tpmstate dir=/home/javiermar2000/Descargas/windows\ 11/ --ctrl type=unixio,path=//home/javiermar2000/Descargas/windows\ 11/swtpm-sock --tpm2 &
#!/bin/bash

qemu-system-x86_64 \
    -enable-kvm \
    -m 4G \
    -M q35 \
    -cpu host \
    -smp cores=2,threads=4,sockets=1 \
    -device ich9-intel-hda,id=sound0,bus=pcie.0,addr=0x1b -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0 \
    -global ICH9-LPC.disable_s3=1 -global ICH9-LPC.disable_s4=1 \
    -drive file=Win8.1_Spanish_x64.iso,index=0,media=cdrom \
    -drive file=virtio-win-0.1.229.iso,index=1,media=cdrom \
    -boot menu=on \
    -drive "if=pflash,format=raw,readonly=on,file=OVMF_CODE.fd" \
    -drive "if=pflash,format=raw,file=OVMF_VARS.fd" \
    -drive file=win8.qcow2,if=virtio,index=2,media=disk,aio=native,cache.direct=on,cache=unsafe \
    -display sdl,gl=on \
    -device virtio-vga-gl \
    -rtc base=localtime,clock=host \
    -usb -device virtio-keyboard-pci \
    -usb -device usb-tablet \
    -netdev user,hostfwd=tcp::3389-:3389,id=network0,net=192.168.155.0/24,dhcpstart=192.168.155.9 \
    -device virtio-net-pci,netdev=network0,mac=52:54:00:18:34:56 \
    -nic bridge,br=red_interna1,model=virtio-net-pci,mac=52:54:00:12:22:58 \
    -object rng-random,id=rng0,filename=/dev/urandom \
    -device virtio-rng-pci,rng=rng0 \
    -chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on \
    -device virtio-serial-pci \
    -device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0 \
