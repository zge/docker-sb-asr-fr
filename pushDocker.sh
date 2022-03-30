#!/bin/bash

# Retrieve an authentication token
eval "$( aws ecr get-login --no-include-email --region us-west-2)"

# Authenticate your Docker client to your registry
docker login --username AWS --password-stdin 220211432420.dkr.ecr.us-west-2.amazonaws.com

## Build Docker image (skip if Docker image is already built)
#docker build -t sb_asr_fr .

# tag your image so you can push the image to this repository
docker tag sb_asr_fr:latest 220211432420.dkr.ecr.us-west-2.amazonaws.com/sb_asr_fr:latest

# push the image to your newly created AWS repository
docker push 220211432420.dkr.ecr.us-west-2.amazonaws.com/sb_asr_fr:latest


