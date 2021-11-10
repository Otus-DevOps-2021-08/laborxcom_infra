variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}
variable "public_key_path" {
  description = "Ubuntu user public key path"
}
variable subnet_id {
description = "Subnets for modules"
}
