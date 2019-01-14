variable "aws_access_key" {
   description = "Access Key"
}

variable "aws_secret_key" {
   description = "Secret Key"
}

variable "aws_region" {
  description = "AWS region to launch servers"
  default     = "eu-west-1"
}

variable "vpc_cidr_block" {
   description = "CIDR Block"
   default = "10.0.0.0/16"
}

variable "aws_amis" {
  default = "ami-55bdb82c"
}

variable "instance_count" {
   default = "1"
}

variable "instance_type" {
   default = "t2.micro"
}

variable "key_name" {
   description = "Key pair"
   default = "AWS_TESTAccount"
}

variable "subnet_cidr" {
   default = "10.0.1.0/24"
}

variable "route_table_destination_cidr" {
   default = "0.0.0.0/0"
}
