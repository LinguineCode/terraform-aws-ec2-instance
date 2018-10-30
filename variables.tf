variable "ami" {}

variable "disable_api_termination" {
  default = false
}

variable "key_name" {
  default = ""
}

variable "type" {}
variable "subnet_id" {}

variable "userdata" {
  default = ""
}
variable "tags" { type = "map" }
variable "vpc_security_group_ids" {
  type = "list"
}
