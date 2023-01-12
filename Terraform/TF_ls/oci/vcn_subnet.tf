resource "oci_core_vcn" "IB_vcn" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  cidr_block   = "192.168.0.0/24"
  display_name = "IB_VCN"
}

resource "oci_core_subnet" "IB_subnet" {
  #Required
  cidr_block     = "192.168.0.0/25"
  compartment_id = var.compartment_id
  vcn_id         = oci_core_vcn.IB_vcn.id

  #Optional
  availability_domain = local.ad2
  display_name        = "IB_subnet"
}
