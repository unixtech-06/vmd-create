#!/bin/ksh

# Function to list ISO images
list_iso_images() {
    echo "Available ISO Images:"
    ls ./vm/image/iso 
}

# Function to create a VM
create_vm() {
    vm_name=$1
    disk_size=$2
    iso_image=$3

    # Create disk image
    vmctl create -s "$disk_size"G ./vm/image/disk/"$vm_name".qcow2
    echo "Disk image for $vm_name created."

    # Start the VM
    vmctl start -m 1G -L -i 1 -r ./vm/image/iso/"$iso_image" -d ./vm/image/disk/"$vm_name".qcow2 "$vm_name"
    echo "VM $vm_name started."
}

# Main script starts here
echo "Welcome to the VM creation wizard."

# Get VM name
echo -n "Enter the name for your VM: "
read vm_name

# Get disk size
echo -n "Enter the disk size (in GB) for your VM: "
read disk_size

# List ISO images and get user selection
list_iso_images
echo -n "Enter the name of the installer ISO image you want to use: "
read iso_image

# Create the VM
create_vm "$vm_name" "$disk_size" "$iso_image"

echo "VM creation process completed."

