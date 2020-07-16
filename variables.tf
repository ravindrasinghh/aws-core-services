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

#FOR cloudfront and s3
variable "secret_key" {
  default = null
}

variable "bucket_name" {}

variable "origin_path" {
  default = ""
}

variable "cnames" {
  type = list
}

variable "hosted_zone" {}

variable "tags" {
  type    = map
  default = {}
}

variable "comment" {
  default = "Managed by terrablocks"
}

variable "price_class" {
  default = "PriceClass_All"
}

variable "web_acl_id" {
  default = null
}
