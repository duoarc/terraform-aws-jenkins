##################
# VARIABLES
#####################

variable "region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "consul_address" {
  type        = string
  description = "Address of Consul server"
  default     = "127.0.0.1"
}

variable "consul_port" {
  type        = number
  description = "Port Consul server is listening on"
  default     = 8500
}

variable "consul_datacenter" {
  type        = string
  description = "Name of Consul datacenter"
  default     = "dc1"
}

# variable "subnet_count" {
#   type        = number
#   description = "Number of subnets to be created"
#   default     = 2
# }

# variable "cidr_block" {
#   type        = string
#   description = "CIDR block size"
#   default     = "10.0.0.0/16"
# }

# variable "private_subnets" {
#   type        = list(any)
#   description = "Private Subnets"
# }

# variable "public_subnets" {
#   type        = list(any)
#   description = "Public Subnets"
# }

##################################
# APPLICATION VARIABLES
##################################

variable "ip_range" {
  default = "0.0.0.0/0"
}

variable "rds_username" {
  type        = string
  description = "RDS user name"
  default     = "ddtuser"
}

variable "rds_password" {
  type        = string
  description = "Password"
  default     = "TerraformIsTheBest1"
}