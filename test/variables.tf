variable "instance_type1" {
  description = "value"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "prod" = "t2.medium"
  }
  
}

variable "ami_id1" {
  description = "value"
  default = "ami-0e35ddab05955cf57"
  type = string
}

variable "subnet_id1" {
  description = "value"
  type = string
  default = "subnet-024c2b3185c14e6bd"
}
