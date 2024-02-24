variable "research_name" {
  type        = string
  description = "Name of the research"
}

variable "researcher_email" {
  type        = string
  description = "Email of the researcher"
  default     = ""
}

variable "region" {
  type        = string
  description = "Region in which the resources are to be created"
  default     = "us-west-2"
}

variable "os" {
  type        = string
  description = "Operating system to be used for the instance"
  default     = "ubuntu-jammy-22.04-amd64-server"
}

variable "instance_size" {
  type        = string
  description = "Size of the instance"
  default     = "t2.micro"
}

variable "open_ports" {
  type        = list(number)
  default     = [22, 80, 443]
  description = "List of ports to open on the instance, applicable only for security group"
}

variable "only_generate_script" {
    type        = bool
    default     = false
    description = "Flag to indicate if only the init script is to be generated"
}

variable "custom_scripts" {
  type        = list(string)
  default     = []
  description = "Path to custom scripts to be executed on the instance"
}