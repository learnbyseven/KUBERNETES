#!/bin/bash
kubectl create ns pollapp
kubectl -n pollapp apply -f dbpoll.yaml  
kubectl -n pollapp apply -f webpoll.yaml &> /dev/null
echo "FINISH"
