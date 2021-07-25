terraform {
  required_version = "~> 1"

  required_providers {
    oci = {
      source = "hashicorp/oci"
      version = "~> 4"
    }
  }
  
}

locals {
  compartment_id = var.compartment_id
  name = var.name
  subnets = var.subnets
  
  vcn = local.oci_core_vcn.vcn
}

resource "oci_core_vcn" "vcn" {
  compartment_id = local.compartment_id

  display_name = local.name
  dns_label = local.name
}

module "privates" {
  for_each = { for subnet in local.subnets:
    !subnet.public ? subnet.cidr => subnet : null
  }
  source  = "Terraform-Modules-Lib/subnet-private/oci"
  
  name = each.value.name
  cidr = each.value.cidr
  vcn_id = local.vcn.id
}
