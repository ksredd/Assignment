

variable "vpc_cidr" {
  default     = "127.10.0.0/16"
  description = "this is VPC VIDR"
}

variable "vpc_tenancy" {
  type        = "string"
  default     = "default"
  description = "this is VPC tenancy"
}

variable "key_pair_name" {
  default     = "new_london"
  description = "the SSH key to use in the EC2 instance"
}

variable "amilinux" {
  type = "map"
  default = {
    eu-west-2 = "ami-00e8b55a2e841be44" # London
  }

}

variable "region" {
  default = "eu-west-2"
}



