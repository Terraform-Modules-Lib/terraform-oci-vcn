module "private_subnets" {
  for_each = { for subnet in local.prv_subnets: subnet.cidr => subnet }
  source  = "Terraform-Modules-Lib/subnet-private/oci"
  
  name = each.value.name
  cidr = each.value.cidr
  vcn_id = local.vcn.id
}

module "public_subnets" {
  for_each = { for subnet in local.pub_subnets: subnet.cidr => subnet }
  source  = "Terraform-Modules-Lib/subnet-public/oci"

  name = each.value.name
  cidr = each.value.cidr

  vcn_id = local.vcn.id
  internet_gw_id = local.gw.internet.id
}
