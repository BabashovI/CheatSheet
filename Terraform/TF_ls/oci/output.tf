output "my_ads" {
  value = data.oci_identity_availability_domains.myads.availability_domains[*].name
}

output "core_images" {
  value = data.oci_core_images.test_images.images[0].display_name
}

output "public_ip" {
  value = oci_core_instance.IB_instance.public_ip
}
