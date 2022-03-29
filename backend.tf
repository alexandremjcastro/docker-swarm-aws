terraform {
  required_version = ">=0.13.1"
  required_providers {
    aws   = ">=3.54.0"
    local = ">=2.1.0"
  }
  backend "s3" {
    bucket = "" # Nome do bucket para armazenar o arquivo de estado do terraform
    key    = "nome-exemplo.tfstate" # Nome do arquivo de estado do terraform
    region = "us-east-1" # Região de provisionamento do ambiente
  }
}

provider "aws" {
  region = "us-east-1" # Região de provisionamento do ambiente
}