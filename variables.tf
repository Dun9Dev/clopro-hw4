variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Default availability zone"
  type        = string
  default     = "ru-central1-a"
}

variable "zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]
}

# Параметры MySQL кластера
variable "mysql_version" {
  description = "MySQL version"
  type        = string
  default     = "8.0"
}

variable "mysql_password" {
  description = "MySQL user password"
  type        = string
  sensitive   = true
  default     = "Netology123!"
}

# Параметры Kubernetes кластера (актуальная версия)
variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}
