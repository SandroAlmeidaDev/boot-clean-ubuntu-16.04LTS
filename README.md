# /boot is not 100% full and apt is working

### Explaining the script

### 1. Save old kernels to /boot.old

### 2. Save dpkg info files to /var/lib/dpkg/info.old

### 3. Takes number of the current kernel file

### 4. List all files in / boot in order taking first number to start loop

### 5. End position of loop -2

### Final position of loop -2, file number that will be moved cannot be the same as the current kernel

### 6. The loop lists all files containing the number stored in the variable nkernelStart moving to the backup directory

### 7. Performing cleaning of old files
