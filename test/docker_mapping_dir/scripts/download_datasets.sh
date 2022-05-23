#/bin/bash

# download public dataset (CommonVoice 8.0)
dataset=cv-corpus-8.0-2022-01-19
[ ! -d /opt/data/CommonVoice/${dataset} ] && \
    mkdir -p /ots/data/CommonVoice/${dataset} && \
    aws s3 cp --recursive s3://appen-inhouse-asr-tr-data-public/FRF/${dataset} /opt/data/CommonVoice/${dataset} 

# download OTS datasets
for dataset in FRF_ASR001 FRF_ASR002 FRF_ASR003
do
    [ ! -d /opt/data/ots_french/FRF_ASR003 ] && \
        mkdir -p /ots/data/ots_french/${dataset} && \
        aws s3 cp --recursive s3://appen-inhouse-asr-tr-data-ots/FR/FR-FR/${dataset}/ /opt/data/ots_french/${dataset}
done
