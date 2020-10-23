variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = "au-syd"
}

variable "resource_group" {
  default = "CDE"
}

variable "basename" {
  default = "test-rt"
}

variable "tags" {
  default = ["terraform", "ryantiffany"]
}