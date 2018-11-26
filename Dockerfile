# e.g. 2.4.0
ARG SPARK_VERSION=
FROM guangie88/jupyter-pyspark-toree:spark-${SPARK_VERSION}

ARG PYTORCH_VERSION=0.4.1

RUN set -eux; \
    # Common Python dependencies across 2 and 3
    PYTHON_DEPS=" \
        catboost \
        folium \
        keras \
        matplotlib \
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
        http://download.pytorch.org/whl/cpu/torch-${PYTORCH_VERSION}-cp${PY3V}-cp${PY3V}m-linux_x86_64.whl torchvision
