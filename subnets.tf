module "private_subnets" {
  for_each = { for subnet in local.prv_subnets: subnet.cidr => subnet }
  source  = "Terraform-Modules-Lib/subnet-private/oci"
  
  name = each.value.name
  cidr = each.value.cidr
  acl = each.value.acl

  vcn_id = local.vcn.id
  nat_gw_id = local.gw.nat.id
  oci_gw_id = local.gw.oci.id
}

module "public_subnets" {
  for_each = { for subnet in local.pub_subnets: subnet.cidr => subnet }
  source  = "Terraform-Modules-Lib/subnet-public/oci"

  name = each.value.name
  cidr = each.value.cidr
  acl = each.value.acl

  vcn_id = local.vcn.id
  internet_gw_id = local.gw.internet.id
}
