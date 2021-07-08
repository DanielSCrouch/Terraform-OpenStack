
# Module outputs

output "access_ip_v4" {
  description = "The first detected Fixed IPv4 address"
  value = openstack_compute_instance_v2.instance.access_ip_v4
}

output "vm_name" {
  description = "The name of the Virtual Machine created" 
  value = var.NAME 
}
