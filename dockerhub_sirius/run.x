#!/bin/bash
sudo docker build --no-cache -t electronicstructure/sirius /home/ubuntu/src/Dockerfiles/dockerhub_sirius
sudo docker push electronicstructure/sirius


