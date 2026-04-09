# Кластер MySQL
resource "yandex_mdb_mysql_cluster" "netology_db" {
  name                = "netology-mysql-cluster"
  description         = "MySQL cluster for netology"
  environment         = "PRESTABLE"
  network_id          = data.yandex_vpc_network.main.id
  version             = var.mysql_version
  deletion_protection = true

  resources {
    resource_preset_id = "s2.micro"  # Intel Broadwell, 50% CPU (2 vCPU)
    disk_type_id       = "network-hdd"
    disk_size          = 20          # 20 ГБ
  }

  # Настройки резервного копирования
  backup_window_start {
    hours   = 23
    minutes = 59
  }

  # Хосты в разных подсетях и зонах для отказоустойчивости
  host {
    zone      = "ru-central1-a"
    subnet_id = data.yandex_vpc_subnet.private_a.id
    name      = "mysql-host-a"
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.private_b.id
    name      = "mysql-host-b"
  }

  # Пользователь БД
  user {
    name     = "netology_user"
    password = var.mysql_password
    permission {
      database_name = "netology_db"
      roles         = ["ALL"]
    }
  }

  # База данных
  database {
    name = "netology_db"
  }

  depends_on = [
    yandex_vpc_subnet.private_b
  ]
}

# Вывод информации о кластере MySQL
output "mysql_cluster_id" {
  description = "MySQL cluster ID"
  value       = yandex_mdb_mysql_cluster.netology_db.id
}

output "mysql_hosts" {
  description = "MySQL hosts IP addresses"
  value       = yandex_mdb_mysql_cluster.netology_db.host[*].fqdn
}
