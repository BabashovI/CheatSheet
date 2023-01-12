variable "vm_name" {
}

output "name_of_vm" {
  value = var.vm_name
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}

# provider "oci" {
#   tenancy_ocid     = var.tenancy_ocid
#   user_ocid        = var.user_ocid
#   private_key_path = var.private_key_path
#   fingerprint      = var.fingerprint
#   region           = "ap-singapore-1"
#   alias = "apac"
# }

data "oci_identity_availability_domains" "myads" {
  #Required
  compartment_id = var.compartment_ocid
}

output "myads" {
  value = data.oci_identity_availability_domains.myads.availability_domains
}

variable "disk_sizes" {
  default = ["Small", "Medium", "Large"]
}

resource "oci_core_volume" "test_volume" {
  count = 3
  #Required
  compartment_id = var.compartment_ocid
  # availability_domain = "yRxw:EU-FRANKFURT-1-AD-1"
  # availability_domain = data.oci_identity_availability_domains.myads.availability_domains[count.index]["name"]
  availability_domain = element(data.oci_identity_availability_domains.myads.availability_domains, count.index)["name"]

  display_name = "TF Volume ${var.disk_sizes[count.index]}"
  size_in_gbs  = "99"
  # provider = oci.apac
}

locals {
  ad1 = data.oci_identity_availability_domains.myads.availability_domains[1]["name"]
}

resource "oci_core_instance" "tfinstance" {
  #Required
  availability_domain = local.ad1
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard2.1"
  display_name        = "TF Instance"

  create_vnic_details {
    subnet_id    = oci_core_subnet.tfsubnet.id
    display_name = "TF VNIC"
  }

  source_details {
    #Required
    source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaah3kl4yqqnin7sfhvzugbeml24clpmqocusgrbxrhrkxbh5n76awa"
    source_type = "image"
  }

  provisioner "local-exec" {
    command = "echo Instance ${self.display_name} has Public IP address ${self.public_ip} >> instances.txt"
  }
}

data "oci_identity_regions" "test_regions" {
}

resource "oci_core_subnet" "tfsubnet" {
  #Required
  cidr_block     = "10.100.100.0/24"
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.tfvcn.id
  display_name   = "TF Subnet"
}

resource "oci_core_vcn" "tfvcn" {
  #Required
  compartment_id = var.compartment_ocid
  cidr_block     = "10.100.0.0/16"
  display_name   = "TF VCN"
}


terraform {
  backend "s3" {
    bucket     = "tfstate"
    key        = "terraform.tfstate"
    region     = "eu-frankfurt-1"
    endpoint   = "https://frsdevl1ow6a.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    access_key = "bbbaa0a991d855f33e9874cf2cf67d5bf0c68151"
    secret_key = "fK6TJjlcJoHQJZAo6VCwgqQBGTn5Y1Sa3OvK7G7qkW4="
    # shared_credentials_file     = "../terraform-states_bucket_credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}




module "iam_iam-user" {
  source       = "oracle-terraform-modules/iam/oci//modules/iam-user"
  version      = "2.0.2"
  tenancy_ocid = var.tenancy_ocid
  users        = [{ name = "Andrew", description = "terraform user", email = "andrew@oracle.com" }]
}

