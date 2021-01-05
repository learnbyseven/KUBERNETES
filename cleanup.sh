#!/bin/bash
kubeadm reset
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
