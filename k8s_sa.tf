# Сервисный аккаунт для Kubernetes
resource "yandex_iam_service_account" "k8s_sa" {
  name        = "k8s-service-account"
  description = "Service account for Kubernetes cluster"
}

# Назначение ролей сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "k8s_sa_editor" {
  folder_id = var.yc_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}

# Назначение роли для работы с KMS
resource "yandex_resourcemanager_folder_iam_member" "k8s_sa_kms" {
  folder_id = var.yc_folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_sa.id}"
}

# Вывод ID сервисного аккаунта
output "k8s_service_account_id" {
  description = "Service account ID for Kubernetes"
  value       = yandex_iam_service_account.k8s_sa.id
}
