module "vpc" {
  source            = "./vpc"
  name              = "${var.basename}-vpc"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = var.tags
}

# module "gateways" {
#   source            = "./gateway"
#   count             = length(data.ibm_is_zones.regional_zones.zones)
#   zone              = data.ibm_is_zones.regional_zones.zones[count.index]
#   vpc               = module.vpc.vpc_id
#   resource_group_id = data.ibm_resource_group.group.id
#   name              = var.basename
# }

module "networking" {
  source            = "./network"
  count             = length(data.ibm_is_zones.regional_zones.zones)
  zone              = data.ibm_is_zones.regional_zones.zones[count.index]
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  cidr_blocks       = ["172.16.0.0/24", "172.16.64.0/24", "172.16.128.0/24"]
  network_acl       = module.vpc.vpc_default_acl
}

module "instance" {
  source            = "./instance"
  count             = length(data.ibm_is_zones.regional_zones.zones)
  zone              = data.ibm_is_zones.regional_zones.zones[count.index]
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  subnet_id         = module.networking.subnet_id[count.index]
}