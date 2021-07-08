
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

# Retrieve the external network id
data "openstack_networking_network_v2" "external_network" {
  external = true
}

# Network
resource "openstack_networking_network_v2" "network" {
  name           = var.NAME
  admin_state_up = "true"
}

# Subnet 
resource "openstack_networking_subnet_v2" "subnet" {
  name       = "${var.NAME}-subnet" 
  network_id = openstack_networking_network_v2.network.id
  cidr       = var.OPENSTACK_SUBNET_CIDR
  ip_version = 4
}

# Router with connection to external 'provider' network for internet access 
resource "openstack_networking_router_v2" "router" {
  name                = "${var.NAME}-router" 
  admin_state_up      = true
  external_network_id = data.openstack_networking_network_v2.external_network.id 
  enable_snat = true
}

resource "openstack_networking_router_interface_v2" "int_1" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet.id
}

# Router route to internal subnet
#resource "openstack_networking_router_route_v2" "router_route_1" {
#  depends_on       = [openstack_networking_router_interface_v2.int_1]
#  router_id        = openstack_networking_router_v2.router.id
#  destination_cidr = 
#  next_hop         = 
#}


