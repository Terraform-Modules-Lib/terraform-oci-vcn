resource "oci_core_internet_gateway" "internet_gw" {
  compartment_id = local.compartment_id
  
  vcn_id = local.vcn.id
  
  display_name = local.name
}
