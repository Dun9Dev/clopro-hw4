# Группа узлов Kubernetes
resource "yandex_kubernetes_node_group" "netology_nodes" {
  name        = "netology-node-group"
  description = "Node group for netology Kubernetes cluster"
  cluster_id  = yandex_kubernetes_cluster.netology_k8s.id
  version     = var.k8s_version

  # Размещение нод (для регионального кластера)
  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }

  # Шкалирование (автомасштабирование до 6)
  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }

  # Платформа и ресурсы нод
  instance_template {
    platform_id = "standard-v3"
    resources {
      cores         = 2
      memory        = 4
      core_fraction = 100
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    network_interface {
      nat        = true
      subnet_ids = [data.yandex_vpc_subnet.public_a.id]
    }
  }

  depends_on = [
    yandex_kubernetes_cluster.netology_k8s
  ]
}

# Вывод информации о группе узлов
output "node_group_id" {
  description = "Node group ID"
  value       = yandex_kubernetes_node_group.netology_nodes.id
}

output "node_group_status" {
  description = "Node group status"
  value       = yandex_kubernetes_node_group.netology_nodes.status
}
