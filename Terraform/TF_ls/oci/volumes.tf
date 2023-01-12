# resource "oci_core_volume" "ibrahim_volume" {
#   compartment_id      = var.compartment_id
#   availability_domain = data.oci_identity_availability_domains.myads.availability_domains[1]["name"]
#   display_name        = "IB_TF_volume"
#   size_in_gbs         = "50"
# }
