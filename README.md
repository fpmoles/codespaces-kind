# Codespaces: Kind
A playground for codespaces with kind

_Note: All commands are from the perspective of the root directory_

## Usage

Once your container comes up, there a couple of steps you need to execute.

* If you want to preload data into your database, add your sql statements to `dat/data.sql`
* From the terminal execute 'install_k8s'

## Command Line Helpers Installed
* [httpie](https://httpie.io/): a command line tool for executing ReST API Requests
* k: k is aliased to kubectl so instead of typing `kubectl get po` you can type `k get po`
* psql: the postgresql client is installed

## Helper scripts
_Note: These scripts are available on the PATH, you can execute them anywhere in the codespace environemnt from the terminal_
* create_envlist: creates an env.list file in the current directory with the environment variables needed for connection for a running app (see notes about DB_HOST in [Connection Data](#connection-data))
* db_connect: loads the environment and connects to the database in the terminal
* db_details: outputs the database connection details (see notes about DB_HOST in [Connection Data](#connection-data))
* destroy_k8s: deletes the kind cluster and all resources for a fresh start, usually followed up with `install_k8s`
* install_k8s: creates a kind cluster and installs postgres, prometheus with grafana, and ingress-nginx
* populate_postgres: loads the file `/dat/data.sql' into the database


## Notes about Behaviors & Troubleshooting
* It takes a bit on rebuild for docker to come back up, you can execute `docker ps` in the command line to see if it is up
* Since we are running Docker-in-Docker with kind, things can get out of whack there as well
    * If you find that there are no contexts in `kubectl config get-contexts` but `kind get clusters` responds execute a command `kind export kubeconfig --name local` and try again

## Connection Data
| Port | Tool | Notes |
| ---- | ---- | ---- |
| 5432 | Postgresql | Docker to docker connections requires port from `ifconfig` instead of localhost, look for the docker ip |
| 30000 | Prometheus | Access through the ports tab to load in browser, Pod and Service Monitors can be added |
| 31000 | Grafana | Access through the ports tab, leverage admin:prom-operator for access |
| 32000 | Alert Manager | |

## Customizing
* to add a script to the PATH, add it to the `/scripts/` directory


 
