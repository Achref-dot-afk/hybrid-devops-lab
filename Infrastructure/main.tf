resource "random_pet" "name" {
    length    = 2
    separator = "-"
} // generate a random name for the resources

resource "random_integer" "name" {
  max = 9999
  min = 1000
}

resource "random_pet" "f" {
  length = 5
  separator = "-"
}