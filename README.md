# Jupyter Pyspark Toree Add-On Docker Builder

Python dependencies to install over
[jupyter-pyspark-toree-docker](https://github.com/guangie88/jupyter-pyspark-toree-docker).

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
- `scikit-learn` (`sklearn`)
- `scipy`
- `seaborn`
- `shapely`
- `tensorflow`
- `xgboost`

## Generation of `.travis.yml`

This requires `tera-cli`. You may install it via `cargo` command.

Run the following:

```bash
cargo install tera-cli --vers 0.2.0
```

Once installed, to generate the new `.travis.yml` file, run:

```bash
./templates/apply-vars.sh
```

As such, it is generally only necessary to update `vars.yml` to generate for
new Spark builds.
