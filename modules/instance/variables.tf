variable "NAME" {
  type = string
  default = "test"
}

variable "NETWORK_ID" {
  type = string
}

variable "SUBNET_ID" {
  type = string
}

variable "DUEL_HONED_EXTERNAL_NETWORK" {
  type = bool
  default = false
}

variable "IMAGE_NAME" {
  type = string
  default = "ubuntu 20.04 focal-server-cloudimg-amd64"
}

variable "FLAVOUR_NAME" {
  type = string 
  default = "t1_small"
}

variable "ROOT_DISK_SIZE" {
  type = number 
  default = 20
}

variable "SSH_KEY_PAIR_NAME" {
  type = string
}

variable "USER_DATA_PATH" {
  type = string 
} 

variable "ROOT_PASSWORD" {
  type = string
  default = "ubuntu"
}

variable "SECURITY_GROUP_NAMES" {
  type = list(string)
}

variable "SECURITY_GROUP_IDS" {
  type = list(string)
}
