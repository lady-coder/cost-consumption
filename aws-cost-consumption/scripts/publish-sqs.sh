#!/bin/bash
eventsource=${1}


cli=`aws ce get-cost-and-usage --time-period Start=2022-01-01,End=2022-05-05 --granularity MONTHLY --metrics "BlendedCost" --group-by Type=DIMENSION,Key=SERVICE`

if [ $? == 0 ];
then
    echo "Success. The event source trigger was added successfully"
    echo $cli
else
    echo "Failure. The event source trigger was not successful"
    exit 1
fi


Forecast:
aws ce get-cost-forecast --time-period Start=2022-01-01,End=2022-05-05 --granularity MONTHLY --metric "BLENDED_COST"
