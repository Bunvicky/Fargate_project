variable "region" {
  default = "us-east-2"
}
variable "profile" {
  default = "terraform"
}
variable "name" {
  default = "main"
}
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Replace this with your desired CIDR block for the VPC
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b", ]  # Update with your desired AZs
}

variable "public_subnet_cidr" {
  default = "10.0.2.0/24"
}
variable "public_subnets_id" {
  default = "1"
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]  # Example list of CIDR blocks
}


variable "container_port" {
  default = 8080
}

variable "container_environment" {
  default = "pro"
}
variable "container_image" {
  default = "latest"
}

variable "public_subnets" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}



variable "main" {
  description = "Main configuration variables"
  type = object({
    name = string
    // Other attributes related to 'main'
  })
  # You can set default values if needed:
  default = {
    name = "my-main-name"
    // Other default attributes related to 'main'
  }
}


