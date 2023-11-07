#!/bin/ksh

# Create /vm/image/disk directory
create_disk_directory() {
	if [ ! -d "$(pwd)/vm/image/disk" ]; then
        mkdir -p ./vm/image/disk
	echo "Directory $(pwd)/vm/image/disk has been created."
    else
	    echo "Directory $(pwd)/vm/image/disk already exists."
    fi
}

# Create /vm/image/iso directory
create_iso_directory() {
	if [ ! -d "$(pwd)/vm/image/iso" ]; then
        mkdir -p ./vm/image/iso
	echo "Directory $(pwd)/vm/image/iso has been created."
    else
	    echo "Directory $(pwd)/vm/image/iso already exists."
    fi
}

# Main script starts here
echo "Setting up VM directories..."

# Create VM directories
create_disk_directory
create_iso_directory

chmod u+x ./*.ksh

echo "Setup process completed."

