# e.g. 2.3.2
ARG SPARK_VERSION=

FROM guangie88/jupyter-pyspark-toree:spark-${SPARK_VERSION}

RUN echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache lapack-dev gfortran geos-dev@edge

# RUN python -m pip install --no-cache-dir \
#     pandas numpy

# RUN python -m pip install --no-cache-dir \
#     scipy

# RUN python -m pip install --no-cache-dir \
#     scikit-learn pyproj

RUN python -m pip install --no-cache-dir \
    shapely seaborn folium plotly

RUN python -m pip install --no-cache-dir \
    matplotlib

RUN python -m pip install --no-cache-dir \
    xgboost catboost tensorflow keras pytorch
