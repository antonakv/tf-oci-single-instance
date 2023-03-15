locals {
  friendly_name_prefix = "antonakv-${random_string.friendly_name.id}"
  instance_hostname    = "${random_string.friendly_name.id}${var.instance_hostname}"
}

resource "random_string" "friendly_name" {
  length  = 4
  upper   = false
  numeric = false
  special = false
}

provider "oci" {
  tenancy_ocid     = var.oci_tenancy_ocid
  user_ocid        = var.oci_user_ocid
  private_key_path = var.oci_private_key_path
  fingerprint      = var.oci_fingerprint
  region           = var.oci_region
}

resource "oci_identity_compartment" "test1" {
  description = "test1 compartment"
  name        = "${local.friendly_name_prefix}-test1"
}

resource "oci_core_vcn" "test1" {
  compartment_id = oci_identity_compartment.test1.id
  cidr_block     = var.vcn_cidr_block
  display_name   = "${local.friendly_name_prefix}-test1"
  dns_label      = var.vcn_dns_label
  is_ipv6enabled = false
}

resource "oci_core_subnet" "test1" {
  cidr_block     = var.cidr_subnet_1
  compartment_id = oci_identity_compartment.test1.id
  vcn_id         = oci_core_vcn.test1.id
  display_name   = "${local.friendly_name_prefix}-test1"
  dns_label      = var.vcn_dns_label
}

data "oci_identity_availability_domains" "test1" {
  compartment_id = oci_identity_compartment.test1.id
}

resource "oci_core_instance" "test1" {
  availability_domain = data.oci_identity_availability_domains.test1.availability_domains[0].name
  compartment_id      = oci_identity_compartment.test1.id
  shape               = "VM.Standard.A1.Flex"
  display_name        = "${local.friendly_name_prefix}-test1"
  shape_config {
    ocpus         = 4
    memory_in_gbs = 24
  }
  source_details {
    source_id               = var.oci_core_image_id
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }
  create_vnic_details {
    assign_public_ip          = true
    assign_private_dns_record = true
    display_name              = "${local.friendly_name_prefix}-test1-vnic"
    subnet_id                 = oci_core_subnet.test1.id
  }
  metadata = {
    ssh_authorized_keys = file(var.oci_instance_ssh_key)
  }
  preserve_boot_volume = false
}

data "oci_core_images" "image" {
  compartment_id           = oci_identity_compartment.test1.id
  shape                    = var.oci_instance_shape
  operating_system         = "Oracle Linux"
  operating_system_version = "9"
  sort_by                  = "TIMECREATED"
}

/* output "images" {
  value = data.oci_core_images.image
} */

output "oci_core_instance_test1_public_ip" {
  value = oci_core_instance.test1.public_ip
}
