terraform {
  backend "s3" {
    bucket  = "terraform-bucket-bhushan"
    key     = "dev/terraform.tfstate"
    region  = "eu-west-1"
    profile = "tf-user"
    encrypt = true
  }
}
