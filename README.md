
# Jupyter Pyspark Toree Add-On Docker Builder

Python dependencies to install over
[jupyter-pyspark-toree-docker](https://github.com/guangie88/jupyter-pyspark-toree-docker).

Support for Python 2.7 has been removed, due to difficulty in installing
`koalas` (and possibly other packages in the future due to EOL).

## List of Python 3 dependencies installed

- `catboost`
- `folium`
- `keras`
- `koalas`
- `matplotlib`
- `numpy`
- `pandas`
- `plotly`
- `pyarrow`
- `pyjwt`
- `pyproj`
- `rtree`
- `scikit-learn` (`sklearn`)
- `scipy`
- `seaborn`
- `shapely`
- `tensorflow`
- `xgboost`

## How to Apply Travis Template

For Linux user, you can download Tera CLI v0.2 at
<https://github.com/guangie88/tera-cli/releases> and place it in `PATH`.

Otherwise, you will need `cargo`, which can be installed via
[rustup](https://rustup.rs/).

Once `cargo` is installed, simply run `cargo install tera-cli --version=^0.2.0`.
