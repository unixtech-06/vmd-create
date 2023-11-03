#!/bin/ksh

# Function to list disk images
list_disk_images() {
    echo "Available Disk Images:"
    ls ./vm/image/disk/
}

# Function to delete a VM
delete_vm() {
    disk_image=$1
    vm_name="${disk_image%.*}"

    # Check if the VM is running
    running=$(vmctl status | grep -w "$vm_name")
    if [ -n "$running" ]; then
        # Stop the VM
        vmctl stop "$vm_name"
        echo "VM $vm_name has been stopped."
    fi

    # Delete the disk image
    rm "/vm/image/disk/$disk_image"
    echo "Disk image /vm/image/disk/$disk_image has been deleted."
}

# Main script starts here
echo "Welcome to the VM deletion wizard."

# List disk images
list_disk_images

# Prompt user to select a disk image to delete
echo -n "Enter the name of the disk image you want to delete: "
read disk_image

# Delete the VM
delete_vm "$disk_image"

echo "VM deletion process completed."

