variable "instance_count" {
  type = map(any)
  default = {
    "two"  = 2
    "four" = 4
  }

}
