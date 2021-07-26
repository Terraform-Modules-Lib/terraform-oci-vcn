data "oci_core_services" "oci_services" {
  filter {
    name = "name"
    values = ["^All .* Services In Oracle Services Network"]
    regex = true
  }
}

resource "oci_core_service_gateway" "oci_gw" {
  compartment_id = local.compartment_id
  vcn_id = local.vcn.id

  display_name = local.name

  dynamic "services" {
    for_each = { for service in data.oci_core_services.oci_services.services: 
      service.id => service
    }

    content {
      service_id = services.value.id
    }
  }
}
