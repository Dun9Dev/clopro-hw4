# Кластер Kubernetes
resource "yandex_kubernetes_cluster" "netology_k8s" {
  name        = "netology-k8s-cluster"
  description = "Kubernetes cluster for netology"
  network_id  = data.yandex_vpc_network.main.id

  # Региональный мастер (ноды в трёх разных зонах)
  master {
    version = var.k8s_version
    regional {
      region = "ru-central1"

      location {
        zone      = "ru-central1-a"
        subnet_id = data.yandex_vpc_subnet.public_a.id
      }
      location {
        zone      = "ru-central1-b"
        subnet_id = yandex_vpc_subnet.public_b.id
      }
      location {
        zone      = "ru-central1-d"
        subnet_id = yandex_vpc_subnet.public_d.id
      }
    }
    public_ip = true
  }

  # Сервисный аккаунт для управления кластером
  service_account_id      = yandex_iam_service_account.k8s_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_sa.id

  # Шифрование через KMS ключ
  kms_provider {
    key_id = data.yandex_kms_symmetric_key.bucket_key.id
  }

  depends_on = [
    yandex_vpc_subnet.public_b,
    yandex_vpc_subnet.public_d
  ]
}

# Вывод информации о кластере Kubernetes
output "k8s_cluster_id" {
  description = "Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.netology_k8s.id
}

output "k8s_cluster_external_v4_endpoint" {
  description = "External endpoint of Kubernetes cluster"
  value       = yandex_kubernetes_cluster.netology_k8s.master[0].external_v4_endpoint
}
