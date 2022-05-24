## Execute using 
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/add_node_k8.sh | bash 

#!/bin/bash
echo "####################################################"
echo "Kubernetes vanilla installation begins using KubeADM"
echo "####################################################"
sleep 1
apt-get clean
rm /var/lib/dpkg/lock    
rm /var/cache/apt/archives/lock
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
sleep 1
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl -p
sleep 2
apt-get update -y 
sleep 1
export DEBIAN_FRONTEND=noninteractive
echo "##########################"
echo "DOCKER INSTALLATION BEGINS"
echo "##########################"
sleep 1
apt-get install -y libpq-dev apt-transport-https curl docker.io
sleep 1
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sleep 1 
systemctl daemon-reload
systemctl restart docker
systemctl enable docker
sleep 1 
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
sleep 1 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sleep 1 
apt-get update
sleep 1 
##Workaround to disable swap on Linux host 
#sed -i -e '2s/^/#/' /etc/fstab
echo "##############################################"
echo "KUBERNETES DEFAULT PACKAGE INSTALLATION BEGINS"
echo "##############################################"
swapoff -a
sleep1
apt-get install -y kubelet=1.22.1-00 kubeadm=1.22.1-00 kubectl=1.22.1-00
sleep 1
echo "######################################################################################################"
echo "K8s Node Package installation finishes, Now you can use master token to add these nodes in K8s Cluster"
echo "#######################################################################################################"


## After running add_node_k8.sh on worker node 
## Copy  /kub.txt located at master node.
## OR Generate token using command on master $kubeadm token create --print-join-command 
## Paste the contents on worker node and enter 
## Post sucessful execution; Check cluster status on master node command $kubectl get nodes
## finisH
