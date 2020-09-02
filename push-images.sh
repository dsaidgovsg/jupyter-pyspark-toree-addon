#!/usr/bin/env bash
set -euo pipefail

docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"

IMAGE_NAME="${IMAGE_NAME:-jupyter-pyspark-toree-addon}"

# Reestablish variables
HIVE_TAG_SUFFIX="$(if [ "${WITH_HIVE}" = "true" ]; then echo _hive; fi)"

TAG_NAME="${SELF_VERSION}_${NOTEBOOK_VERSION}_spark-${SPARK_VERSION}_scala-${SCALA_VERSION}_hadoop-${HADOOP_VERSION}_python-${PYTHON_VERSION}${HIVE_TAG_SUFFIX}_debian"
docker tag "${IMAGE_NAME}:${TAG_NAME}" "${IMAGE_ORG}/${IMAGE_NAME}:${TAG_NAME}"
docker push "${IMAGE_ORG}/${IMAGE_NAME}:${TAG_NAME}"

ALT_TAG_NAME="${NOTEBOOK_VERSION}_spark-${SPARK_VERSION}_scala-${SCALA_VERSION}_hadoop-${HADOOP_VERSION}_python-${PYTHON_VERSION}${HIVE_TAG_SUFFIX}_debian"
docker tag "${IMAGE_NAME}:${TAG_NAME}" "${IMAGE_ORG}/${IMAGE_NAME}:${ALT_TAG_NAME}"
docker push "${IMAGE_ORG}/${IMAGE_NAME}:${ALT_TAG_NAME}"
