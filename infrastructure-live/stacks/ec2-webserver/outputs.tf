# stacks/ec2-webserver/outputs.tf

output "instance_id" {
  description = "EC2 instance ID"
  value       = module.webserver.instance_id
}

output "private_ip" {
  description = "Private IP address"
  value       = module.webserver.private_ip
}

output "public_ip" {
  description = "Public IP address (if assigned)"
  value       = module.webserver.public_ip
}

output "security_group_id" {
  description = "Security group ID"
  value       = module.webserver.security_group_id
}