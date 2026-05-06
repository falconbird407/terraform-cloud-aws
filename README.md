# Terraform Cloud AWS Linux Lab

This project provisions an Ubuntu 24.04 EC2 instance on AWS using:

- Terraform
- Terraform Cloud
- GitHub
- AWS EC2
- AWS SSM Parameter Store

---

# Features

- Latest Ubuntu 24.04 AMI dynamically fetched from AWS SSM
- EC2 instance deployment
- Security Group creation
- SSH access
- HTTP access for future nginx/web testing
- Terraform Cloud integration

---

# Project Structure

terraform-cloud-aws/
│
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── .gitignore
└── README.md

---

# Terraform Cloud Variables

The following Environment Variables must be configured inside Terraform Cloud Workspace:

- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

Both should be marked as Sensitive.

---

# Deployment Workflow

Local VS Code
↓
Git Push
↓
GitHub Repository
↓
Terraform Cloud
↓
AWS Infrastructure Creation

---

# Terraform Commands

terraform init

terraform plan

terraform apply

terraform destroy

---

# SSH Connection

For Ubuntu AMI:

ssh -i falconbird.pem ubuntu@PUBLIC_IP

---

# Security Notes

This project currently allows:

- SSH (22) from anywhere
- HTTP (80) from anywhere

This is acceptable for a personal learning lab but not production-grade security.

Future improvements may include:

- AWS SSM Session Manager
- Restricted SSH access
- Private networking
- Bastion host architecture