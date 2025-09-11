#!/bin/bash

arg1=$1
arg2=$2
ram=4096
dd=65536

if [ "$arg1" = "L" ]; then
    if [ -z "$arg2" ]; then
        for vm in $(vboxmanage list vms | awk -F\" '{print $2}'); do
            echo "-------------------------------------"
            echo "VM : $vm"
            vboxmanage getextradata "$vm" "creation_date" | awk -F': ' '{print "Date de création : " $2}'
            vboxmanage getextradata "$vm" "user" | awk -F': ' '{print "Utilisateur : " $2}'
        done
    else
        if vboxmanage list vms | awk -F\" '{print $2}' | grep -q "^$arg2$"; then
            echo "-------------------------------------"
            echo "VM : $arg2"
            vboxmanage getextradata "$arg2" "creation_date" | awk -F': ' '{print "Date de création : " $2}'
            vboxmanage getextradata "$arg2" "user" | awk -F': ' '{print "Utilisateur : " $2}'
        else
            echo "La VM $arg2 n'existe pas."
        fi
    fi

elif [ "$arg1" = "N" ]; then
    if [ -z "$arg2" ]; then
        echo "Veuillez nommer la VM s'il vous plaît."
        exit
    fi
    if vboxmanage list vms | grep -q "$arg2"; then
        echo "La VM $arg2 existe déjà."
        exit
    fi
    

    vboxmanage createvm --name="$arg2" --ostype="Debian_64" --register
    vboxmanage modifyvm "$arg2" --memory "$ram" --cpus 2 --vram 64

    vboxmanage createmedium disk --filename "$HOME/VirtualBox VMs/$arg2/$arg2.vdi" --size "$dd" --format VDI
    vboxmanage storagectl "$arg2" --name "SATA Controller" --add sata --controller IntelAhci
    vboxmanage storageattach "$arg2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$arg2/$arg2.vdi"

    # Ajout des métadonnées
    vboxmanage setextradata "$arg2" "creation_date" "$(date)"
    vboxmanage setextradata "$arg2" "user" "$USER"

    virtualbox

elif [ "$arg1" = "S" ]; then
    if [ -z "$arg2" ]; then
        echo "Veuillez nommer la VM s'il vous plaît."
        exit
    fi
    vboxmanage unregistervm "$arg2" --delete
    virtualbox

elif [ "$arg1" = "D" ]; then
    if [ -z "$arg2" ]; then
        echo "Veuillez nommer la VM s'il vous plaît."
        exit
    fi
    if [ $(vboxmanage list vms | grep "$arg2" | wc -l) = 0 ]; then
        echo "La VM $arg2 n'existe pas."
        exit
    fi
    vboxmanage startvm "$arg2" --type gui

elif [ "$arg1" = "A" ]; then
    if [ -z "$arg2" ]; then
        echo "Veuillez nommer la VM s'il vous plaît."
        exit
    fi
    if [ $(vboxmanage list vms | grep "$arg2" | wc -l) = 0 ]; then
        echo "La VM $arg2 n'existe pas."
        exit
    fi
    vboxmanage controlvm "$arg2" poweroff

fi

