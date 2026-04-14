variable "environment" {
    description = "Environment Name"
    type = string
    default = "dev"
}

variable "location" {
    description = "Azure Region"
    type = string 
    default = "australiaeast"
}

variable "project_name" {
    description = "Project name for resource naming"
    type = string
    default = "tflab"
}

variable "tags" {
    description = "Common tags for all resources"
    type = map(string)
    default = {
      Environment = "dev"
      ManagedBy = "Terraform"
      Owner = "Dalton Nguyen"
    }  
}