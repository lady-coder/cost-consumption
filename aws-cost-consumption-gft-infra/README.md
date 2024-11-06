# aws-cost-consumption-gft-infra
Repo for GFT infra code modules

Ensure python 3.9, pip3, pip is installed in your deployement machine. Run 'pip install -U pip'

Ensure that client-report-storage-master lambda has the SQS trigger of the client added (Ex: arn:aws:sqs:eu-west-2:484165963982:dev-report-delivery-queue)

# AWS Cost Consumption GFT infrastructure
AWS Cost Consumption uses terraform for provisioning infrastructure in customer and GFT CC Prod AWS accounts.

For more information on the solution, see https://confluence.gft.com/display/ECSUK/AWS+Cloud+Consumption+Tool

## Getting started

This guide is intended for administrators of AWS Cost Consumption tool who wish to set up the infrastructure in GFT Prod environment. 

## Configure GFT prod infra

Server infrastructure is supported in 3 regions currently, eu-west-1, eu-west-2 and us-east-1. 

***DO NOT RE-DEPLOY GFT infra as this will make the customer deployments go out-of-sync.***

## Add lambda trigger in GFT infra after every client deployment

**Step 1**: Grab the SQS arn output from the client deployment. (Eg: arn:aws:sqs:eu-west-2:522557269087:lch-sno-poc-report-delivery-queue)

**Step 2**: Go to post-deployment-scripts folder and run 'sh sqstrigger.sh sqs-arn'
(Eg: sh sqstrigger.sh arn:aws:sqs:eu-west-2:522557269087:lch-sno-poc-report-delivery-queue)

**Step 3**: Manually check if the trigger is added to the client-report-storage-master lambda from the console 

**Step 4**: Now ask the customer to test the 'client-report-generator' lambda. They must test the lambda twice for both reports to work.

**Step 5**: In GFT infra, check for new entry in client-report-storage-master cloudwatch logs 

**Step 6**: Check the RDS database for new entries in customer, services and forecast tables

