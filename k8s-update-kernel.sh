#!/bin/bash
systemctl disable --now firewalld NetworkManager
setenforce 0
sed -ri '/^[^#]*SELINUX=/s#=.+$#=disabled#' /etc/selinux/config
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
yum install wget chrony -y
cat <<EOF > /etc/chrony.conf
server ntp.aliyun.com iburst
stratumweight 0
driftfile /var/lib/chrony/drift
rtcsync
makestep 10 3
bindcmdaddress 127.0.0.1
bindcmdaddress ::1
keyfile /etc/chrony.keys
commandkey 1
generatecommandkey
logchange 0.5
logdir /var/log/chrony
EOF
systemctl enable chronyd && systemctl restart chronyd
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
yum install wget git  jq psmisc -y
yum update -y
export Kernel_Vsersion=4.18.16-1
wget http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml{,-devel}-${Kernel_Vsersion}.el7.elrepo.x86_64.rpm
yum localinstall -y kernel-ml*
find /lib/modules -name '*nf_conntrack_ipv4*' -type f
grub2-set-default  0 && grub2-mkconfig -o /etc/grub2.cfg
grubby --default-kernel
grubby --args="user_namespace.enable=1" --update-kernel="$(grubby --default-kernel)"
reboot
