#!/bin/ksh

# Create /vm/image/disk directory
create_disk_directory() {
    if [ ! -d "/vm/image/disk" ]; then
        mkdir -p /vm/image/disk
        echo "Directory /vm/image/disk has been created."
    else
        echo "Directory /vm/image/disk already exists."
    fi
}

# Create /vm/image/iso directory
create_iso_directory() {
    if [ ! -d "/vm/image/iso" ]; then
        mkdir -p /vm/image/iso
        echo "Directory /vm/image/iso has been created."
    else
        echo "Directory /vm/image/iso already exists."
    fi
}

# Main script starts here
echo "Setting up VM directories..."

# Create VM directories
create_disk_directory
create_iso_directory

echo "Setup process completed."

