output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}
output "internal_ip_address_db" {
  value       = module.db.internal_ip_address
}

output "app_image" {
  value = module.app.image_name
}

output "db_image" {
  value = module.db.image_name
}

output "load_balancer_ip" {
  description = "Load balancer IPv4"
  value       = module.lb.listener_ip
}

output "app_url" {
  description = "Application URL"
  value       = module.lb.app_url
}
