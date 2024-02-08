from datetime import datetime

import pandas as pd

if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    print(type(data["lpep_pickup_datetime"]))
    data.columns = (
        data.columns.str.replace('(?<=[a-z])(?=[A-Z])', '_', regex=True).str.lower()
    )
    data = data[data["trip_distance"] > 0]
    data = data[data["passenger_count"] > 0]
    # df = df.assign(lpep_pickup_date=lambda x: (datetime.utcfromtimestamp(x.lpep_pickup_datetime) / 1000).date())
    data["lpep_pickup_date"] = data["lpep_pickup_datetime"].dt.date

    return data


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
    assert "vendor_id" in output.columns
    assert output['passenger_count'].isin([0]).sum() == 0
    assert output["trip_distance"].isin([0]).sum() == 0
