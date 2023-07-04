
# 参考：Terraform Cloudの始め方
# https://qiita.com/boccham/items/190f04bfbc9ffc0b5baf

variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "ap-northeast-1"
}

resource "aws_vpc" "green" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "green-vpc"
  }
}

# 参考：Terraformで構築するAWS
# https://y-ohgi.com/introduction-terraform/handson/vpc/

resource "aws_subnet" "pub-1a" {
  vpc_id = "${aws_vpc.green.id}"
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "green-pub-1a"
  }
}

resource "aws_subnet" "pub-1c" {
  vpc_id = "${aws_vpc.green.id}"
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.2.0/24"
  tags = {
    Name = "green-pub-1c"
  }
}

resource "aws_internet_gateway" "green" {
  vpc_id = "${aws_vpc.green.id}"

  tags = {
    Name = "igw-green"
  }
}

resource "aws_route_table" "green" {
  vpc_id = "${aws_vpc.green.id}"

  tags = {
    Name = "green-route"
  }
}

resource "aws_route" "green" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_route_table.green.id}"
  gateway_id             = "${aws_internet_gateway.green.id}"
}

resource "aws_route_table_association" "pub-1a" {
  subnet_id      = "${aws_subnet.pub-1a.id}"
  route_table_id = "${aws_route_table.green.id}"
}

resource "aws_route_table_association" "pub-1c" {
  subnet_id      = "${aws_subnet.pub-1c.id}"
  route_table_id = "${aws_route_table.green.id}"
}

# 参考：terraform構築手順〜EC2編〜
# https://colabmix.co.jp/tech-blog/terraform-ec2/

resource "aws_security_group" "green-sg" {
  name        = "green-sg"
  description = "green-sg"
  vpc_id      = aws_vpc.green.id
  tags = {
    Name = "green-sg"
  }
}

resource "aws_security_group_rule" "inbound_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  security_group_id = aws_security_group.green-sg.id
}

resource "aws_security_group_rule" "inbound_http" {
  type      = "ingress"
  from_port = 8080
  to_port   = 8080
  protocol  = "tcp"
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  security_group_id = aws_security_group.green-sg.id
}

resource "aws_security_group_rule" "outbound_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"
  cidr_blocks = [
    "0.0.0.0/0",
  ]
  security_group_id = aws_security_group.green-sg.id
}

resource "aws_instance" "green" {
  ami                     = "ami-0cfc97bf81f2eadc4"
  instance_type           = "t2.micro"
  disable_api_termination = false
  key_name                = "green"
  vpc_security_group_ids  = [aws_security_group.green-sg.id]
  subnet_id               = aws_subnet.pub-1a.id
  associate_public_ip_address = "true"
  user_data = file("./setup.sh")
  tags = {
    Name = "green"
  }
}

# 参考：TerraformでEC2インスタンスを構築してみた。（Terraform, AWS, EC2）
# https://qiita.com/takahashi-kazuki/items/c2fe3d70e3a9490adf64

output "public_id_of_green" {
  value = "${aws_instance.green.public_ip}"
}

