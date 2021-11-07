resource "yandex_lb_network_load_balancer" "lb" {
  #name = "reddit-app-lb"
  # Ensure load balancer name is unique
  # name = "lb-${random_string.lb_id.result}-Lab_008-reddit-app"
  name = "lb-${var.resource_tags["project"]}-${var.resource_tags["app"]}"
  folder_id                = var.folder_id

  listener {
    name = "Lab_008-reddit-app-lb-listener"
    port = 80
    target_port = 9292
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit_group.id

    healthcheck {
      name = "http-9292"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "reddit_group" {
  name = "reddit-target-group"

  dynamic "target" {
    for_each = yandex_compute_instance.app
    content {
      subnet_id = var.subnet_id
      address = target.value["network_interface"].0.ip_address
    }
  }
}
