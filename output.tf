output "public_dns" {
  value = aws_instance.research[0].public_dns
  description = "value of the public_dns"
}

output "ssh_key" {
  value = local_sensitive_file.ssh.filename
  description = "path of the ssh private key"
}

output "ssh" {
  value = "ssh -i ${local_sensitive_file.ssh.filename} ubuntu@${aws_instance.research[0].public_dns}"
  description = "ssh command to connect to the instance"
}