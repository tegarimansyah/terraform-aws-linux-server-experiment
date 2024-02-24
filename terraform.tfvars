research_name = "bongkar-cloud"
researcher_email = "" # Only for tagging your instance

region        = "us-west-2"
os            = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*" # wildcard will get latest version date
instance_size = "t2.micro"
open_ports     = [22, 80, 443]

# Add custom scripts
only_generate_script = false
custom_scripts = [
  "install_docker.sh",
]