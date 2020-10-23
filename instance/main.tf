resource "ibm_is_instance" "instance" {
  count = var.instance_count

  name           = "${var.name}-${count.index + 1}"
  vpc            = var.vpc
  zone           = var.zone
  resource_group = var.resource_group_id
  profile        = var.profile_name
  image          = data.ibm_is_image.image.id
  keys           = var.ssh_key_ids

  # inject dns config
  user_data = file("${path.module}/init.sh")

  primary_network_interface {
    subnet = var.vpc_subnets
    security_groups = var.security_groups
  }

  boot_volume {
    name = "${var.name}-${count.index + 1}-boot"
  }

  tags = concat(var.tags, ["vpc"])
}