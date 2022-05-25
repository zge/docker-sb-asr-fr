#!/bin/bash

set -x

docker run -it -e "TERM=xterm-256color"  sb-asr-fr-test-f8dev-data-included:latest /bin/bash -l

