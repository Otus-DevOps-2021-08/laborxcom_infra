# Spied in the repo of bergentroll
locals {
  instance_ip_list     = yandex_compute_instance.app[*].network_interface[0].nat_ip_address
  provisioning_ip_list = var.deploy ? local.instance_ip_list : []
  provisioning_ip_set  = toset(local.provisioning_ip_list)
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "appuser:${file(var.public_key_path)}}"
  }
}

resource "null_resource" "deploy" {
  count = length(local.provisioning_ip_list)


  connection {
    type = "ssh"
    #From https://learn.hashicorp.com/tutorials/terraform/variables?in=terraform/configuration-language&utm_source=WEBSITE&utm_medium=WEB_IO&utm_offer=ARTICLE_PAGE&utm_content=DOCS
    #host        = yandex_compute_instance.app[count.index].network_interface.0.nat_ip_address
    #host        = self.network_interface.0.nat_ip_address
    host        = local.provisioning_ip_list[count.index]
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    #source      = "files/puma.service"
    content = templatefile(
      "${path.module}/files/puma.service",
      {
        puma_port = var.puma_port
        db_url    = var.db_url
      }
    )
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }

  depends_on = [
    yandex_compute_instance.app
  ]
}
