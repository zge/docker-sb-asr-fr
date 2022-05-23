#!/bin/bash

#aws --profile zge s3 cp --recursive s3://appen-inhouse-asr-test-data/zge/data/tiny/ /opt/data/
aws s3 sync s3://appen-inhouse-asr-test-data/zge/data/tiny/ /opt/data/ --profile zge
