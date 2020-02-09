
# Jupyter Pyspark Toree Add-On Docker Builder

![CI Status](https://img.shields.io/github/workflow/status/guangie88/jupyter-pyspark-toree-addon/CI/master?label=CI&logo=github&style=for-the-badge)

Python dependencies to install over
[jupyter-pyspark-toree-docker](https://github.com/guangie88/jupyter-pyspark-toree-docker).

Support for Python 2.7 has been removed, due to difficulty in installing
`koalas` (and possibly other packages in the future due to EOL).

## List of Python 3 dependencies installed

- `catboost`
- `folium`
- `iso3166`
- `keras`
- `kmodes`
- `koalas`
- `matplotlib`
- `numpy`
- `pandas`
- `pendulum==1.4.4` (Airflow uses 1.4.4)
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

## How to Apply CI Template

For Linux user, you can download Tera CLI v0.2 at
<https://github.com/guangie88/tera-cli/releases> and place it in `PATH`.

Otherwise, you will need `cargo`, which can be installed via
[rustup](https://rustup.rs/).

Once `cargo` is installed, simply run `cargo install tera-cli --version=^0.3.0`.

Always make changes in `templates/ci.yml.tmpl` since the template will be
applied onto `.github/workflows/ci.yml`.

Run `templates/apply-vars.sh` to apply the template once `tera-cli` has been
installed.
