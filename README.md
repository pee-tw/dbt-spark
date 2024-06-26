# Pre-requisites
- Java
- Poetry
- Docker

# Data sources
- https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store (Selected for Notebook for large .csv)
- https://www.kaggle.com/datasets/gsimonx37/letterboxd
- https://www.kaggle.com/datasets/olegshpagin/usa-stocks-prices-ohlcv
- https://www.kaggle.com/datasets/jayitabhattacharyya/hotels-details

## Pick your own data to experiment with
- https://www.kaggle.com/datasets?fileType=csv&sizeStart=1%2CGB&page=2&minUsabilityRating=8.00+or+higher
  
# Steps to run the project
- Clone this repository
- Run `poetry install` in the root directory of the project
- Get a dataset of your choice, we use ecommerce data for its shear size
- Once the data has been saved as delta format
- Be sure to kill the Spark spawned from Notebook
- Start docker-compose to expose Spark's thrift server for dbt to utilize
- Create external table within the container's context (Steps below)
- Change directory into dbt-spark
- `poetry run dbt run` to start running dbt

## Creating external tables in container's context
- Connect to Hive with client in container `docker exec -it delta-lake-dbt-spark3-thrift-1 beeline -u "jdbc:hive2://localhost:10000/default" -n root`
- Create external tables by importing the data from delta format
```
CREATE SCHEMA raw;
CREATE SCHEMA rfn;
CREATE SCHEMA ast;

CREATE TABLE raw.ecommerce
USING DELTA
LOCATION '/data/delta/raw/ecommerce';

CREATE TABLE rfn.ecommerce
USING DELTA
LOCATION '/data/delta/rfn/ecommerce';
```

## References
Most of the code here take lots of inspirations from [this awesome blog](https://medium.com/@irshadkt.mec/dbt-spark-with-apache-iceberg-7840e44c25e1)

Most of the Dockerfiles came from this [repo](https://github.com/dbt-labs/dbt-spark)