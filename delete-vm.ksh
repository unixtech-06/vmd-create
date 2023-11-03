#!/bin/ksh

# VMの一覧を表示
list_vms() {
    echo "Available Virtual Machines:"
    vmctl status | awk 'NR>1 {print $NF}'
}

# VMを削除
delete_vm() {
    vm_name=$1

    # VMが実行中かどうか確認
    running=$(vmctl status | grep -w "$vm_name")
    if [ -n "$running" ]; then
        # VMを停止
        vmctl stop "$vm_name"
        echo "VM $vm_name has been stopped."
    fi

    # VMのディスクイメージのパスを取得（仮のパス）
    disk_image="/vm/image/disk/$vm_name.qcow2"

    # ディスクイメージが存在するか確認
    if [ -f "$disk_image" ]; then
        # ディスクイメージを削除
        rm "$disk_image"
        echo "Disk image $disk_image has been deleted."
    else
        echo "Disk image $disk_image does not exist."
    fi
}

# メインスクリプト
echo "Welcome to the VM deletion wizard."

# VMの一覧を表示
list_vms

# 削除するVMを選択
echo -n "Enter the name of the VM you want to delete: "
read vm_name

# VMを削除
delete_vm "$vm_name"

echo "VM deletion process completed."

