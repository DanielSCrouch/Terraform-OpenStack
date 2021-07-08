
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

# Configure the OpenStack Provider
provider "openstack" {
  user_name = var.OPENSTACK_USERNAME
  tenant_name = var.OPENSTACK_TENANT_NAME
  password     = var.OPENSTACK_PASSWORD
  auth_url = var.OPENSTACK_AUTH_URL
  region = var.OPENSTACK_REGION
}

# Create network and subnet 
module "network" {
  source = "./modules/network/"

  NAME = "tf-${var.ENV}" 
} 

# Create SSH key pair
resource "openstack_compute_keypair_v2" ssh-key-pair {
  name       = "tf-${var.ENV}-ssh-key" 
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Create default security groups
module "security_group" {
  source = "./modules/security_group/"

  NAME = "tf-${var.ENV}" 
}

# Create VM instance
module "instance" {
  source = "./modules/instance/"
  count = 12

  NAME = "tf-${var.ENV}-${count.index + 1}"
  NETWORK_ID = module.network.network_id
  SUBNET_ID = module.network.subnet_id
  DUEL_HONED_EXTERNAL_NETWORK = false
  IMAGE_NAME = "ubuntu 20.04 focal-server-cloudimg-amd64"
  FLAVOUR_NAME = "t1_small"
  ROOT_DISK_SIZE = 20
  SSH_KEY_PAIR_NAME = "tf-${var.ENV}-ssh-key"
  ROOT_PASSWORD = var.INSTANCE_ROOT_PASSWORD
  USER_DATA_PATH = var.INSTANCE_USER_DATA_PATH
  SECURITY_GROUP_NAMES = module.security_group.default_security_group_names
  SECURITY_GROUP_IDS = module.security_group.default_security_group_ids
} 


