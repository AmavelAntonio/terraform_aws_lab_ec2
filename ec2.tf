
resource "aws_key_pair" "lab01_keypair" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "web_ec2" {
  ami                         = var.web_instance_ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.lab_01_subnet_pub.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.lab01_sg_web.id]
  key_name                    = aws_key_pair.lab01_keypair.key_name
  user_data                   = file(var.user_data_script_path)

  tags = {
    Name = var.web_tag_name
  }
}

resource "aws_instance" "db_ec2" {
  ami                    = var.db_instance_ami
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.lab_01_subnet_priv.id
  vpc_security_group_ids = [aws_security_group.lab01_sg_db.id]
  key_name               = aws_key_pair.lab01_keypair.key_name
  user_data              = file(var.user_data_script_path)

  tags = {
    Name = var.db_tag_name
  }
}

output "web_ip" {
  value = aws_instance.web_ec2.public_ip
}

output "db_ip" {
  value = aws_instance.db_ec2.private_ip
}