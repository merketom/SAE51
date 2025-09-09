arg1=$1
arg2=$2

if [ "$arg1" = "L" ]; then
    vboxmanage list vms

elif [ "$arg1" = "N" ]; then
    vboxmanage createvm --name="$arg2" --ostype="Debian_64" --register
    vboxmanage modifyvm "$arg2" --memory 4096 --cpus 2 --vram 64

    vboxmanage createmedium disk --filename "$HOME/VirtualBox VMs/$arg2/$arg2.vdi" --size 65536 --format VDI
    vboxmanage storagectl "$arg2" --name "SATA Controller" --add sata --controller IntelAhci
    vboxmanage storageattach "$arg2" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/$arg2/$arg2.vdi"

elif [ "$arg1" = "S" ]; then
    vboxmanage unregistervm "$arg2" --delete-all

elif [ "$arg1" = "D" ]; then
    vboxmanage startvm $arg2

elif [ "$arg1" = "A" ]; then
    vboxmanage controlvm $arg2 poweroff

fi

virtualbox
