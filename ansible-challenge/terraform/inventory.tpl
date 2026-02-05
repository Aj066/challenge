resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/inventory.ini"

  content = <<EOT
[frontend]
frontend ansible_host=${aws_instance.frontend.public_ip}

[backend]
backend ansible_host=${aws_instance.backend.public_ip}
EOT
}
