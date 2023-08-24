module "vpc" {
  source = "git::https://github.com/lip2050/tf-module-vpc.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]

}