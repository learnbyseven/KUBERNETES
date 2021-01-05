## USE 
## curl -s https://raw.githubusercontent.com/learnbyseven/KUBERNETES-TRAINING/master/cleanup.sh | bash 
#!/bin/bash
kubeadm reset
echo "y"
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
rm -rf ~/.kube/

