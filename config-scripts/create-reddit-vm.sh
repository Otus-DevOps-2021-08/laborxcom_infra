#!/usr/bin/env bash
yc compute instance create \
--name reddit-full \
--hostname reddit-full \
--memory=2 \
--create-boot-disk image-family=reddit-full,size=10GB \
--network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
--metadata serial-port-enable=1 \
--zone=ru-central1-a \
--metadata-from-file user-data=create-reddit-vm.yaml
