output "app_instance_id" {
    value = aws_instance.app_vm.id
}

output "db_instance_id" {
    value = aws_instance.db_vm.id
}