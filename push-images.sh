#!/usr/bin/env bash
set -euo pipefail

DOCKER_IMAGE="${DOCKER_IMAGE:-guangie88/jupyter-pyspark-toree-addon}"
docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"

TAG_NAME="${JUPYTER_VERSION}_spark-${SPARK_VERSION}_hadoop-${HADOOP_VERSION}${HIVE_TAG_SUFFIX}_pyspark_debian"
FULL_IMAGE_NAME="${DOCKER_IMAGE}:${TAG_NAME}"
docker push "${FULL_IMAGE_NAME}"

# Alternative tags
WITHOUT_JUPYTER_VERSION_IMAGE="${DOCKER_IMAGE}:spark-${SPARK_VERSION}_hadoop-${HADOOP_VERSION}${HIVE_TAG_SUFFIX}_pyspark_debian"
docker tag "${FULL_IMAGE_NAME}" "${WITHOUT_JUPYTER_VERSION_IMAGE}"
docker push "${WITHOUT_JUPYTER_VERSION_IMAGE}"
