terraform {
  backend "s3" {
    bucket         = "jonathanfel"   # <- CHANGE THIS
    key            = "terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
  }
}
