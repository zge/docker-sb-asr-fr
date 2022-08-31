

# show every command before running
set -x

# build docker image locally
docker build --no-cache -t sb-asr-fr-train:latest .
#docker build -t sb-asr-fr-train:latest .
