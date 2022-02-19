#!/bin/bash
#create minikube user
#work with minikube only
#do not use it anyway

user=$1
if [[ -z "$user" ]]; then
    echo "point username "$(basename "$0")" USER";
fi

tmp=cert_$user
mkdir $tmp

/usr/bin/openssl genrsa -out $tmp/$user.key 2048

/usr/bin/openssl req -new -key $tmp/$user.key -out $tmp/$user.csr -subj "/CN=$user"

/usr/bin/openssl x509 -req -in $tmp/$user.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out $tmp/$user.crt -days 365

/usr/bin/kubectl config set-credentials $user --client-certificate=$tmp/$user.crt --client-key=$tmp/$user.key

/usr/bin/kubectl config set-context $user --cluster=minikube --user=$user

echo "switch to "$user"'s context? Yes/No"
read answer
if [[ "$answer" == "Yes" ]]; then
    echo "Okay"
    /usr/bin/kubectl config use-context $user
    else
    echo "right choice! stay in touch"
fi

