# Дополнительные публичные подсети для Kubernetes (зоны a, b)
resource "yandex_vpc_subnet" "public_b" {
  name           = "public-b"
  zone           = "ru-central1-b"
  network_id     = data.yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

# Дополнительные приватные подсети для MySQL (зоны a, b) с маршрутом через NAT
# Таблица маршрутизации для приватной подсети b
resource "yandex_vpc_route_table" "private_route_b" {
  name       = "private-route-table-b"
  network_id = data.yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}

# Приватная подсеть b с привязанной таблицей маршрутизации
resource "yandex_vpc_subnet" "private_b" {
  name           = "private-b"
  zone           = "ru-central1-b"
  network_id     = data.yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.21.0/24"]
  route_table_id = yandex_vpc_route_table.private_route_b.id
}

# Вывод информации о подсетях
output "subnet_ids" {
  description = "Map of subnet IDs"
  value = {
    public_a = data.yandex_vpc_subnet.public_a.id
    public_b = yandex_vpc_subnet.public_b.id
    private_a = data.yandex_vpc_subnet.private_a.id
    private_b = yandex_vpc_subnet.private_b.id
  }
}


# Публичная подсеть в зоне d для Kubernetes
resource "yandex_vpc_subnet" "public_d" {
  name           = "public-d"
  zone           = "ru-central1-d"
  network_id     = data.yandex_vpc_network.main.id
  v4_cidr_blocks = ["192.168.14.0/24"]
}
