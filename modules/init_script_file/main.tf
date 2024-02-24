variable "name" {
  type = string
}

variable "files" {
  type = list(string)
}

variable "context" {}

variable "template_dir" {
  default = "."
}

variable "generated_file_dir" {
  default = "scripts/generated"
}

resource "local_file" "init_script" {
  filename = "${var.generated_file_dir}/${var.name}_init.sh"
  content  = join("\n\n", [
    for file in var.files :
    templatefile("${var.template_dir}/${file}", var.context)
  ])
}

output "filename" {
  value = local_file.init_script.filename
}

output "content" {
  value = local_file.init_script.content
}