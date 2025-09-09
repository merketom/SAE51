#Variable
NOM_VM="Debian1"
VM_EXIST=$(vboxmanage list vms | grep "\"$NOM_VM\"" | wc -l)

if [ "$VM_EXIST" -ne 0 ]; then
    echo "[INFO] La machine $NOM_VM existe déjà. Suppression..."
    VBoxManage unregistervm "$NOM_VM" --delete
fi

vboxmanage createvm --name="Debian1" --ostype="Debian_64" --register
vboxmanage modifyvm "Debian1" --memory 4096 --cpus 2 --vram 64

vboxmanage createmedium disk --filename "$HOME/VirtualBox VMs/Debian1/Debian1.vdi" --size 65536 --format VDI
vboxmanage storagectl "Debian1" --name "SATA Controller" --add sata --controller IntelAhci
vboxmanage storageattach "Debian1" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/Debian1/Debian1.vdi"

virtualbox
