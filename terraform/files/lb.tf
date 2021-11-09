resource "yandex_lb_network_load_balancer" "lb" {
  # Ensure load balancer name is unique
  # name = "lb-${random_string.lb_id.result}-reddit-app"
  name      = "lb-reddit"
  folder_id = var.folder_id

  listener {
    name = "lb-listener-reddit"
    port = 80
    target_port = 9292
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit_group.id

    healthcheck {
      name = "health-http-reddit"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "reddit_group" {
  name      = "reddit-target-group"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.app
    content {
      # subnet_id - (Required) ID of the subnet that targets are connected to.
      # All targets in the target group must be connected to the same subnet within a single availability zone.
      subnet_id = var.subnet_id
      address = target.value["network_interface"].0.ip_address
    }
  }
}
