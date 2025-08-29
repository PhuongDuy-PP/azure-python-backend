variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "python-backend"
}

variable "environment" {
  description = "The environment (dev, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

locals {
  tags = {
    Environment = var.environment
    Project     = var.project_name
    Terraform   = "true"
  }
}
