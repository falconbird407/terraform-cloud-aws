# Terraform Cloud + AWS EC2 DevOps Lab

## Overview

This repository is a personal DevOps and Infrastructure-as-Code learning project focused on building production-minded infrastructure using Terraform Cloud, GitHub, AWS, Linux, and Docker.

The project follows an incremental learning approach where each stage introduces a new infrastructure or automation concept while preserving Git history and infrastructure milestones.

The main goal is to understand how modern infrastructure is provisioned, automated, version-controlled, and maintained using real-world DevOps workflows.

---

# Current Architecture

```text
GitHub
   ↓
Terraform Cloud
   ↓
AWS EC2
   ↓
cloud-init (user_data)
   ↓
Docker Engine
   ↓
nginx Container
```

---

# Version History

## V1 — Initial Infrastructure

Features implemented:

- AWS EC2 provisioning using Terraform
- Terraform Cloud remote execution
- GitHub VCS integration
- Dynamic Ubuntu AMI retrieval using AWS SSM Parameter Store
- SSH access to EC2 instance
- Security Group configuration

Learning focus:

- Terraform basics
- Infrastructure-as-Code concepts
- GitHub integration
- Remote Terraform execution
- AWS networking fundamentals

---

## V2 — Automated EC2 Bootstrap

Features implemented:

- Automatic Docker installation during EC2 boot
- cloud-init bootstrap process using Terraform `user_data`
- Docker service auto-start configuration
- Automatic nginx container deployment
- Docker Compose plugin installation
- Infrastructure replacement on bootstrap changes

Learning focus:

- EC2 initialization process
- cloud-init
- Terraform `user_data`
- Linux package management
- Docker installation automation
- Immutable infrastructure mindset

---

# Repository Structure

```text
terraform-cloud-aws/
│
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── bootstrap.sh
├── README.md
└── .gitignore
```

---

# Terraform Configuration

## EC2 Provisioning

The EC2 instance is provisioned using Terraform Cloud remote execution connected to GitHub.

The infrastructure includes:

- Ubuntu EC2 instance
- Security Group
- Public IP assignment
- SSH access
- Automated bootstrap execution

---

# Bootstrap Process

The file `bootstrap.sh` is executed automatically during the first boot of the EC2 instance through cloud-init using Terraform `user_data`.

The bootstrap process performs the following tasks:

1. Updates Ubuntu package information
2. Installs prerequisite packages
3. Adds Docker’s official repository
4. Installs Docker Engine
5. Installs Docker Compose plugin
6. Enables Docker service
7. Starts Docker service
8. Adds Ubuntu user to Docker group
9. Deploys nginx container automatically

---

# bootstrap.sh Detailed Explanation

The script begins with:

```bash
#!/bin/bash
```

This tells Linux to execute the script using the Bash shell.

The line:

```bash
set -e
```

forces the script to stop immediately if any command fails.

The command:

```bash
apt-get update -y
```

refreshes Ubuntu package indexes.

The command:

```bash
apt-get install -y ca-certificates curl gnupg
```

installs prerequisite packages required for secure package downloads and repository management.

The command:

```bash
install -m 0755 -d /etc/apt/keyrings
```

creates the directory used for repository signing keys.

The command:

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
-o /etc/apt/keyrings/docker.asc
```

downloads Docker’s official GPG key.

The command:

```bash
chmod a+r /etc/apt/keyrings/docker.asc
```

makes the key readable by the system.

The long `echo` command creates Docker’s APT repository configuration dynamically based on system architecture and Ubuntu version.

The second:

```bash
apt-get update -y
```

refreshes package indexes again after adding Docker’s repository.

The command:

```bash
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

installs Docker Engine and related components.

The command:

```bash
systemctl enable docker
```

configures Docker to start automatically after reboot.

The command:

```bash
systemctl start docker
```

starts the Docker service immediately.

The command:

```bash
usermod -aG docker ubuntu
```

adds the Ubuntu user to the Docker group.

Finally:

```bash
docker run -d \
  --name nginx-test \
  --restart unless-stopped \
  -p 80:80 \
  nginx:latest
```

starts an nginx container in detached mode and exposes it publicly on port 80.

---

# Important Terraform Learning

A key lesson during this stage was understanding that Terraform `user_data` generally executes only during the first boot of an EC2 instance.

Because of this behavior, changing bootstrap scripts may require EC2 replacement to rerun cloud-init.

To handle this automatically, the following setting was added:

```hcl
user_data_replace_on_change = true
```

---

# Git Workflow

This project uses a lightweight feature-branch workflow.

## Main branch

`main`

Always contains stable infrastructure versions.

## Feature branches

Examples:

```text
feature/bootstrap-docker
feature/docker-compose
feature/reverse-proxy
```

Each infrastructure stage is developed independently before merging into `main`.

---

# Milestones

| Version | Description |
|---|---|
| v0.1 | EC2 + SSH working |
| v0.2 | Docker bootstrap + nginx working |

---

# Next Steps

Planned learning roadmap:

- Docker Compose
- Multi-container architecture
- Reverse proxy architecture
- Persistent volumes
- Custom Docker networks
- CI/CD pipelines
- Infrastructure automation
- Monitoring and logging
- Ansible
- Kubernetes fundamentals

---

# Technologies Used

- Terraform
- Terraform Cloud
- AWS EC2
- Ubuntu Linux
- Docker
- Docker Compose
- GitHub
- cloud-init

---

# Author

Nima Ziaee

This repository is part of an ongoing DevOps and Infrastructure Automation learning journey.