variable "oci_tenancy_ocid" {
  description = "OCID of the tenancy"
  type        = string
}

variable "oci_user_ocid" {
  description = "OCID of the user"
  type        = string
}

variable "oci_fingerprint" {
  description = "Fingerprint of the keypair used"
  type        = string
}

variable "oci_private_key_path" {
  description = "Path to OCI private key stored locally"
  type        = string
}

variable "oci_region" {
  description = "An OCI region"
  type        = string
}

variable "vcn_cidr_block" {
  description = "CIDR block"
  type        = string
}

variable "cidr_subnet_1" {
  description = "Subnet 1"
  type        = string
}

variable "instance_hostname" {
  description = "Instance hostname"
  type        = string
}

variable "vcn_dns_label" {
  description = "A DNS label for the VCN"
  type        = string
}

variable "oci_instance_shape" {
  description = "Shape of the oci instance"
  type        = string
}

variable "oci_core_image_id" {
  description = "OCI core image id"
  type        = string
}

variable "oci_instance_ssh_key" {
  description = "Path to public ssh key for the oci instance"
  type        = string
}
