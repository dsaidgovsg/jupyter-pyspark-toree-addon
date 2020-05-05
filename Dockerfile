# Debian based
ARG BASE_VERSION="v2"
ARG NOTEBOOK_VERSION
ARG SPARK_VERSION
ARG SCALA_VERSION
ARG HADOOP_VERSION
ARG PYTHON_VERSION
ARG HIVE_TAG_SUFFIX

FROM guangie88/jupyter-pyspark-toree:${BASE_VERSION}_${NOTEBOOK_VERSION}_spark-${SPARK_VERSION}_scala-${SCALA_VERSION}_hadoop-${HADOOP_VERSION}_python-${PYTHON_VERSION}${HIVE_TAG_SUFFIX}_debian

RUN set -euo pipefail && \
    #
    # Additional dev + runtime dependencies
    #
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        libspatialindex-dev; \
    #
    # Common Python dependencies across 2 and 3
    #
    # See issue with pyarrow: https://stackoverflow.com/questions/58273063/pandasudf-and-pyarrow-0-15-0
    PYTHON_DEPS=" \
        catboost \
        folium \
        iso3166 \
        keras \
        kmodes \
        koalas \
        matplotlib \
        networkx \
        numpy \
        pandas \
        pendulum==1.4.4 \
        plotly \
        pyarrow==0.14.* \
        pyjwt \
        pyproj \
        rtree \
        scikit-learn \
        sklearn \
        scipy \
        seaborn \
        shapely \
        tensorflow \
        torch \
        torchvision \
        xgboost \
    "; \
    # Python dependencies installation
    python -m pip install --no-cache-dir ${PYTHON_DEPS}; \
    #
    # Remove apt cache
    #
    # Remove unnecessary build-time only dependencies
    apt-get remove -y wget; \
    rm -rf /var/lib/apt/lists/*; \
    :
