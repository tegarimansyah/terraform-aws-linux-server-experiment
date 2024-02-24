provider "aws" {
  region = var.region
  default_tags {
    tags = local.tags
  }
}

# ==================
# Create New SSH key, save it to local and upload to AWS
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "ssh" {
  content  = tls_private_key.ssh.private_key_openssh
  filename = "${path.root}/.ssh/id_rsa"
  file_permission = "0600"
}

resource "aws_key_pair" "generated_key" {
  count = var.only_generate_script ? 0 : 1
  key_name   = var.research_name
  public_key = tls_private_key.ssh.public_key_openssh
}

# ==================
# Generate an init script
module "init_script" {
  source = "./modules/init_script_file"
  name   = var.research_name
  generated_file_dir = "scripts/generated"
  template_dir = "scripts"
  files  = var.custom_scripts
  context = {
    # Add any variables that you want to pass to the init script
    research_name = var.research_name
    os            = var.os
  }
}

# ==================
# Create a security group
module "ec2_security_group" {
  source = "./modules/security_group"
  count = var.only_generate_script ? 0 : 1

  name        = "${var.research_name}-sg"
  description = "A security group for ${var.research_name}"
  vpc_id      = local.default_vpc_id

  ingress_rules = [
    for port in local.open_ports : {
      port = port
    }
  ]
  
  egress_rules = [
    { port = 0 }
  ]
}


# ==================
# Create an EC2 instance and attach the SSH key pair
resource "aws_instance" "research" {
  count = var.only_generate_script ? 0 : 1

  ami           = data.aws_ami.ami.id
  instance_type = var.instance_size
  key_name      = aws_key_pair.generated_key[0].key_name

  vpc_security_group_ids = [module.ec2_security_group[0].id]

  connection {
    type     = "ssh"
    user     = "ubuntu" # TODO if Amazon Linux then use ec2-user
    private_key = file(local_sensitive_file.ssh.filename)
    host     = self.public_dns
  }

  provisioner "remote-exec" {
    script = module.init_script.filename
  }
  
}
