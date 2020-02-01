#!/bin/bash

clear
cd /boot

backupBoot='/boot.old'
mkdir -p $backupBoot

backupDpkgFiles='/var/lib/dpkg/info.old'
mkdir -p $backupDpkgFiles

nkernelCurrent=0
nkernelCurrent=$(uname -r | cut -d "-" -f2)

nkernelStart=0
nkernelStart=$(ls *[0-9]* | cut -d "-" -f3 | sort | head -n1)

nkernelEnd=0
nkernelEnd=$(($nkernelCurrent - 2))


while [[ $nkernelStart -le $nkernelEnd ]]
do 
  ls *"$nkernelStart"*  &>/dev/null
  if [ $? -eq 0 ]; then
    file=$(ls *"$nkernelStart"*) 
    echo "Save file $file in $backupBoot"
    mv -fv $file $backupBoot > $backupBoot/backupBoot.log 

    echo "Save files /var/lib/dpkg/info.old"
    mv -fv /var/lib/dpkg/info/*"$nkernelStart"* $backupDpkgFiles/ > $backupDpkgFiles/backupDpkgFiles.log
    sleep 0.5
    clear
  else
    echo "File $nkernelStart not found"
    clear
  fi
  let nkernelStart=nkernelStart+1
done

clear
echo "Performing cleaning of old files, please wait ..."
sleep 1
apt -f install -y
apt autoremove -y
apt autoclean -y
apt clean -y


clear
echo "Sucess!"
df -h | grep boot

sleep 2
exit



