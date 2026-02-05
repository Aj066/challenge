resource "local_file" "inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    frontend_ip = aws_instance.frontend.public_ip
    backend_ip  = aws_instance.backend.public_ip
  })
  filename = "./../ansible/inventory.ini"
}

output "inventory" {
  value = local_file.inventory.content
}
