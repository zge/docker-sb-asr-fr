#!/bin/bash

set -x

current_dir=`pwd`
sub_dir='docker_mapping_dir'

# use this command if data is mapped
docker run -it -d -v $current_dir/$sub_dir/data:/opt/data  \
               -v $current_dir/$sub_dir/filelists/cv_with_ots:/opt/speechbrain/templates/speech_recognition/filelists/cv_with_ots \
               -v $current_dir/$sub_dir/results:/opt/speechbrain/recipes/CommonVoice/results \
               -e "TERM=xterm-256color"   \
               --gpus all \
               sb_asr_fr:latest /bin/bash -c \
               'cd /opt/speechbrain/recipes/CommonVoice; \
               CUDA_VISIBLE_DEVICES=2,3 python ASR/seq2seq/train_exp_cv_with_ots.py \
                   ASR/seq2seq/hparams/train_fr_exp_cv_with_ots.yml --data_parallel_backend' 

## use this command if data is downloaded during Dcoker build
#docker run -it -d -v $current_dir/$sub_dir/filelists/cv_with_ots:/opt/speechbrain/templates/speech_recognition/filelists/cv_with_ots \
#               -e "TERM=xterm-256color"   \
#               --gpus all \
#               sb_asr_fr:latest /bin/bash -l
