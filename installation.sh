## Execute using 
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/installation.sh | bash -s 

#!/bin/bash
echo "Kubernetes vanilla installation begins using KubeADM"
sudo apt-get update && apt-get install -y apt-transport-https curl docker.io
sleep 2 
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sleep 2 
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker
sleep 2 
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sleep 1 
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sleep 2 
sudo apt-get update
echo "KUBERNETES DEFAULT PACKAGE INSTALLATION BEGINS"
sudo apt-get install -y kubelet kubeadm kubectl
sudo swapoff -a
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-bind-port=6443 > /kub.txt
sudo mkdir -p $HOME/.kube && cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config
sudo kubectl taint nodes --all node-role.kubernetes.io/master-
sudo kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml
sleep 1
echo "COMPLETED"
#### FINISH 
