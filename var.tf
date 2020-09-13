variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-2"
}
variable "ami_id" {
  type = map
  default = {
    us-east-2		= "ami-07c8bc5c1ce9598c3"
    us-east-2		= "ami-0f4aeaec5b3ce9152"
  }
}
