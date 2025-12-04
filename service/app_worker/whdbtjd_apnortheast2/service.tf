module "test_application"{

    source = "../app_module/_module"

    service_name = "whdbtjd-test-app"

    service_port = 8080
    healthcheck_port = 8080

    shard_id = data.terraform_remote_state.vpc.outputs.shard_id
    public_subnets = data.terraform_remote_state.vpc.outputs.public_subnets
    private_subnets = data.terraform_remote_state.vpc.outputs.private_subnets
    aws_region = data.terraform_remote_state.vpc.outputs.aws_region
    vpc_cidr_numeral = data.terraform_remote_state.vpc.outputs.cidr_numeral
    target_vpc = data.terraform_remote_state.vpc.outputs.vpc_id
    vpc_name = data.terraform_remote_state.vpc.outputs.vpc_name
    billing_tag = data.terraform_remote_state.vpc.outputs.billing_tag

    lb_variables = var.lb_variables
    sg_variables = var.sg_variables

    ext_lb_ingress_cidrs = [
        "0.0.0.0/0"
    ]

    key_name = "Terraform"
    
}