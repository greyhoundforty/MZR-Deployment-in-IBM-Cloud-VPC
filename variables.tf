variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = "au-syd"
}

variable "resource_group" {
  default = "CDE"
}

variable "basename" {
  default = ""
}

variable "tags" {
  default = ["terraform", "ryantiffany"]
}

variable "remote_ip" {
  description = "Remote IP that will be allowed to access Bastion host."
  type        = string
  default     = ""

}

variable "ssh_key" {
  default = ""
}
