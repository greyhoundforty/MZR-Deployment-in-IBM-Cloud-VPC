resource ibm_is_vpc_address_prefix subnet_prefix {
  count = length(var.cidr_blocks)
  name  = "${var.name}-prefix-${var.zone}"
  zone  = var.zone
  vpc   = var.vpc
  cidr  = var.cidr_blocks[count.index]
}

resource "ibm_is_public_gateway" "gateway" {
  name           = "${var.name}-gateway-${var.zone}"
  vpc            = var.vpc
  zone           = var.zone
  resource_group = var.resource_group_id
}

resource ibm_is_subnet subnet {
  name                     = "${var.name}-subnet-${var.zone}"
  vpc                      = var.vpc
  zone                     = var.zone
  resource_group           = var.resource_group_id
  total_ipv4_address_count = 32
  network_acl              = var.network_acl
  public_gateway           = ibm_is_public_gateway.gateway.id
}

