from ast import For
import json
import boto3
import logging
import os
from botocore.exceptions import ClientError

import datetime
from dateutil.relativedelta import relativedelta
startCAU = datetime.date.today() - relativedelta(months=3)
endCAU = datetime.date.today()
startFC = datetime.date.today()
endFC = datetime.date.today() + relativedelta(months=3) 

logger = logging.getLogger(__name__)

def send_queue_message(message):
    sqs = boto3.resource('sqs')
    queue = sqs.get_queue_by_name(QueueName=os.environ['sqs'])
    
    # Create a new message
    response = queue.send_message(MessageBody=json.dumps(message))
    print(response.get('MessageId'))

def lambda_handler(event, context):
    client = boto3.client('ce',region_name=os.environ['region'])
    print("Running forecast report for client ",os.getenv("client_name", default=None))
    ForecastMsg = client.get_cost_forecast(
        TimePeriod={
            'Start': startFC.isoformat(),
            'End' : endFC.isoformat()
        },
        Granularity='MONTHLY',
        Metric = "BLENDED_COST",
    )
    ForecastMsg["report_type"] = "forecast"
    ForecastMsg["client_name"] = os.getenv("client_name", default=None)
    ForecastMsg["project_name"] = os.getenv("project_name", default=None)
    ForecastMsg["description"] = os.getenv("description", default=None)
    ForecastMsg["client_env"] = os.getenv("client_env", default=None)
    ForecastMsg["total_env"] = os.getenv("total_env", default=None)
    ForecastMsg["country"] = os.getenv("country", default=None)
    
    print("Forecast report ",ForecastMsg)
    
    send_queue_message(ForecastMsg)
    
    print("Running usage report for client ",os.getenv("client_name", default=None))
    
    CAUMsg = client.get_cost_and_usage(
        TimePeriod={
            'Start': startCAU.isoformat(),
            'End' : endCAU.isoformat()
        },
        Granularity='MONTHLY',
        Metrics = ["BlendedCost"],
        GroupBy = [
        {
            'Type': 'DIMENSION',
            'Key': 'SERVICE'
        },
        {
            'Type': 'TAG',
            'Key': 'Name'
        }
    ]
    )
    CAUMsg["report_type"] = "usage"
    CAUMsg["client_name"] = os.getenv("client_name", default=None)
    CAUMsg["project_name"] = os.getenv("project_name", default=None)
    CAUMsg["description"] = os.getenv("description", default=None)
    CAUMsg["client_env"] = os.getenv("client_env", default=None)
    CAUMsg["total_env"] = os.getenv("total_env", default=None)
    CAUMsg["country"] = os.getenv("country", default=None)
    
    print("Cost usage report ",CAUMsg)
   
    send_queue_message(CAUMsg)
    
    return {
        'statusCode': 200,
        'forecast': ForecastMsg,
        'usage':CAUMsg
    }