
# Module outputs

output "network_id" {
  description = "The ID of the Network"
  value = openstack_networking_network_v2.network.id
}

output "subnet_id" {
  description = "The ID of the Subnet"
  value = openstack_networking_subnet_v2.subnet.id
}
