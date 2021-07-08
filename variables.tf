variable "ENV" {
  type = string 
  default = "test" 
}

# Provider authentication
variable "OPENSTACK_USERNAME" {
  type = string
  default = "admin"
} 

variable "OPENSTACK_TENANT_NAME" {
  type = string
  default = "admin"
} 

variable "OPENSTACK_PASSWORD" {
  type = string
}

variable "OPENSTACK_AUTH_URL" {
  type = string
} 

variable "OPENSTACK_REGION" {
  type = string
  default = "RegionOne" 
} 

# Network configuration 
variable "OPENSTACK_SUBNET_CIDR" {
  type = string
  default = "172.16.1.0/24"
}

# Instance SSH keys
variable "PATH_TO_PRIVATE_KEY" {
  type = string
  default = "./keys/ssh-key" 
}

variable "PATH_TO_PUBLIC_KEY" {
  type = string 
  default = "./keys/ssh-key.pub" 
} 

variable "INSTANCE_USERNAME" {
  type = string 
  default = "ubuntu" 
}

variable "INSTANCE_USER_DATA_PATH" {
  type = string
  default = "./templates/user-data"
}

variable "INSTANCE_ROOT_PASSWORD" {
  type = string
  default = "ubuntu"
}





