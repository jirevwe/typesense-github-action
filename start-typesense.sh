#!/bin/sh

TYPESENSE_VERSION=$1
TYPESENSE_PORT=$2
TYPESENSE_CONTAINER_NAME=$3
TYPESENSE_API_KEY=$4

if [ -z "$TYPESENSE_VERSION" ]; then
  echo "Missing Typesense version in the [typesense-version] input. Received value: $TYPESENSE_VERSION"
  echo "Falling back to Typesense version [0.23.1]"
  TYPESENSE_VERSION='0.23.1'
fi

echo "Starting single-node Typesense instance"
# mkdir /tmp/typesense-data
docker run -d \
  -p $TYPESENSE_PORT:8108 \
  # -v/tmp/typesense-data:/data \
  --name $TYPESENSE_CONTAINER_NAME \
  typesense/typesense:$TYPESENSE_VERSION \
  # --data-dir /data \
  --api-key=$TYPESENSE_API_KEY \
  --enable-cors