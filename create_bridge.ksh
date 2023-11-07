#!/bin/ksh

# 現在のブリッジの状態を表示
echo "Current bridge status:"
./bin/list_bridges

ask_vether_number() {
  while true; do
    echo "Enter vether number (e.g., 0 for vether0):"
    read vether_num

    # Check if the input is numeric
    case $vether_num in
      ''|*[!0-9]*) echo "Error: vether number must be a number. Please try again." ;;
      *) break ;;
    esac
  done
}

ask_vether_number

# ユーザーにネットワークIPを尋ねる
echo "Enter the network IP (e.g., 10.0.0.1):"
read network_ip

# ユーザーにネットワークマスクを尋ねる
echo "Enter the network mask (e.g., 255.255.255.0):"
read network_mask

# ユーザーにSwitchの名前を尋ねる
echo "Enter the name for the switch:"
read switch_name

# vetherの設定ファイルを作成
echo "inet $network_ip $network_mask" > /etc/hostname.vether$vether_num

# vetherインターフェースを起動
sh /etc/netstart vether$vether_num

# bridgeの設定ファイルを作成
echo "add vether\"$vether_num\" " > /etc/hostname.bridge$vether_num

# bridgeインターフェースを起動
sh /etc/netstart bridge$vether_num

# /etc/pf.confにNAT設定を追加
echo "match out on egress from ${network_ip}/24 to any nat-to (egress)" >> /etc/pf.conf

# /etc/vm.confにSwitch設定を追加
echo "switch \"$switch_name\" {" >> /etc/vm.conf
echo "    interface bridge\"$vether_num\" " >> /etc/vm.conf
echo "}" >> /etc/vm.conf

echo "Configuration completed."

