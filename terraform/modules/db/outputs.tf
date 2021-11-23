output "external_ip_address_db" {
  value       = yandex_compute_instance.db.network_interface[0].nat_ip_address
}

output "instance_name" {
  value = yandex_compute_instance.db.name
}

output "internal_ip_address" {
  value = yandex_compute_instance.db.network_interface[0].ip_address
}
