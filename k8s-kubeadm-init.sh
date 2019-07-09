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
yum install kubelet-1.14.3 kubeadm-1.14.3 kubectl-1.14.3
cat <<EOF > /etc/sysconfig/kubelet
KUBELET_EXTRA_ARGS="--cgroup-driver=systemd --pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.1"
EOF
systemctl enable kubelet && systemctl start kubelet
