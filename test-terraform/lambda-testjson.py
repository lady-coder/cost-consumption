import boto3
import json
import os

def lambda_handler(event, context):
    print(event)
   
    with open(os.path.dirname(os.path.realpath(__file__)) + '/test.json', 'r') as file:
            sampleData = json.loads(file.read())
            #print(sampleData)
    
    t=sampleData['Records'][0]['body']
    print(t)
   # e=json.loads(t)
    results=t['ResultsByTime']
    for record in results:
       print(record)
       print(record['TimePeriod'])
