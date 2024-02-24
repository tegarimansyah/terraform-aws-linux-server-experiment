data "aws_vpc" "default" {
    default = true
}

data "aws_ami" "ami" {
    most_recent = true
    filter {
        name   = "name"
        values = ["${var.os}"]
    }

    owners = ["099720109477"] # Canonical

}

locals {
    tags = {
        Name = var.research_name
        Project = var.research_name
        Contact = var.researcher_email
    }
    default_vpc_id = data.aws_vpc.default.id
    open_ports = var.open_ports
}