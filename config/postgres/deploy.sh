#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

get_random(){
    array=()
    for i in {a..z} {A..Z} {0..9}; 
    do
        array[$RANDOM]=$i
    done
    printf %s ${array[@]::16}
}

pw=$(get_random)
echo $pw

if ! helm repo list | grep -q 'https://cloudnative-pg.github.io/charts'; then
    helm repo add cloudnative-pg https://cloudnative-pg.github.io/charts
fi

helm upgrade --install cloudnative-pg cloudnative-pg/cloudnative-pg
echo "Waiting for operator to stabalize"
sleep 30

kubectl create ns postgres

kubectl create secret generic localdb-secret -n postgres --from-literal username=localuser --from-literal password=$pw
kubectl apply -f config.yaml