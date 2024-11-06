# aws-cost-consumption-gft-infra
Repo for GFT infra code modules

Ensure python 3.9, pip3, pip is installed in your deployement machine. Run 'pip install -U pip'

Ensure that client-report-storage-master lambda has the SQS trigger of the client added (Ex: arn:aws:sqs:eu-west-2:484165963982:dev-report-delivery-queue)