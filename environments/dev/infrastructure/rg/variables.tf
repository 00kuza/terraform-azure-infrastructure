variable "resource_group_name" {
    description = "Name of the Azure resource group."
    type        = string
}

variable "location" {
    description = "Azure region where the resource group will be created."
    type        = string
    default     = "australiasoutheast"
}

variable "tags" {
    description = "Tags to apply to the resource group for cost tracking and governance."
    type        = map(string)
    default     = {}
}
