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
