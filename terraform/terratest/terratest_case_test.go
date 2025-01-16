package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestGCPVPCInfrastructure(t *testing.T) {
	t.Parallel()

	// Define Terraform options
	terraformOptions := &terraform.Options{
		TerraformDir: "../", // Path to the VPC module
		Vars: map[string]interface{}{
			"prefix":        "test007",
			"environment":   "dev",
			"region":        "us-central1",
			"storage_class": "STANDARD",
			"project":       "xenon-momentum-441407-q9",
			"entry_point":   "hello_get",
			"ip_cidr_range": "10.0.0.0/16",
			"member":        "allUsers",
		},
	}

	// Clean up resources with "terraform destroy" at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Run "terraform init" and "terraform apply"
	terraform.InitAndApply(t, terraformOptions)

	environment := terraformOptions.Vars["environment"].(string)
	prefix := terraformOptions.Vars["prefix"].(string)

	// Expected resource names
	expectedVPCName := fmt.Sprintf("%s-%s-vpc", environment, prefix)
	expectedConnectorName := fmt.Sprintf("%s-%s-connector", environment, prefix)
	expectedcfName := fmt.Sprintf("%s-%s-cf", environment, prefix)
	expectedbucketName := fmt.Sprintf("%s-%s-bucket", environment, prefix)
	expectedlbName := fmt.Sprintf("%s-%s-lb", environment, prefix)

	// Get outputs
	vpcName := terraform.Output(t, terraformOptions, "vpc_name")
	connectorName := terraform.Output(t, terraformOptions, "connector_name")
	cfName := terraform.Output(t, terraformOptions, "cf_name")
	bucketName := terraform.Output(t, terraformOptions, "bucket_name")
	lbName := terraform.Output(t, terraformOptions, "lb_name")

	// Validate outputs
	assert.Equal(t, expectedVPCName, vpcName)
	assert.Equal(t, expectedConnectorName, connectorName)
	assert.Equal(t, expectedcfName, cfName)
	assert.Equal(t, expectedbucketName,  bucketName)
	assert.Equal(t, expectedlbName,  lbName)
}