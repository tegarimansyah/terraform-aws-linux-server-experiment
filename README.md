# Terraform AWS Linux Server Experiment

This will create a new Linux Server and set up using init script or ansible. This module also create a new ephemeral ssh key (only for this instance), security group and let you add a a custom script from file(s).

This module is heavily inspired by Hashicorp Packer, but instead of creating an instance for building an AMI, I need to create it for experiment purpose, e.g. Try some open source software in clean state.