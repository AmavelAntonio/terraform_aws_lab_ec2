Terraform AWS Two-Tier Architecture

This project deploys a simple two-tier environment on AWS using Terraform:

Public EC2 running a web app (Docker)

Private EC2 running MongoDB (Docker)

Full VPC networking (VPC, Subnets, IGW, NAT, Route Tables, SG, NACL)

🏗️ Architecture

VPC: 10.0.0.0/16

Public Subnet → Internet via IGW

Private Subnet → Internet via NAT Gateway

Public EC2 → web application

Private EC2 → MongoDB

Communication only through internal network

🐳 Docker Deployment

Private EC2 (MongoDB):

docker run -d -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=mongouser \
  -e MONGO_INITDB_ROOT_PASSWORD=mongopwd \
  mongo


Public EC2 (Web App):

docker run -d -p 80:5000 \
  -e MONGODB_HOST=<PRIVATE_IP> \
  -e MONGODB_USERNAME=mongouser \
  -e MONGODB_PASSWORD=mongopwd \
  youcanuseyourimagehere

▶️ Deploy
terraform init
terraform apply