terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    region   = "us-east-1"

    #"<имя бакета>"
    bucket = "otus-states"

    #"<путь к файлу состояния в бакете>/<имя файла состояния>.tfstate"
    #key        = "stage/reddit-app.tfstate"
    key = "reddit-app-stage.tfstate"

    #"<идентификатор статического ключа>"
    # Note the access_key and secret_key should be generated!
    access_key = "o2_aP80ZrvKy_ESlXvl6"

    #secret_key = "${var.secret_key}"
    secret_key = "${var.secret_key}"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
