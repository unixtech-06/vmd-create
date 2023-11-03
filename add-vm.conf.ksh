#!/bin/ksh

# Function to list disk images
list_disk_images() {
    echo "Available Disk Images:"
    ls ./vm/image/disk
}

# Function to append VM configuration to /etc/vm.conf
append_vm_conf() {
    disk_image=$1
    vm_name="${disk_image%.*}"

    # Check if VM configuration already exists
    if grep -q "vm \"$vm_name\"" /etc/vm.conf; then
        echo "Configuration for $vm_name already exists in /etc/vm.conf."
    else
        # Prompt for memory size
        echo -n "Enter the memory size for $vm_name (e.g., 512M, 1G): "
        read memory_size

        # Append VM configuration to /etc/vm.conf
        echo "vm \"$vm_name\" {" >> /etc/vm.conf
        echo "    memory $memory_size" >> /etc/vm.conf
        echo "    disk \"/vm/image/disk/$disk_image\"" >> /etc/vm.conf
        echo "}" >> /etc/vm.conf
        echo "Configuration for $vm_name has been added to /etc/vm.conf."
    fi
}

# Main script starts here
echo "Welcome to the VM configuration append wizard."

# List disk images
list_disk_images

# Prompt user to select a disk image
echo -n "Enter the name of the disk image you want to configure (e.g., my_vm.qcow2): "
read disk_image

# Append VM configuration to /etc/vm.conf
append_vm_conf "$disk_image"

echo "VM configuration append process completed."

