module "vpc" {
  source = "git::https://github.com/lip2050/tf-module-vpc.git"

  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]

  env = var.env
  tags = var.tags
  default_vpc_id = var.default_vpc_id
  default_vpc_rt = var.default_vpc_rt
}

module "app_server" {
  source = "git::https://github.com/lip2050/tf-module-app.git"
  env = var.env
  tags = var.tags
  component = "test"
  subnet_id = lookup(lookup(lookup(lookup(module.vpc,"main", null ), "subnet_ids", null ), "app", null), "subnet_ids", null)[0]
  vpc_id = lookup(lookup(module.vpc,"main", null ), "vpc_id", null )
}