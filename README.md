# Jupyter Pyspark Toree Add-On Docker Builder

Python dependencies to install over
[pjupyter-pyspark-toree-docker](https://github.com/guangie88/jupyter-pyspark-toree-docker).

## List of Python 2 and 3 dependencies installed

- `catboost`
- `folium`
- `keras`
- `matplotlib`
- `numpy`
- `pandas`
- `plotly`
- `pyproj`
- `rtree`
- `scikit-learn`
- `scipy`
- `seaborn`
- `shapely`
- `tensorflow`
- `xgboost`

## Additional JARs added to Spark to enable reading / writing of the following

- GCS
- S3

## Example build and run commands

```bash
SPARK_VERSION=2.4.0

# Build
docker build . \
    --build-arg SPARK_VERSION=${SPARK_VERSION} \
    -t guangie88/jupyter-pyspark-toree-addon:spark-${SPARK_VERSION}

# Run
docker run --rm -it \
    -p 8888:8888 \
    guangie88/jupyter-pyspark-toree-addon:spark-${SPARK_VERSION}
```
