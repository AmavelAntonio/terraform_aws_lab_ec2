variable "project_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "lab_vpc_name" {
  description = "The name of the VPC for the lab"
  type        = string
  default     = "lab-01-vpc"
}

variable "cidr_block_vpc" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "lab_subnet_pub_name" {
  description = "The name of the public subnet for the lab"
  type        = string
  default     = "lab01-subnet-pub"
}

variable "lab_subnet_pub_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "lab_subnet_priv_name" {
  description = "The name of the private subnet for the lab"
  type        = string
  default     = "lab01-subnet-priv"
}

variable "lab_subnet_priv_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "lab_igw_name" {
  description = "The name of the Internet Gateway for the lab"
  type        = string
  default     = "lab01-igw"
}

variable "lab_nat_gtw_name" {
  description = "The name of the NAT Gateway for the lab"
  type        = string
  default     = "lab01-nat-gtw"
}

variable "lab_nat_eip_name" {
  description = "The name of the NAT Gateway EIP for the lab"
  type        = string
  default     = "lab01-nat-eip"
}

variable "lab_sg_web_name" {
  description = "The name of the security group for web servers"
  type        = string
  default     = "lab01-sg-web"
}

variable "lab_sg_db_name" {
  description = "The name of the security group for database servers"
  type        = string
  default     = "lab01-sg-db"
}

variable "lab_nacl_web_name" {
  description = "The name of the network ACL for web subnet"
  type        = string
  default     = "lab01_nacl_web"
}

variable "lab_nacl_db_name" {
  description = "The name of the network ACL for database subnet"
  type        = string
  default     = "lab01_nacl_db"
}

variable "key_pair_name" {
  description = "The name of the AWS key pair"
  type        = string
  default     = "lab01-keypair"
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
variable "web_instance_ami" {
  description = "The AMI ID for the web EC2 instance"
  type        = string
  default     = "ami-0ecb62995f68bb549"
}
variable "db_instance_ami" {
  description = "The AMI ID for the database EC2 instance"
  type        = string
  default     = "ami-0ecb62995f68bb549"
}
variable "instance_type" {
  description = "The instance type for EC2 instances"
  type        = string
  default     = "t3.micro"
}
variable "user_data_script_path" {
  description = "The path to the user data script for EC2 instances"
  type        = string
  default     = "./instal-docker.sh"
}

variable "avg_rt_public_name" {
  description = "The name of the public route table"
  type        = string
  default     = "lab_01_pub_rt"
}

variable "avg_rt_private_name" {
  description = "The name of the private route table"
  type        = string
  default     = "lab_01_priv_rt"
}

variable "rt_public_cidrs" {
  description = "The CIDR blocks for route table associations"
  type        = string
  default     = "0.0.0.0/0"
}
variable "rt_private_cidrs" {
  description = "The CIDR blocks for private route table associations"
  type        = string
  default     = "0.0.0.0/0"
}

variable "web_tag_name" {
  description = "The Name tag for web EC2 instance"
  type        = string
  default     = "web_ec2"
}

variable "db_tag_name" {
  description = "The Name tag for database EC2 instance"
  type        = string
  default     = "db_ec2"
}

#
# security group variables
#
variable "lab01_sg_web_ingresses" {
  default = [
    {
      description      = "Acess HTTP",
      from_port        = 80,
      to_port          = 80,
      protocol         = "tcp",
      cidr_blocks      = ["0.0.0.0/0"],
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Web server security group ingress rules"
}

variable "lab01_sg_web_egresses" {
  default = [
    {
      description      = "Acess HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess MongoDB"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Web server security group egress rules"
}

variable "lab01_nacl_publica_ingress" {
  default = [
    # HTTP
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # HTTPs
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # SSH
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    },
    #efemeras
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # DNS
    {
      protocol   = "tcp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # DNS
    {
      protocol   = "udp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }
  ]
  description = "Ingress Rules for Public Network ACL"
}

variable "lab01_nacl_publica_egress" {
  default = [
    #efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas SSH
    {
      protocol   = "tcp"
      rule_no    = 150
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    }
  ]
  description = "Egress Rules for Public Network ACL"
}
variable "lab01_sg_db_ingresses" {
  default = [
    {
      description      = "Acess MongoDB"
      from_port        = 27017
      to_port          = 27017
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Security group ingress rules for database servers"
}

variable "lab01_sg_db_egresses" {
  default = [
    {
      description      = "Acess HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess HTTPs"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess DNS"
      from_port        = 53
      to_port          = 53
      protocol         = "udp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    },
    {
      description      = "Acess SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
  description = "Security group egress rules for database servers"
}

variable "lab01_nacl_privada_ingress" {
  default = [
    # MongoDB
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 27017
      to_port    = 27017
    },
    # SSH
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 22
      to_port    = 22
    },
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    }
  ]
  description = "Ingress Rules for Private Network ACL"
}

variable "lab01_nacl_privada_egress" {
  default = [
    # Portas Efemeras
    {
      protocol   = "tcp"
      rule_no    = 100
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 1024
      to_port    = 65535
    },
    # Portas HTTP
    {
      protocol   = "tcp"
      rule_no    = 110
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 80
      to_port    = 80
    },
    # Portas HTTPs
    {
      protocol   = "tcp"
      rule_no    = 120
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 443
      to_port    = 443
    },
    # Portas DNS
    {
      protocol   = "tcp"
      rule_no    = 130
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    },
    # Portas DNS
    {
      protocol   = "udp"
      rule_no    = 140
      action     = "allow"
      cidr_block = "0.0.0.0/0"
      from_port  = 53
      to_port    = 53
    }
  ]
  description = "Egress Rules for Private Network ACL"
}
