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
  
  vcn = oci_core_vcn.vcn
  
  prv_subnets = [ for subnet in local.subnets: subnet if subnet.public == false ]
  pub_subnets = [ for subnet in local.subnets: subnet if subnet.public == true ]
}

resource "oci_core_vcn" "vcn" {
  compartment_id = local.compartment_id

  cidr_blocks = [ for subnet in local.subnets: subnet.cidr ]
    
  display_name = local.name
  dns_label = local.name
}


