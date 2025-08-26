resource "random_pet" "name" {
    length    = 2
    separator = "-"
} // generate a random name for the resources