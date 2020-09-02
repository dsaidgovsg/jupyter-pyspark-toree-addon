# Debian based
ARG BASE_VERSION="v2"
ARG NOTEBOOK_VERSION
ARG SPARK_VERSION
ARG SCALA_VERSION
ARG HADOOP_VERSION
ARG PYTHON_VERSION
ARG HIVE_TAG_SUFFIX

FROM dsaidgovsg/jupyter-pyspark-toree:${BASE_VERSION}_${NOTEBOOK_VERSION}_spark-${SPARK_VERSION}_scala-${SCALA_VERSION}_hadoop-${HADOOP_VERSION}_python-${PYTHON_VERSION}${HIVE_TAG_SUFFIX}_debian

RUN set -euo pipefail && \
    #
    # Additional dev + runtime dependencies
    #
    apt-get update; \
    apt-get install -y --no-install-recommends \
        wget \
        libspatialindex-dev; \
    #
    # Fix pyarrow issues
    #
    # Python 3.8 requires pyarrow>=0.15.* due to Cython build issues
    # But since Python 3.8 doesn't work with PySpark, we still continue to use pyarrow==0.14.*
    # See issue and fix:
    # - https://stackoverflow.com/questions/58273063/pandasudf-and-pyarrow-0-15-0
    # - https://spark.apache.org/docs/2.4.5/sql-pyspark-pandas-with-arrow.html#compatibiliy-setting-for-pyarrow--0150-and-spark-23x-24x
    echo "ARROW_PRE_0_15_IPC_FORMAT=1" >> "${SPARK_HOME}/conf/spark-env.sh"; \
    PYTHON_DEPS=" \
        attrs \
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
        python-dateutil \
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
