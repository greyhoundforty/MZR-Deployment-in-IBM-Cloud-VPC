data "ibm_is_zones" "regional_zones" {
  region = var.region
}

# data "ibm_is_vpc" "vpc" {
#   name = "custom-prefix-vpc"
# }

data "ibm_resource_group" "group" {
  name = var.resource_group
}