variable "region" {
  description = "AWS region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "AWS Key Pair name"
  type        = string
}

variable "machine_name" {
  description = "EC2 Name tag"
  type        = string
}

variable "created_by" {
  description = "Creator tag"
  type        = string
}