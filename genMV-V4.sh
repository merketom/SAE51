#!/bin/bash

arg1=$1
arg2=$2
ram=4096
dd=65536

if [ "$arg1" = "L" ]; then
    vboxmanage list vms

elif [ "$arg1" = "N" ]; then
    if vboxmanage list vms | grep -q "$arg2"; then
        echo "La VM $arg2 existe déjà."
        exit
    fi
    vboxmanage createvm --name="$arg2" --ostype="Debian_64" --register
    vboxmanage modifyvm "$arg2" --memory "$ram" --cpus 2 --vram 64

    vboxmanage createmedium disk --filename "$HOME/VirtualBox VMs/$arg2/$arg2.vdi" --size "$dd" --format VDI
    vboxmanage storagectl "$arg2" --name "SATA Controller" --add sata --controller IntelAhci
    vboxmanage storageattach "$arg2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$arg2/$arg2.vdi"
    virtualbox

elif [ "$arg1" = "S" ]; then
    vboxmanage unregistervm "$arg2" --delete-all
    virtualbox

elif [ "$arg1" = "D" ]; then
    if [ $(vboxmanage list vms | grep "$arg2" | wc -l) = 0 ]; then
        echo "La VM $arg2 n'existe pas."
        exit
    fi
    vboxmanage startvm $arg2

elif [ "$arg1" = "A" ]; then
    if [ $(vboxmanage list vms | grep "$arg2" | wc -l) = 0 ]; then
        echo "La VM $arg2 n'existe pas."
        exit
    fi
    vboxmanage controlvm $arg2 poweroff

fi


