#!/bin/ksh

# Function to list available disk images
list_disk_images() {
    echo "Available Disk Images:"
    ls ./vm/image/disk
}

# Function to list available bridges and their IP addresses
list_bridges() {
    # This function should be implemented in C as per the earlier discussion
    # and the output of that C program is captured here.
    ./bin/list_bridges
}

# Function to append VM configuration to /etc/vm.conf
append_vm_conf() {
    # List available disk images
    list_disk_images
    # Prompt user to select a disk image
    echo -n "Enter the name of the disk image you want to configure (e.g., my_vm.qcow2): "
    read disk_image
    vm_name="${disk_image%.*}"

    # Check if VM configuration already exists
    if grep -q "vm \"$vm_name\"" /etc/vm.conf; then
        echo "Configuration for $vm_name already exists in /etc/vm.conf."
        return 1
    fi

    # Prompt for memory size
    echo -n "Enter the memory size for $vm_name (e.g., 512M, 1G): "
    read memory_size

    # Prompt for adding local interface
    echo -n "Do you want to add a 'local interface' to the VM configuration? [yes/NO]: "
    read add_local_interface
    add_local_interface=$(echo "$add_local_interface" | tr '[:upper:]' '[:lower:]')  # Convert to lowercase

    # List available bridges and prompt for bridge selection
    bridge_list=$(list_bridges)
    echo "Available bridges and their IP addresses:"
    echo "$bridge_list"
    echo -n "Enter the bridge you want to attach to the VM (e.g., bridge0), or press Enter to skip: "
    read selected_bridge

    # Append VM configuration to /etc/vm.conf
    echo "vm \"$vm_name\" {" >> /etc/vm.conf
    echo "    memory $memory_size" >> /etc/vm.conf
    echo "    disk \"$(pwd)/vm/image/disk/$disk_image\"" >> /etc/vm.conf
    if [ "$add_local_interface" = "yes" ]; then
        echo "    local interface" >> /etc/vm.conf
    fi
    if [ -n "$selected_bridge" ] && echo "$bridge_list" | grep -q "$selected_bridge"; then
        echo "    interface { switch \"$selected_bridge\" }" >> /etc/vm.conf
    elif [ -n "$selected_bridge" ]; then
        echo "Error: Selected bridge does not exist."
        return 1
    fi
    echo "}" >> /etc/vm.conf
    echo "Configuration for $vm_name has been added to /etc/vm.conf."
}

# Main script starts here
echo "Welcome to the VM configuration append wizard."

# Append VM configuration to /etc/vm.conf
append_vm_conf

echo "VM configuration append process completed."

