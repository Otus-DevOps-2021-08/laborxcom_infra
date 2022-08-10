terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    region     = "us-east-1"

    #"<имя бакета>"
    bucket     = "otus-states"

    #"<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
    #key        = "prod/reddit-app.tfstate"
    key        = "reddit-app-prod.tfstate"

    #"<идентификатор статического ключа>"
    # Note the access_key and secret_key should be generated!
    access_key = "YCAJEGqqQOhMJXa2CGrND2nnw"
    # access_key = "o2_aP80ZrvKy_ESlXvl6"
    # access_key = var.access_key
    # Error: Variables not allowed

    # secret_key = var.sec_key
    # Error: Variables not allowed
    # -backend-config="KEY=VALUE" option when running terraform init
    # https://www.terraform.io/language/settings/backends/configuration
    # .../OTUS/DevOps 2022/000 Var/set-tf-vars.sh

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
