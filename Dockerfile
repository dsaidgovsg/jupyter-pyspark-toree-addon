# e.g. 2.4.0
ARG SPARK_VERSION=
FROM guangie88/jupyter-pyspark-toree:spark-${SPARK_VERSION}

ARG PYTORCH_VERSION=0.4.1

RUN set -eux; \
    #
    # Additional dev + runtime dependencies
    #
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        libspatialindex-dev; \
    # Check https://github.com/apache/hadoop/blob/release-2.7.7-RC0/hadoop-project/pom.xml#L658
    # to see the aws-java-sdk version to be used
    # AWS S3 JARs
    wget -O ${SPARK_HOME}/jars/hadoop-aws-2.7.7.jar \
        http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.7/hadoop-aws-2.7.7.jar; \
    wget -O ${SPARK_HOME}/jars/aws-java-sdk-1.7.4.jar \
        http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar; \
    echo "spark.hadoop.fs.s3a.impl    org.apache.hadoop.fs.s3a.S3AFileSystem" >> ${SPARK_HOME}/conf/spark-defaults.conf; \
    # Google Storage JAR
    wget -O ${SPARK_HOME}/jars/gcs-connector-hadoop2-latest.jar \
        https://storage.googleapis.com/hadoop-lib/gcs/gcs-connector-hadoop2-latest.jar; \
    #
    # Common Python dependencies across 2 and 3
    #
    PYTHON_DEPS=" \
        catboost \
        folium \
        keras \
        matplotlib \
        networkx \
        numpy \
        pandas \
        plotly \
        pyproj \
        rtree \
        scikit-learn \
        scipy \
        seaborn \
        shapely \
        tensorflow \
        xgboost \
    "; \
    # Python 2 dependencies installation
    python2 -m pip install --no-cache-dir ${PYTHON_DEPS}; \
    # Python 3 dependencies installation
    python3 -m pip install --no-cache-dir ${PYTHON_DEPS}; \
    #
    # pytorch custom installation
    #
    # python2 --version returns output in stderr for weird reason
    # https://bugs.python.org/issue18338
    PY2V=$(python2 --version 2>&1 | sed -E 's/.+([[:digit:]]+)\.([[:digit:]])+\..+/\1\2/'); \
    python2 -m pip install --no-cache-dir \
        http://download.pytorch.org/whl/cpu/torch-${PYTORCH_VERSION}-cp${PY2V}-cp${PY2V}mu-linux_x86_64.whl torchvision; \
    PY3V=$(python3 --version | sed -E 's/.+([[:digit:]]+)\.([[:digit:]])+\..+/\1\2/'); \
    python3 -m pip install --no-cache-dir \
        http://download.pytorch.org/whl/cpu/torch-${PYTORCH_VERSION}-cp${PY3V}-cp${PY3V}m-linux_x86_64.whl torchvision; \
    #
    # Remove apt cache
    #
    # Remove unnecessary build-time only dependencies
    apt-get remove -y wget; \
    rm -rf /var/lib/apt/lists/*; \
    :
