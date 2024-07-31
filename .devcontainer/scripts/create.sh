#!/usr/bin/env bash

function install_postgres_client(){
    sudo apt update && sudo apt install -y postgresql-client
}

function create_kind_cluster(){
    while (! docker ps &> /dev/null )
    do
        echo "Waiting for Docker daemon to be ready"
        echo -n "."
        sleep 1
    done
    echo ""
    echo "Creating Kind Cluster"
    kind create cluster --config ./config/kind_cluster.yaml --wait 1m
}


install_postgres_client
create_kind_cluster
