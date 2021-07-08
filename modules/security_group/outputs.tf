
# Module outputs

output "default_security_group_names" {
  description = "List of default security group names"
  value = ["default", openstack_compute_secgroup_v2.allow_ssh.name, openstack_compute_secgroup_v2.allow_icmp.name]
}

output "default_security_group_ids" {
  description = "List of default security group IDs"
  value = [openstack_compute_secgroup_v2.allow_ssh.id, openstack_compute_secgroup_v2.allow_icmp.id]
}

