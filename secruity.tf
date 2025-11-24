resource "aws_security_group" "lab01_sg_web" {
  name        = "lab01-sg-web"
  description = "Setting firewall rules for web server"
  vpc_id      = aws_vpc.lab_01_vpc.id

  dynamic "ingress" {
    for_each = var.lab01_sg_web_ingresses
    content {
      description      = ingress.value["description"]
      from_port        = ingress.value["from_port"]
      to_port          = ingress.value["to_port"]
      protocol         = ingress.value["protocol"]
      cidr_blocks      = ingress.value["cidr_blocks"]
      ipv6_cidr_blocks = ingress.value["ipv6_cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = var.lab01_sg_web_egresses

    content {
      description      = egress.value["description"]
      from_port        = egress.value["from_port"]
      to_port          = egress.value["to_port"]
      protocol         = egress.value["protocol"]
      cidr_blocks      = egress.value["cidr_blocks"]
      ipv6_cidr_blocks = egress.value["ipv6_cidr_blocks"]
    }
  }
  tags = {
    Name = "lab01-sg-web"
  }
}

resource "aws_network_acl" "lab01_nacl_web" {
  vpc_id     = aws_vpc.lab_01_vpc.id
  subnet_ids = [aws_subnet.lab_01_subnet_pub.id]

  dynamic "ingress" {
    for_each = var.lab01_nacl_publica_ingress
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.lab01_nacl_publica_egress
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }
  tags = {
    Name = "lab01_nacl_web"
  }
}

resource "aws_security_group" "lab01_sg_db" {
  name        = "lab01-sg-db"
  description = "Setting firewall rules for database"
  vpc_id      = aws_vpc.lab_01_vpc.id
  # INGRESS
  ingress {
    description = "SSH from public subnet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/24"] # SUA SUBNET PÚBLICA
  }

  ingress {
    description = "Allow internet return traffic (ephemeral)"
    from_port   = 1024
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # EGRESS
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lab01-sg-db"
  }
}

resource "aws_network_acl" "lab01_nacl_db" {
  vpc_id     = aws_vpc.lab_01_vpc.id
  subnet_ids = [aws_subnet.lab_01_subnet_priv.id]

  dynamic "ingress" {
    for_each = var.lab01_nacl_privada_ingress
    content {
      protocol   = ingress.value["protocol"]
      rule_no    = ingress.value["rule_no"]
      action     = ingress.value["action"]
      cidr_block = ingress.value["cidr_block"]
      from_port  = ingress.value["from_port"]
      to_port    = ingress.value["to_port"]
    }
  }

  dynamic "egress" {
    for_each = var.lab01_nacl_privada_egress
    content {
      protocol   = egress.value["protocol"]
      rule_no    = egress.value["rule_no"]
      action     = egress.value["action"]
      cidr_block = egress.value["cidr_block"]
      from_port  = egress.value["from_port"]
      to_port    = egress.value["to_port"]
    }
  }
  tags = {
    Name = "lab01_nacl_db"
  }
}
