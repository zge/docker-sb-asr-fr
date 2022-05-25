

# show every command before running
set -x

# build docker image locally
docker build --no-cache -t sb-asr-fr-test-f8dev-data-included:latest .
