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

This requires `python3` and `pip`. This will allow the installation of
`jinja2-cli`.

Run the following:

```bash
python3 -m pip install --user jinja2-cli[yaml]
```

Once installed, to generate the new `.travis.yml` file, run:

```bash
./apply-vars.sh
```

As such, it is generally only necessary to update `vars.yml` to generate for
new Spark builds.
