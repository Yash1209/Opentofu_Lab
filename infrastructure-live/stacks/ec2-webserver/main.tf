# stacks/ec2-webserver/main.tf

# Get default VPC (for demo purposes)
data "aws_vpc" "default" {
  default = true
}

# Get subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Web Server Instance - COMPLIANT CONFIGURATION
module "webserver" {
  # Source from Spacelift private registry
  source  = "spacelift.io/YOUR-ACCOUNT/ec2-instance/aws"
  version = "1.0.0"

  instance_name = "webserver-${var.environment}"
  instance_type = var.instance_type
  environment   = var.environment

  vpc_id    = data.aws_vpc.default.id
  subnet_id = data.aws_subnets.default.ids[0]

  # Security settings
  associate_public_ip = var.environment != "prod"
  enable_monitoring   = true
  root_volume_size    = 20

  # Required tags for policy compliance
  tags = {
    Owner       = var.owner_email
    Application = "webserver"
    CostCenter  = "engineering"
  }
}