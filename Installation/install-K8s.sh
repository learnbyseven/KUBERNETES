## Execute using 
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/install-K8s.sh | bash 

#!/bin/bash
echo "Kubernetes vanilla installation begins using KubeADM"
echo "#####################################"
echo "Step 1/3 Pre-installation setup!"
sleep 2
KUBERNETES_VERSION=v1.29
CRIO_VERSION=v1.29
sleep 2
apt-get clean
rm /var/lib/dpkg/lock    
rm /var/cache/apt/archives/lock
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sysctl -p
sleep 1
modprobe br_netfilter
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
echo 1 > /proc/sys/net/ipv4/ip_forward
sleep 2 
echo "Adding Kuberenetes repos"
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/kubernetes.list
sleep 2
echo "Adding Cri-O repos"
sleep 2
curl -fsSL https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/cri-o.list
echo "Both repos are added NOW"
echo "Step 1/3 Finished Successfully !"
echo "#####################################"
echo "Step 2/3 Kubernetes and Container runtime CRI-O SETUP!"
sleep 2
apt-get update
sleep 1
apt-get install -y software-properties-common curl
sleep 2
apt-get install -y cri-o kubelet kubeadm kubectl
swapoff -a
sleep 2
echo "Step 2/3 Finished Successfully !"
echo "#####################################"
echo "Step 3/3 KUBERNTES access setup and CNI- Calico installation !"
sleep 1
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-bind-port=6443 
mkdir -p $HOME/.kube && cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
echo "SDN - CALICO INSTALLATION STARTING NOW"
echo "######################################"
sleep 1
#curl https://docs.projectcalico.org/manifests/calico.yaml -O
#sleep 2
kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
#kubectl apply -f https://docs.projectcalico.org/v3.10/manifests/calico.yaml
sleep 1
echo "Step 3/3 Finished Successfully !"
echo "#########################"
echo "Starting Validation"
sleep 10
kubectl get nodes
sleep 3
crictl pods
sleep 2
echo " Success = Node status "Ready" and All Pods in "Ready" state"
echo " Validation Done"
echo "#####FINSIH#####"
#### FINISH 

## FOR ADDING NODE
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/add_node_k8.sh | bash 

## Additional 
# echo "alias k='kubectl'" >> .bashrc && source .bashrc
