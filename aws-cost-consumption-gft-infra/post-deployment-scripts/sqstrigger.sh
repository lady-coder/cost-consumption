#!/bin/bash
eventsource=${1}

#Extract lambda region from arn input
region=`echo $eventsource | awk '{split($0,a,":"); print a[4]}'`

echo "Adding SQS trigger to the lambda - $eventsource"
 
cli=`aws lambda --region $region create-event-source-mapping --function-name client-report-storage-master --batch-size 1 --maximum-batching-window-in-seconds 60 --event-source-arn $eventsource`

if [ $? == 0 ];
then
    echo "Success. The event source trigger was added successfully"
    echo $cli
else
    echo "Failure. The event source trigger was not successful"
    exit 1
fi
