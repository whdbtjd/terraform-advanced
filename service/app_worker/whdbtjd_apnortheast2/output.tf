output "aws_security_group_ec2_id" {
  description = "helloworker name node security group"
  value       = module.test_application.aws_security_group_ec2_id
}

