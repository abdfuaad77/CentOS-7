#!/bin/bash
################################################################
# Interactive Kitty Script
#
# OS: CentOS 7.x
# Replace default NetworkingManager.service with network.service
# Assign additional subnets
#
###############################################################
read -p "What is your active NIC?: " nic && systemctl stop NetworkManager.service && systemctl disable NetworkManager.service && cd /etc/sysconfig/network-scripts && echo "NM_CONTROLLED=no" >> ifcfg-$nic && systemctl enable network.service && chkconfig network on && yum remove NetworkManager -y && service network restart
echo "Yay, it works, did you want to proceed with assigning the /24 subnet?: "
select yn in "Yes" "No"; do
        case $yn in
               Yes )  echo "Lovely, please fill the required /24 information."
                         touch ifcfg-$nic-range0
                         read -p "IP START: " ipstart && read -p "IP END: " ipend && read -p "PREFIX: " prefix && read -p "COLUM START: " column
echo "IPADDR_START=$ipstart
IPADDR_END=$ipend
PREFIX=$prefix
CLONENUM_START=$column
ONBOOT=yes
NM_CONTROLLED=no
ARPCHECK=no" > ifcfg-$nic-range0
echo "That lovely information has been saved inside it's respected conf file. Don't forget to restart your network service ;)"
                                  break;;
               No )    echo "

That would be considered anticlimactic in some parts of the world.



QQ SAD FACE"
                       exit 1;;
        esac
    done
