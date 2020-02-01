#!/bin/bash
# 1. Save old kernels to /boot.old
clear
cd /boot

backupBoot='/boot.old'
mkdir -p $backupBoot

### 2. Save dpkg info files to /var/lib/dpkg/info.old
backupDpkgFiles='/var/lib/dpkg/info.old'
mkdir -p $backupDpkgFiles

# 3. Takes number of the current kernel file
nkernelCurrent=0
nkernelCurrent=$(uname -r | cut -d "-" -f2)

# 4. List all files in / boot in order taking first number to start loop
nkernelStart=0
nkernelStart=$(ls *[0-9]* | cut -d "-" -f3 | sort | head -n1)

# 5. End position of loop -2
# Final position of loop -2, file number that will be moved cannot be the same as the current kernel
nkernelEnd=0
nkernelEnd=$(($nkernelCurrent - 2))

# 6. The loop lists all files containing the number stored in the variable nkernelStart moving to the backup directory
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
  fi
  let nkernelStart=nkernelStart+1
done

# 7. Performing cleaning of old files
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



