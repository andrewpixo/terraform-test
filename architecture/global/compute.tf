data "local_file" "ec2_setup_script" {
  filename = "${path.module}/scripts/ec2setup.sh"
}

data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }

  owners = [
    "099720109477"]
}


resource "aws_iam_role" "ec2_ecr_access" {
  name = "frontend_ecr_access"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
  tags = {
    project = "terraform-test"
  }
}

resource "aws_iam_role_policy" "ec2_ecr_access" {
  name = "frontend_ecr_access"
  role = aws_iam_role.ec2_ecr_access.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_ecr_access" {
  name = "ecr_access"
  role = aws_iam_role.ec2_ecr_access.name
}

resource "aws_security_group" "ssh" {
  name = "ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = data.aws_vpc.default_vpc.id
  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}
resource "aws_security_group" "http" {
  name = "http"
  description = "Allow HTTP inbound traffic"
  vpc_id = data.aws_vpc.default_vpc.id
  ingress {
    description = "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
}


resource "aws_instance" "backend_instance" {
  instance_type = var.instance_type
  ami = data.aws_ami.ubuntu.id
  user_data = <<-EOF
      #! /bin/bash
      sudo apt update
      sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable"
      sudo apt update
      sudo apt-get install docker-ce
      sudo systemctl start docker
      sudo systemctl enable docker
      sudo groupadd docker
      sudo usermod -aG docker ubuntu
  EOF

  root_block_device {
    volume_size = 8
  }

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_ecr_access.name



  key_name = "backend_key"
  monitoring = true
  disable_api_termination = false

}

resource "aws_instance" "frontend_instance" {
  instance_type = var.instance_type
  ami = data.aws_ami.ubuntu.id
  user_data = <<-EOF
      #! /bin/bash
      sudo apt update && \
      sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable" && \
      sudo apt update && \
      sudo apt-get install -y docker-ce && \
      sudo systemctl start docker && \
      sudo systemctl enable docker && \
      sudo groupadd docker && \
      sudo usermod -aG docker ubuntu
  EOF

  root_block_device {
    volume_size = 8
  }

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.http.id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_ecr_access.name



  key_name = "frontend_key"
  monitoring = true
  disable_api_termination = false
}

resource "aws_key_pair" "frontend_key" {
  key_name = "frontend_key"
  public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_key_pair" "backend_key" {
  key_name = "backend_key"
  public_key = file("~/.ssh/id_rsa.pub")
}