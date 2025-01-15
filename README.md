# Overview

This Terraform project demonstrates the deployment of a simple "Hello World" Google Cloud Function exposed through an HTTP Load Balancer. 

# Prerequisites
1. Google Cloud Platform (GCP) Account

2. Required GCP APIs:
   Enable the following APIs in your GCP project:
      * Cloud Functions API
      * Compute Engine API
      * IAM API
      * Serverless VPC Access API

3. Create a bucket in GCP (will be used to store the terraform state file)

# Terraform Project structure
Modules
1. Cloud Function Module:
   * Deploys the Cloud Function, bucket, archives the code, and creates a service account.
   * The code present in the scripts directory is archived, uploaded to a GCS bucket, and deployed directly to the Cloud Function using the GCS bucket.

2. Load Balancer Module:
   * Configures an HTTP Load Balancer with Serverless Network Endpoint Group (NEG).

3. VPC Module:
   * Sets up a VPC network, a subnet, and a VPC Serverless Connector.

Envs
* The envs folder contains the environment specific json file 

Scripts
* Scripts folder contains the hello world code that gets deployed on the cloud function



# Deployment Instructions
1. Open and login Google Cloud Console

2. Open cloud shell

3. Clone the terraform repository in cloud shell.
   - git clone https://github.com/sumeetmallick/assignment.git

4. cd assignment/terraform

5. cd envs

6. Modify variable definitions for the Terraform resources in **dev.json** file as per your google cloud project accordingly.

7. Initialize Terraform

   - cd ../

   - terraform init -backend-config="bucket=<bucket-name>" -backend-config="prefix=dev-state/" -reconfigure

   - bucket-name: Provide the bucket name which has been created earlier, as part of prerequisites

8. Plan the Deployment

   - terraform plan -var-file=envs/dev.json 

9. Apply the Deployment

   - terraform apply -auto-approve -var-file=envs/dev.json

10. Steps to access “Hello World” application

   - After successful deployment, in GCP go to Network Services → Load Balancer
   - Copy the load balancer IP and open in a browser

Steps to run Terratest:


# How to Destroy the Infrastructure

1. To clean up resources:
   - terraform destroy -auto-approve -var-file=envs/dev.json 
