
# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

# Create allow SSH security group
resource "openstack_compute_secgroup_v2" "allow_ssh" {
  name        = "${var.NAME}-allow_ssh"
  description = "Allow SSH inbound traffic"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

# Create allow ICMP security group
resource "openstack_compute_secgroup_v2" "allow_icmp" {
  name        = "${var.NAME}-allow_icmp"
  description = "Allow ICMP (Ping)  inbound traffic"

  rule {
    from_port   = -1
    to_port     = -1
    ip_protocol = "icmp"
    cidr        = "0.0.0.0/0"
  }
}


