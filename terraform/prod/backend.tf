terraform {
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    region     = "us-east-1"

    #"<имя бакета>"
    bucket     = "otus-states"

    #"<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
    #key        = "prod/reddit-app.tfstate"
    key        = "reddit-app.tfstate"

    #"<идентификатор статического ключа>"
    # Note the access_key and secret_key should be generated!
    access_key = "o2_aP80ZrvKy_ESlXvl6"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
