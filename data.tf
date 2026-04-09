# Получение информации о существующей сети VPC
data "yandex_vpc_network" "main" {
  name = "main-vpc"
}

# Получение информации о существующей публичной подсети в зоне a
data "yandex_vpc_subnet" "public_a" {
  name = "public"
}

# Получение информации о существующей приватной подсети в зоне a
data "yandex_vpc_subnet" "private_a" {
  name = "private"
}

# Получение информации о существующем KMS ключе
data "yandex_kms_symmetric_key" "bucket_key" {
  name = "bucket-encryption-key"
}
