#!/usr/local/bin/python
import json

from numpy import object_

header = {}
url = "https://EC2Co-EcsEl-30PGQBD84MPT-1337546794.eu-west-2.elb.amazonaws.com"


print("hello")
list=["aa","bb","cc"]
s=[]
js ={'TimePeriod': {'Start': '2022-04-28', 'End': '2022-05-01'}, 'Total': {}, 'Groups': [{'Keys': ['AWS CloudTrail', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0', 'Unit': 'USD'}}}, {'Keys': ['AWS Key Management Service', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0.4000000032', 'Unit': 'USD'}}}, {'Keys': ['Amazon Simple Notification Service', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0', 'Unit': 'USD'}}}, {'Keys': ['Amazon Simple Queue Service', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0', 'Unit': 'USD'}}}, {'Keys': ['Amazon Simple Storage Service', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0.0000831495', 'Unit': 'USD'}}}, {'Keys': ['AmazonCloudWatch', 'Name$'], 'Metrics': {'BlendedCost': {'Amount': '0', 'Unit': 'USD'}}}], 'Estimated': False}
for item in list:
    s.append(item)

my_string = ','.join(s)


print(my_string)
