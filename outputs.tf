
# Ouput runtime data

output "vm_instances" {
  value = {
    for obj in module.instance : obj.vm_name => obj.access_ip_v4
  }
}
