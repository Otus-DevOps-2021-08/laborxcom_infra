variable "service_account_key_file" {
  description = "Path to the key file"
}
variable "cloud_id" {
  description = "Cloud in YC"
}
variable "folder_id" {
  description = "Folder in YC cloud"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "image_id" {
  description = "image id that we use"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base"
}
variable "subnet_id" {
  description = "Subnet id"
}
variable "public_key_path" {
  description = "appuser user public key path"
}
variable "private_key_path" {
  description = "appuser user private key path"
  # Terraform 0.14 has added the ability to mark variables as sensitive, which helps keep them out of your logs, so you should add sensitive = true
  # sensitive = true
}
#From https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS
variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1
}
