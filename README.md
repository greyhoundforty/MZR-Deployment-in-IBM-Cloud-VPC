# Consul Cluster in IBM Cloud VPC

This repository has code that will allow you to deploy a 3 zone [Consul](https://www.consul.io/)
cluster on IBM Cloud. The repo is an example of using the `count` syntax in
a module. 

The cluster will be deployed using Ansible via a Bastion host. All Ansible
commands will go through the Bastion instances floating IP. The consul servers
themselves will not have public IPs. 

