resource "random_string" "lower" {
  length           = 4
  lower = true
  upper = false
  special = false
}
