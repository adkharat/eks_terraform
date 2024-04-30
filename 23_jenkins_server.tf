# Password sudo cat /var/lib/jenkins/secrets/initialAdminPassword
resource "aws_instance" "jenkins-server" {
  depends_on    = [module.vpc]
  ami           = "ami-04b70fa74e45c3917" # Need to change based on AWS Region 
  instance_type = "t2.medium"
  subnet_id     = module.vpc.public_subnets[0]
  key_name      = var.ec2_key_name

  # Bootstrap script for Jenkins Ubuntu
  user_data                   = file("Jenkins_server_bootstrap.sh")
  user_data_replace_on_change = true

  vpc_security_group_ids = [aws_security_group.jenkins_server_sg.id]

  tags = {
    Name = "Jenkins server"
  }
}