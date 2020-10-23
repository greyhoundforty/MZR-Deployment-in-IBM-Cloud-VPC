locals {
  zones = [data.ibm_is_zones.regional_zones.zones[0], data.ibm_is_zones.regional_zones.zones[1], data.ibm_is_zones.regional_zones.zones[2]]
}

module "vpc" {
  source            = "./vpc"
  name              = "${var.basename}-vpc"
  resource_group_id = data.ibm_resource_group.group.id
  tags              = var.tags
  zone              = local.zones
}

module "networking" {
  source            = "./network"
  zone              = local.zones
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  network_acl       = module.vpc.vpc_default_acl
}

module "security" {
  source                 = "./security"
  remote_ip              = var.remote_ip
  subnets                = module.networking.cidr
  resource_group_id      = data.ibm_resource_group.group.id
  vpc               = module.vpc.vpc_id
}



module "instance" {
  source            = "./instance"
  zone              = local.zones
  vpc               = module.vpc.vpc_id
  resource_group_id = data.ibm_resource_group.group.id
  name              = var.basename
  subnet_id         = module.networking.subnet_id
  security_group    = module.security.instance_security_group_id
  ssh_key_ids       = [data.ibm_is_ssh_key.key.id]
  tags              = concat(var.tags, ["instance"])
}