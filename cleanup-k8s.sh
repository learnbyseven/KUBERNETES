## USE 
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/cleanup-k8s.sh | bash 
kubeadm reset
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
rm -rf ~/.kube/
rm -rf /etc/kubernetes
rm -rf /var/lib/kubelet
apt-get remove --purge kubelet kubeadm kubectl

