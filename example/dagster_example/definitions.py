import os

from dagster import Definitions, StaticPartitionsDefinition, asset, define_asset_job, EnvVar

from dagster_celery import celery_executor

example_partition_def = StaticPartitionsDefinition(
    partition_keys=[str(i) for i in range(1, 32)],
)


@asset(
    partitions_def=example_partition_def,
)
def partitioned_asset():
    print("Hello world!!")

print(os.getenv("DAGSTER_CELERY_BROKER_URL"))

default_executor = celery_executor.configured(
    config_or_config_fn={
        "broker": {
            "env": "DAGSTER_CELERY_BROKER_URL",
        },
        "backend": {
            "env": "DAGSTER_CELERY_BACKEND_URL",
        },
    },
    name="default_celery_executor"
)

partitioned_job = define_asset_job(
    name="partitioned_job",
    partitions_def=example_partition_def,
    selection=[partitioned_asset],
)


definitions = Definitions(
    assets=[partitioned_asset],
    jobs=[partitioned_job],
    executor=default_executor,
)
