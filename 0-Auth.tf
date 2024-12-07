provider "aws" {
  region = "ap-northeast-1"
}
################################################################################
provider "aws" {
  alias = "sa-east-1"
  region = "sa-east-1" 
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "tls" {}