locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["app"]}"
}
terraform {
  required_version = "~> 0.12.26"
}
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone.0
}
resource "yandex_compute_instance" "app" {
#  name  = "Lab_008-reddit-app"
  name = "app-${local.name_suffix}"
  count = var.instance_count
#  zone  = var.zone.[count.index]
#  zone  = var.zone.0

  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашем задании
      image_id = var.image_id
    }
  }
  network_interface {
    # Указан id подсети default-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }
  connection {
    type        = "ssh"
    host        = yandex_compute_instance.app[count.index].network_interface.0.nat_ip_address
    user        = "ubuntu"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
