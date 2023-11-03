# vmd-create

#Creating Virtual Machines in OpenBSD with create_vm.sh Script

The create_vm.sh script is a user-friendly tool designed for OpenBSD users to simplify the process of creating virtual machines (VMs) using the native vmd virtual machine daemon. This script streamlines the VM creation process by guiding users through a series of prompts to configure their new VM.

#Key Features of the create_vm.sh Script:

    Interactive prompts for user input.
    Customizable VM name and disk size.
    Selection of an ISO image for the VM installer.

#Prerequisites:
Before using the script, ensure that your OpenBSD system has vmd enabled and that you have the necessary ISO images stored in /vm/image/iso.

#Using the create_vm.sh Script:

    Save the script as create_vm.sh on your OpenBSD system.
    Make the script executable with the command: chmod +x create_vm.sh.
    Run the script using: ./create_vm.sh.

Once executed, the script will prompt you to enter the following details:

    VM Name: The desired name for your virtual machine.
    Disk Size: The size of the virtual disk for your VM, specified in gigabytes (GB).
    ISO Image: The name of the installer ISO image you wish to use for the VM.

After providing the necessary information, the script will automatically create the virtual disk and start the VM using the vmctl utility. You'll receive confirmation messages indicating the successful creation and start of your VM.

#Example Usage:

'''bash
Welcome to the VM creation wizard.
Enter the name for your VM: my_vm
Enter the disk size (in GB) for your VM: 50
Available ISO Images:
install74.iso
Enter the name of the installer ISO image you want to use: install74.iso
VM creation process completed.
'''bash

The create_vm.sh script is an excellent tool for both novice and experienced OpenBSD users, making VM creation a straightforward and hassle-free process.
