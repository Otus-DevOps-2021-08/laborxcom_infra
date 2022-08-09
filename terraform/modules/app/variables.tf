variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable "public_key_path" {
  description = "Ubuntu user public key path"
}
variable "private_key_path" {
  description = "Ubuntu user private key path"
}
variable subnet_id {
  description = "Subnets for modules"
}
variable "puma_port" {
  default = 9292
}
variable "db_url" {
  description = "Database instance ip-address or URL"
}
variable "deploy" {
  description = "Switch for deploing App"
  type        = bool
  default     = false
}
