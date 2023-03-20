// Provider
provider "aws" {
  region = "us-east-1"
  #profile = "default"
}


// Backend
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terraform-923"
    key            = "terraform-923/terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-923"
  }
 }




