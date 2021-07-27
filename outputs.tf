output "vcn" {
  value = local.vcn
  description = "Provides the oci_core_vcn resource in Oracle Cloud Infrastructure Core service."
}

output "subnets" {
  value = merge({ for subnet in module.public_subnets:
    subnet.subnet.id => subnet.subnet
  }, { for subnet in module.private_subnets:
    subnet.subnet.id => subnet.subnet
  })
}
