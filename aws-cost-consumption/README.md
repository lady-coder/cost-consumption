# AWS Cost Consumption
AWS Cost Consumption uses terraform for provisioning infrastructure in customer AWS accounts. You'll create an *tfvars* Terraform file, which provides the necessary input that triggers the workflow for cost consumption provisioning and reporting.

For more information on the solution, see https://confluence.gft.com/display/ECSUK/AWS+Cloud+Consumption+Tool

## Getting started

This guide is intended for administrators of AWS Cost Consumption tool who wish to set up the infrastructure in customer environment. 

## Configure and launch your AWS Cost Consumption Tooling

**Step 1**: Identify the primary region used by customer accounts and confirm that lambda exists in the same region in GFT AWS account

**Step 2**: Collect input variables (below) from client teams and configure tfvars

**Step 3**: Ensure you have valid AWS account credentials from client teams

**Step 4**: Setup the Terraform environment and backend state file location

**Step 5**: Provision resources in client AWS infrastucture

**Step 6**: Ensure all resources are created succesfully, record the outputs

**Step 7**: Record errors if provisioning fails 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | Client AWS primary region | `string` | - | yes |
| client_name | Name of the customer | `string` | - | yes |
| project_name | Name of the Client Project | `string` | - | yes |
| schedule | Report Schedule Frequency | `string` | quarterly | yes |
| project_description | Brief description | `string` | - | yes |
| client_env | Environment where the tool is provisioned | `string` | - | yes |
| total_client_env | Total number of AWS accounts | `number` | - | yes |
| install_date | Today's date | `string` | - | no |
| cross_account_role | Role permission | `string` | "arn:aws:iam::798680644831:role/cross-account-lambda-sqs-role"  | yes |
| prefix | Prefix used in client resources (eg: lch-sno-prod)| `string` | - | yes |
| country | Country where project is developed (Ex: spain, poland)| `string` | - | yes |