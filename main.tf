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
  nat_addr_id = var.nat_addr_id
  
  vcn = oci_core_vcn.vcn
  
  nat_addr = try(data.oci_core_public_ip.nat_addr[0], oci_core_public_ip.nat_addr[0])
  gw = {
    internet = oci_core_internet_gateway.internet_gw
    nat = oci_core_nat_gateway.nat_gw
    oci = oci_core_service_gateway.oci_gw
  }
  
  prv_subnets = [ for subnet in local.subnets: subnet if subnet.public == false ]
  pub_subnets = [ for subnet in local.subnets: subnet if subnet.public == true ]
}

resource "oci_core_vcn" "vcn" {
  compartment_id = local.compartment_id

  cidr_blocks = [ for subnet in local.subnets: subnet.cidr ]
    
  display_name = local.name
  dns_label = local.name
}


