# Get the IP address
output "vm_ip_addr" {
  value = module.vm.vm_ip_addr
  sensitive = false
}

# Get the VM password
output "vm_secret" {
  value = module.vm.vm_secret
  sensitive = true
}