# e.g. 2.4.0
ARG SPARK_VERSION=
FROM guangie88/jupyter-pyspark-toree:spark-${SPARK_VERSION}

ARG XGBOOST_TAG=v0.81
ARG PYTORCH_VERSION=0.4.1

RUN set -eux; \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    # https://github.com/pypa/pip/issues/3969
    echo "manylinux1_compatible = True" > /usr/lib/python2.7/site-packages/_manylinux.py; \
    echo "manylinux1_compatible = True" > /usr/lib/python3.6/site-packages/_manylinux.py; \
    apk add --no-cache \
        gfortran lapack-dev freetype-dev libpng-dev jpeg-dev libexecinfo-dev \
        hdf5-dev@edge geos-dev@edge \
        git make cmake; \
    # Common Python dependencies across 2 and 3
    PYTHON_DEPS="pandas numpy scipy scikit-learn pyproj \
        shapely seaborn folium plotly matplotlib xgboost \
        rtree keras catboost tensorflow"; \
    # Python 2 dependencies installation
    python2 -m pip install --no-cache-dir ${PYTHON_DEPS}; \
    # Python 3 dependencies installation
    python3 -m pip install --no-cache-dir ${PYTHON_DEPS}; \
    #
    # xgboost dependency for Alpine
    #
    git clone --recursive --depth 1 -b "${XGBOOST_TAG}" https://github.com/dmlc/xgboost.git; \
    cd xgboost; \
    # Alpine does not have some of the symbols by default, need to inject in
    sed -i 's/target_link_libraries(runxgboost ${LINK_LIBRARIES})/target_link_libraries(runxgboost ${LINK_LIBRARIES} execinfo)/' CMakeLists.txt; \
    cmake .; \
    make -j "$(grep -c ^processor /proc/cpuinfo)"; \
    make install; \
    cd ..; \
    rm -rf xgboost; \
    #
    # pytorch dependency for Alpine
    #
    # python2 --version returns output in stderr for weird reason
    # https://bugs.python.org/issue18338
    PY2V=$(python2 --version --version 2>&1 | sed -E 's/.+(2)\.(\d+).+/\1\2/'); \
    python2 -m pip install --no-cache-dir \
        http://download.pytorch.org/whl/cpu/torch-${PYTORCH_VERSION}-cp${PY2V}-cp${PY2V}mu-linux_x86_64.whl torchvision; \
    PY3V=$(python3 --version | sed -E 's/.+(3)\.(\d+).+/\1\2/'); \
    python3 -m pip install --no-cache-dir \
        http://download.pytorch.org/whl/cpu/torch-${PYTORCH_VERSION}-cp${PY3V}-cp${PY3V}m-linux_x86_64.whl torchvision

#RUN apk del git make cmake
