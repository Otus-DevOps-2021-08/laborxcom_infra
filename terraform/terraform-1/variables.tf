variable "service_account_key_file" {
  description = "Path to the key file"
}
variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "image_id" {
  description = "image id that we use"
}
variable "subnet_id" {
  description = "Subnet id"
}
variable "public_key_path" {
  description = "Ubuntu user public key path"
}
variable "private_key_path" {
  description = "Ubuntu user private key path"
}
#From https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS
variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 2
}
