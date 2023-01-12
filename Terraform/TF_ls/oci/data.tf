data "oci_identity_availability_domains" "myads" {
  compartment_id = var.compartment_id
}

data "oci_core_images" "test_images" {
  #Required
  compartment_id = var.compartment_id

  #Optional
  //display_name             = "Canonical-Ubuntu-22.04-2022.11.06-0"
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "22.04"

  filter {
    name   = "display_name"
    values = ["Canonical-Ubuntu-22.04-2022.11.06-0"]
    regex  = true
  }
}

 
