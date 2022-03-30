

#FROM ubuntu:20.04
#FROM python3.8
#FROM python:3.8.10-alpine #The alpine doesn't have apt-get

#ARG DEBIAN_FRONTEND=noninteractive

#FROM python:3.8.10-slim-buster
#FROM nvidia/cuda:11.0-base

FROM nvidia/cuda:11.3.1-base
#FROM python:3.8.10-slim-buster

LABEL tagVER="sb_asr_fr"

ENV TERM xterm-256color

# Set timezone:
RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

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
RUN pip3 install speechbrain sklearn xgboost librosa ipython numba==0.54.1 numpy==1.20.3

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

# add the data sym link into the repo
RUN ln -s /opt/data /opt/speechbrain/recipes/CommonVoice/data  

## download datasets (if not mapped from local dir)
#RUN bash /opt/scripts/download_datasets.sh

# set up the work dir
WORKDIR /opt
