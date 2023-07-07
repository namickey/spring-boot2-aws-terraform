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
