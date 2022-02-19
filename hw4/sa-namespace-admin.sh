#!/bin/bash
#
#from Kubernetes offical documentation
#

kubectl -n default create serviceaccount sa-namespace-admin
kubectl create clusterrolebinding sa-namespace-admin --clusterrole=cluster-admin --serviceaccount=default:sa-namespace-admin
export TOKENNAME=$(kubectl -n default get serviceaccount/sa-namespace-admin -o jsonpath='{.secrets[0].name}')
export TOKEN=$(kubectl -n default get secret $TOKENNAME -o jsonpath='{.data.token}' | base64 --decode)
kubectl config set-credentials sa-namespace-admin --token=$TOKEN
kubectl config set-context --current --user=sa-namespace-admin --cluster=minikube
