#!/usr/bin/env bash

function install_postgres_client(){
    sudo apt update && sudo apt install -y postgresql-client
}

function create_kind_cluster(){
    echo "Waiting for Docker daemon to be ready"
    while (! docker ps &> /dev/null )
    do
        echo -n "."
        sleep 1
    done
    echo ""
    echo ""
    echo "*** Creating Kind Cluster ***"
    kind create cluster --config /workspaces/codespaces_kind/config/kind_cluster.yaml --wait 1m
}

clear
install_postgres_client
create_kind_cluster
