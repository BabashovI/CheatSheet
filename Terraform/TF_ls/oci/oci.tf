terraform {
  backend "s3" {
    bucket                      = "tfstate"
    key                         = "IB/IB_terraform.tfstate"
    region                      = "eu-frankfurt-1"
    endpoint                    = "https://frsdevl1ow6a.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    shared_credentials_file     = "./terraform-states_bucket_credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

locals {
  ad2 = data.oci_identity_availability_domains.myads.availability_domains[1]["name"]
}

resource "oci_core_instance" "IB_instance" {
  #Required
  availability_domain = local.ad2
  compartment_id      = var.compartment_id
  shape               = "VM.Standard.E2.1.Micro"
  display_name        = "IB_instance"

  freeform_tags = {
    "owner"      = "IbrahimB"
    "department" = "cloud"
    "purpose"    = "training"
  }
  create_vnic_details {
    subnet_id    = oci_core_subnet.IB_subnet.id
    display_name = "IB vcnic"
  }

  source_details {
    #Required
    source_id   = data.oci_core_images.test_images.images[0].id
    source_type = "image"
  }

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "echo Instance ${self.display_name} public ip ${self.public_ip}>public_ip.txt"
  }
}
