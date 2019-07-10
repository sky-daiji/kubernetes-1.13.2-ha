#!/bin/bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install kubelet-1.14.3 kubeadm-1.14.3 kubectl-1.14.3 -y
cat <<EOF > /etc/sysconfig/kubelet
KUBELET_EXTRA_ARGS="--cgroup-driver=systemd --pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.1"
EOF
systemctl enable kubelet && systemctl start kubelet
kubeadm init --kubernetes-version=1.14.3 \
--ignore-preflight-errors=Swap \
--apiserver-advertise-address=172.16.80.80 \
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers \
--service-cidr=10.96.0.0/12 \
--pod-network-cidr=10.244.0.0/16
