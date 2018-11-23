# e.g. 2.3.2
ARG SPARK_VERSION=
# e.g. 2 | 3
ARG PYTHON_MAJOR_VERSION=

FROM guangie88/jupyter-pyspark-toree:spark-${SPARK_VERSION}_python-${PYTHON_MAJOR_VERSION}

RUN apk add --no-cache lapack-dev gfortran

# RUN python -m pip install --no-cache-dir \
#     pandas numpy

RUN python -m pip install --no-cache-dir \
    scipy

RUN python -m pip install --no-cache-dir \
    scikit-learn pyproj

RUN python -m pip install --no-cache-dir \
    shapely matplotlib seaborn folium plotly

RUN python -m pip install --no-cache-dir \
    xgboost catboost tensorflow keras pytorch
