#data: "resource_type" "resource_name(anything)": {params}
#syntax is similar to Python
#argument "type" 
data "aws_ami" "amiID" {
  most_recent = true

  #filter for finding which
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
#canonical owner
  owners = ["099720109477"]
}
#output is like print where there is a desc like "instance_id"
output "instance_id" {
  description = "AMI ID of Ubuntu"
  value       = data.aws_ami.amiID.id
}