# Define variables
variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1a","ap-south-1b"]
}

variable "security_group_name" {
  description = "Security Group Name"
  default     = "vprofile-app-sg"
}

variable "security_group_description" {
  description = "Security Group Description"
  default     = "My Security Group Description"
}

variable "allowed_inbound_ports" {
  description = "Allowed Inbound Ports"
  type        = list(number)
  default     = [22, 80, 8080]
}
variable "ami_id" {
  description ="ami_id for all the instances"
  default      = "ami-0f5ee92e2d63afc18"
}
 
variable "key_pair_name" {
  description = "Key Pair Name"
  default     = "vprofile-app"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}
variable "desired_capacity" {
  description = "Auto Scaling Desired Capacity"
  default     = 2
}

variable "min_size" {
  description = "Auto Scaling Minimum Size"
  default     = 1
}

variable "max_size" {
  description = "Auto Scaling Maximum Size"
  default     = 4
}

variable "load_balancer_name" {
  description = "Load Balancer Name"
  default     = "my-load-balancer"
}

variable "load_balancer_listener_port" {
  description = "Load Balancer Listener Port"
  default     = 80
}

variable "load_balancer_target_port" {
  description = "Load Balancer Target Port"
  default     = 80
}