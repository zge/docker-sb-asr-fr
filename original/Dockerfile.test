

#FROM ubuntu:20.04
#FROM python3.8
#FROM python:3.8.10-alpine #The alpine doesn't have apt-get

#ARG DEBIAN_FRONTEND=noninteractive

#FROM python:3.8.10-slim-buster
#FROM nvidia/cuda:11.0-base

FROM nvidia/cuda:11.3.1-base
#FROM python:3.8.10-slim-buster

LABEL tagVER="sb-asr-fr-test"

ENV TERM xterm-256color

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN rm /etc/apt/sources.list.d/cuda.list
RUN rm /etc/apt/sources.list.d/nvidia-ml.list

# install tools and packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                       apt-utils \
                       build-essential \
                       software-properties-common \
                       curl \
                       wget \
                       ffmpeg \
                       sox \
                       apt-utils \
                       vim \
                       bc \
                       make \
                       automake \
                       procps \
                       git-all \
                       python3.8 \
                       python3-pip

# Add a link to line python to python3
RUN ln -s /usr/bin/python3 /usr/bin/python

# Install Python Packages
RUN pip3 install speechbrain sklearn xgboost librosa ipython boto3 numba==0.54.1 numpy==1.20.3

# Install AWS CLI
RUN pip3 install awscli --force-reinstall --upgrade

# copy scripts dir fromv docker_mapping_dir/scripts (outside docker)" to "/opt/scripts (inside docker)"
COPY docker_mapping_dir/scripts /opt/scripts

# add execution permission
RUN chmod 777 /opt/

# download the speechbrain repo
RUN cd /opt && git clone https://github.com/zge/speechbrain.git

# create dirs
RUN mkdir /opt/data /opt/speechbrain/templates/speech_recognition/filelists

# copy filelists
COPY docker_mapping_dir/filelists/cv_with_ots /opt/speechbrain/templates/speech_recognition/filelists/cv_with_ots 

# add the data sym link into the repo
RUN ln -s /opt/data /opt/speechbrain/recipes/CommonVoice/data  

## download datasets (if not mapped from local dir)
#RUN bash /opt/scripts/download_datasets_tiny_staging.sh

## copy datasets instead if the downloading does not work due to permission issue
#COPY docker_mapping_dir/data /opt/data

# set up the work dir
WORKDIR /opt/speechbrain/recipes/CommonVoice

# run training
ENTRYPOINT ["bash", "./run.sh"]

