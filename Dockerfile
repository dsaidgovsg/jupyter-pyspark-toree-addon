# Debian based
ARG FROM_DOCKER_IMAGE="guangie88/jupyter-pyspark-toree"
ARG FROM_DOCKER_TAG=

FROM ${FROM_DOCKER_IMAGE}:${FROM_DOCKER_TAG}
ARG PYTORCH_VERSION=

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
        keras \
        koalas \
        matplotlib \
        networkx \
        numpy \
        pandas \
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
