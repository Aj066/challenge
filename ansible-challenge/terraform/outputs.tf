resource "local_file" "ansible_inventory" {
content = templatefile("${path.module}/inventory.tpl", {
frontend_ip = aws_instance.frontend.public_ip
backend_ip = aws_instance.backend.public_ip
})
filename = "${path.module}/../ansible/inventory"
output "inventory" {
  value = local_file.inventory.content
}
}
