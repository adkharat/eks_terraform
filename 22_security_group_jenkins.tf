# Creating security group for bastion host
resource "aws_security_group" "jenkins_server_sg" {
  name        = "Jenkins server security group"
  description = "Allow Http, SSH reated By Terraform"
  vpc_id      = module.vpc.vpc_id

  #allow inbound SSH traffic from your IP
  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #allow inbound HTTP traffic from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

