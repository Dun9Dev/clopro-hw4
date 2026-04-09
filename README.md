# Домашнее задание: Кластеры. Ресурсы под управлением облачных провайдеров - Выполнил Daniil Shestovskikh

## Описание проекта

В рамках домашнего задания создана инфраструктура в Yandex Cloud с использованием Terraform:

- **MySQL кластер**: отказоустойчивый кластер баз данных с репликацией
- **Kubernetes кластер**: региональный кластер с шифрованием через KMS
- **Группа узлов**: автомасштабируемая группа (min=3, max=6)

## Требования

- Terraform >= 1.0
- Yandex Cloud аккаунт
- Утилиты: kubectl, yc CLI

## Развертывание

### 1. Клонирование репозитория

```bash
git clone https://github.com/Dun9Dev/clopro-hw4.git
cd clopro-hw4
```

### 2. Настройка переменных

Создайте файл `terraform.tfvars`:

```hcl
yc_token     = "ваш_oauth_токен"
yc_cloud_id  = "ваш_cloud_id"
yc_folder_id = "ваш_folder_id"
zone         = "ru-central1-a"
```

### 3. Инициализация и применение

```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Результаты

| Вывод | Описание |
|-------|----------|
| `mysql_cluster_id` | ID кластера MySQL |
| `mysql_hosts` | FQDN хостов MySQL |
| `k8s_cluster_id` | ID кластера Kubernetes |
| `k8s_cluster_external_v4_endpoint` | Endpoint для доступа к кластеру |
| `node_group_id` | ID группы узлов |
| `node_group_status` | Статус группы узлов |

## Проверка работы

### 1. Подключение к Kubernetes кластеру

```bash
yc managed-kubernetes cluster get-credentials netology-k8s-cluster --external
kubectl get nodes
kubectl get pods -A
kubectl cluster-info
```

### 2. Параметры MySQL кластера

- **Версия**: MySQL 8.0
- **БД**: `netology_db`
- **Пользователь**: `netology_user`
- **Резервное копирование**: 23:59
- **Защита от удаления**: включена

## Скриншоты

### Terraform output

![terraform output](screenshots/terraform-output.png)

### Узлы Kubernetes

![kubectl nodes](screenshots/kubectl-nodes.png)

### Поды Kubernetes

![kubectl pods](screenshots/kubectl-pods.png)

### Информация о кластере

![kubectl cluster-info](screenshots/kubectl-cluster-info.png)

## Структура файлов

| Файл | Назначение |
|------|------------|
| `provider.tf` | Настройка провайдера Yandex Cloud |
| `variables.tf` | Переменные (токен, cloud_id, folder_id, зоны) |
| `data.tf` | Получение данных о существующей инфраструктуре |
| `subnets.tf` | Создание дополнительных подсетей |
| `mysql.tf` | Кластер MySQL |
| `k8s_sa.tf` | Сервисный аккаунт для Kubernetes |
| `k8s_cluster.tf` | Кластер Kubernetes с шифрованием KMS |
| `k8s_node_group.tf` | Группа узлов с автомасштабированием |
| `outputs.tf` | Выходные переменные |

## Очистка ресурсов

```bash
terraform destroy -auto-approve
```

