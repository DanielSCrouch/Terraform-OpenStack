
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

# Retrieve image ID from the name 
data "openstack_images_image_v2" "image" {
  name = var.IMAGE_NAME
  most_recent = true
}

# Retrieve flavour ID from the name
data "openstack_compute_flavor_v2" "flavour" {
  name = var.FLAVOUR_NAME
}

# Retrieve the external network id 
data "openstack_networking_network_v2" "external_network" {
  external = true
}

# Create port for VM to connect to  associated with network, security group,  fixed ip
resource "openstack_networking_port_v2" "port_1" {
  name               = "${var.NAME}-port1"
  network_id         = var.NETWORK_ID
  admin_state_up     = "true"
  security_group_ids = var.SECURITY_GROUP_IDS

  fixed_ip {
    subnet_id  = var.SUBNET_ID
  }
}

# Create port for VM to connect to  associated with network, security group,  fixed ip
# Interface connected to provider network, for duel honed instance (not used) 
resource "openstack_networking_port_v2" "port_2" {
  name               = "${var.NAME}-port2"
  network_id         = data.openstack_networking_network_v2.external_network.id
  admin_state_up     = "true"
  security_group_ids = var.SECURITY_GROUP_IDS
}

# Virtual machine instance booted from volume 
resource "openstack_blockstorage_volume_v2" "volume" {
  name = "${var.NAME}-volume"
  size = var.ROOT_DISK_SIZE
  image_id = data.openstack_images_image_v2.image.id
}

resource "openstack_compute_instance_v2" "instance" {
  name            = "${var.NAME}" 
  #image_id = data.openstack_images_image_v2.image.id
  flavor_id = data.openstack_compute_flavor_v2.flavour.id
  key_pair = var.SSH_KEY_PAIR_NAME
  security_groups = var.SECURITY_GROUP_NAMES
  user_data = data.template_file.user_data.rendered

  metadata = {
    terraformCreated = timestamp() 
  }

  network {
    port = "${openstack_networking_port_v2.port_1.id}"
  }
  
  dynamic "network" {
    for_each = var.DUEL_HONED_EXTERNAL_NETWORK == false ? [] : [1]
    content {
      port = "${openstack_networking_port_v2.port_2.id}" 
    }
  }

  block_device {
    uuid = openstack_blockstorage_volume_v2.volume.id
    source_type = "volume" 
    boot_index = 0
    destination_type = "volume" 
    delete_on_termination = true
  }
}

#resource "openstack_compute_volume_attach_v2" "attached" {
#  instance_id = "${openstack_compute_instance_v2.instance.id}"
#  volume_id   = "${openstack_blockstorage_volume_v2.volume.id}"
#}

