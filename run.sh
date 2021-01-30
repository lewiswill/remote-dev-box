#!/bin/sh
if [[ ! -f host_vars/localhost.yml ]]; then
  cp host_vars/localhost.yml.example host_vars/localhost.yml
fi

if [[ ! -f host_vars/remote.yml ]]; then
  cp host_vars/remote.yml.example host_vars/remote.yml
fi

time terraform init && \
time ansible-galaxy install -r requirements.yml && \
time ansible-playbook playbook.yml