# aws-tf-datadog
Terraform module for deploying datadog

It adds the SSM commands - you'll need to run them manually. 
It also sets up the AWS Crawler.

Usage:

module "aws-tf-datadog" {
  source              = ""
  datadog_external_id = ""
}

To setup the AWS Crawler for Datadog, you need to: 

1. Go into Datadog, setup a new AWS Web Services Integration
2. Add the Account number in the AWS Account ID Field
3. Set the AWS Role name as datadog
4. Copy the AWS External ID (generated new each time you set it up)
   By this time, it's probably complaining it can't assume the role. 
5. Set that ID as the datadog_external_id and rerun terraform apply
6. Once the role is created, set the tag with the account name and anything else you like. It should refresh, confirming connection to AWS
7. Finish off by clicking update configuration. 
