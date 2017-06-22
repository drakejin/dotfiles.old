# docker   에서 스왑공간 부족시 

# check swap space
sudo swapon -s
free -m

# Check available space
df -h

# Create swap file
sudo fallocate -l 2G /swapfile
ls -lh /swapfile

# Enabling swap file
sudo chmod 600 /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile


# make Permanent
sudo vi /etc/fstab
/swapfile   none    swap    sw    0   0


