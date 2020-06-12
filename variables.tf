variable "region" {
  default     = "us-east-1"
}
variable "tier" {
    default = "dev"
  
}
variable "instance_type" {
  default = "t2.micro"  
}

variable "ami" {
  default = "ami-04763b3055de4860b"  
}

variable "public-key" {
  default = "assort.pub"
}
variable "private-key" {
  default = "assort"
}

variable vpc_cidr_block {
  type = "map"
  default = {
    "dev" = "10.10.0.0/16"
  }
}
variable pub_sub1 {
  type = "map"
  default = {
    "dev" = "10.10.1.0/24"
  }
}
variable pub_sub2{
  type = "map"
  default = {
    "dev"   = "10.10.2.0/24"
    "stage" = "10.20.2.0/24"
    "prod"  = "10.30.2.0/24"
  }
}

variable private_sub1 {
  type = "map"
  default = {
    "dev" = "10.10.3.0/24"
  }
}
variable private_sub2 {
  type = "map"
  default = {
    "dev" = "10.10.4.0/24"
  }
}