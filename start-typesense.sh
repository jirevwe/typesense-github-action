#!/bin/sh

TYPESENSE_VERSION=$1
TYPESENSE_PORT=$2
TYPESENSE_CONTAINER_NAME=$3
TYPESENSE_API_KEY=$4

if [ -z "$TYPESENSE_VERSION" ]; then
  echo "Missing Typesense version in the [typesense-version] input. Received value: $TYPESENSE_VERSION"
  echo "Falling back to Typesense version [latest]"
  TYPESENSE_VERSION='latest'
fi

echo "Starting single-node Typesense instance"

mkdir /tmp/typesense
docker run -d -p $TYPESENSE_PORT:8108 --name $TYPESENSE_CONTAINER_NAME -v/tmp/typesense:/data typesense/typesense:$TYPESENSE_VERSION --api-key=$TYPESENSE_API_KEY --data-dir /data --enable-cors