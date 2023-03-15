# Terraform Oracle Cloud single instance

Terraform Oracle Cloud single instance

## Intro

This manual is dedicated to create OCI core instance in Oracle cloud

## Requirements

- Hashicorp terraform recent version installed
[Terraform installation manual](https://learn.hashicorp.com/tutorials/terraform/install-cli)

- git installed
[Git installation manual](https://git-scm.com/download/mac)

- Created SSH key pair for Linux instance
[Creating a ssh key pair](https://docs.oracle.com/en-us/iaas/Content/GSG/Tasks/creatingkeys.htm)


## Preparation

### Clone git repository

```bash
git clone https://github.com/antonakv/tf-oci-single-instance.git
```

```bash
Cloning into 'tf-oci-single-instance'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (12/12), done.
remote: Total 12 (delta 1), reused 3 (delta 0), pack-reused 0
Receiving objects: 100% (12/12), done.
Resolving deltas: 100% (1/1), done.
```

- Change folder to tf-oci-single-instance

```bash
cd tf-oci-single-instance
```

### Configure access for provider

- Login to Oracle Cloud

- Open Profile

- Open My Profile

- Click to API keys

- Click Add api key

- Select Generate API key pair

- Click Download public key

- Click Download private key

- Click Add

- Copy generated values and save them

- Create file terraform.tfvars with following contents

```
oci_user_ocid        = "your_value_here"
oci_fingerprint      = "your_value_here"
oci_tenancy_ocid     = "your_value_here"
oci_region           = "eu-amsterdam-1"
oci_private_key_path = "/folder/oci_key_path.pem"
vcn_cidr_block       = "10.6.0.0/16"
instance_hostname    = "test1"
vcn_dns_label        = "vcn1"
cidr_subnet_1        = "10.6.1.0/24"
oci_instance_shape   = "VM.Standard.A1.Flex"
oci_core_image_id    = "ocid1.image.oc1.eu-amsterdam-1.Image_ID_here"
oci_instance_ssh_key = "/folder/ssh_instance_key_path.pub"

```

## Run the terraform code

- Init terraform providers

```bash
terraform init
```

Sample result

```bash
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/local versions matching "2.4.0"...
- Finding latest version of hashicorp/random...
- Finding hashicorp/template versions matching "2.2.0"...
- Finding oracle/oci versions matching "4.111.0"...
- Installing hashicorp/local v2.4.0...
- Installed hashicorp/local v2.4.0 (signed by HashiCorp)
- Installing hashicorp/random v3.4.3...
- Installed hashicorp/random v3.4.3 (signed by HashiCorp)
- Installing hashicorp/template v2.2.0...
- Installed hashicorp/template v2.2.0 (signed by HashiCorp)
- Installing oracle/oci v4.111.0...
- Installed oracle/oci v4.111.0 (signed by a HashiCorp partner, key ID 1533A49284137CEB)

Partner and community providers are signed by their developers.
If youd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/cli/plugins/signing.html

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

- Run terraform apply

```bash
terraform apply
```

Expected result:

```
$ terraform apply --auto-approve

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
 <= read (data resources)

Terraform will perform the following actions:

  # data.oci_core_images.image will be read during apply
  # (config refers to values not yet known)
 <= data "oci_core_images" "image" {
      + compartment_id           = (known after apply)
      + id                       = (known after apply)
      + images                   = (known after apply)
      + operating_system         = "Oracle Linux"
      + operating_system_version = "9"
      + shape                    = "VM.Standard.A1.Flex"
      + sort_by                  = "TIMECREATED"
    }

  # data.oci_identity_availability_domains.test1 will be read during apply
  # (config refers to values not yet known)
 <= data "oci_identity_availability_domains" "test1" {
      + availability_domains = (known after apply)
      + compartment_id       = (known after apply)
      + id                   = (known after apply)
    }

  # oci_core_instance.test1 will be created
  + resource "oci_core_instance" "test1" {
      + availability_domain                 = (known after apply)
      + boot_volume_id                      = (known after apply)
      + capacity_reservation_id             = (known after apply)
      + compartment_id                      = (known after apply)
      + dedicated_vm_host_id                = (known after apply)
      + defined_tags                        = (known after apply)
      + display_name                        = (known after apply)
      + fault_domain                        = (known after apply)
      + freeform_tags                       = (known after apply)
      + hostname_label                      = (known after apply)
      + id                                  = (known after apply)
      + image                               = (known after apply)
      + ipxe_script                         = (known after apply)
      + is_pv_encryption_in_transit_enabled = (known after apply)
      + launch_mode                         = (known after apply)
      + metadata                            = {
          + "ssh_authorized_keys" = <<-EOT
                ssh-rsa AAAABXXXXXXXXXXXXXXXXX
            EOT
        }
      + preserve_boot_volume                = false
      + private_ip                          = (known after apply)
      + public_ip                           = (known after apply)
      + region                              = (known after apply)
      + shape                               = "VM.Standard.A1.Flex"
      + state                               = (known after apply)
      + subnet_id                           = (known after apply)
      + system_tags                         = (known after apply)
      + time_created                        = (known after apply)
      + time_maintenance_reboot_due         = (known after apply)

      + agent_config {
          + are_all_plugins_disabled = (known after apply)
          + is_management_disabled   = (known after apply)
          + is_monitoring_disabled   = (known after apply)

          + plugins_config {
              + desired_state = (known after apply)
              + name          = (known after apply)
            }
        }

      + availability_config {
          + is_live_migration_preferred = (known after apply)
          + recovery_action             = (known after apply)
        }

      + create_vnic_details {
          + assign_private_dns_record = true
          + assign_public_ip          = "true"
          + defined_tags              = (known after apply)
          + display_name              = (known after apply)
          + freeform_tags             = (known after apply)
          + hostname_label            = (known after apply)
          + private_ip                = (known after apply)
          + skip_source_dest_check    = (known after apply)
          + subnet_id                 = (known after apply)
          + vlan_id                   = (known after apply)
        }

      + instance_options {
          + are_legacy_imds_endpoints_disabled = (known after apply)
        }

      + launch_options {
          + boot_volume_type                    = (known after apply)
          + firmware                            = (known after apply)
          + is_consistent_volume_naming_enabled = (known after apply)
          + is_pv_encryption_in_transit_enabled = (known after apply)
          + network_type                        = (known after apply)
          + remote_data_volume_type             = (known after apply)
        }

      + platform_config {
          + are_virtual_instructions_enabled               = (known after apply)
          + is_access_control_service_enabled              = (known after apply)
          + is_input_output_memory_management_unit_enabled = (known after apply)
          + is_measured_boot_enabled                       = (known after apply)
          + is_memory_encryption_enabled                   = (known after apply)
          + is_secure_boot_enabled                         = (known after apply)
          + is_symmetric_multi_threading_enabled           = (known after apply)
          + is_trusted_platform_module_enabled             = (known after apply)
          + numa_nodes_per_socket                          = (known after apply)
          + percentage_of_cores_enabled                    = (known after apply)
          + type                                           = (known after apply)
        }

      + preemptible_instance_config {
          + preemption_action {
              + preserve_boot_volume = (known after apply)
              + type                 = (known after apply)
            }
        }

      + shape_config {
          + baseline_ocpu_utilization     = (known after apply)
          + gpu_description               = (known after apply)
          + gpus                          = (known after apply)
          + local_disk_description        = (known after apply)
          + local_disks                   = (known after apply)
          + local_disks_total_size_in_gbs = (known after apply)
          + max_vnic_attachments          = (known after apply)
          + memory_in_gbs                 = 24
          + networking_bandwidth_in_gbps  = (known after apply)
          + nvmes                         = (known after apply)
          + ocpus                         = 4
          + processor_description         = (known after apply)
        }

      + source_details {
          + boot_volume_size_in_gbs = "50"
          + boot_volume_vpus_per_gb = (known after apply)
          + source_id               = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaxxxxxxxxxxxxxx"
          + source_type             = "image"
        }
    }

  # oci_core_subnet.test1 will be created
  + resource "oci_core_subnet" "test1" {
      + availability_domain        = (known after apply)
      + cidr_block                 = "10.6.1.0/24"
      + compartment_id             = (known after apply)
      + defined_tags               = (known after apply)
      + dhcp_options_id            = (known after apply)
      + display_name               = (known after apply)
      + dns_label                  = "vcn1"
      + freeform_tags              = (known after apply)
      + id                         = (known after apply)
      + ipv6cidr_block             = (known after apply)
      + ipv6cidr_blocks            = (known after apply)
      + ipv6virtual_router_ip      = (known after apply)
      + prohibit_internet_ingress  = (known after apply)
      + prohibit_public_ip_on_vnic = (known after apply)
      + route_table_id             = (known after apply)
      + security_list_ids          = (known after apply)
      + state                      = (known after apply)
      + subnet_domain_name         = (known after apply)
      + time_created               = (known after apply)
      + vcn_id                     = (known after apply)
      + virtual_router_ip          = (known after apply)
      + virtual_router_mac         = (known after apply)
    }

  # oci_core_vcn.test1 will be created
  + resource "oci_core_vcn" "test1" {
      + byoipv6cidr_blocks               = (known after apply)
      + cidr_block                       = "10.6.0.0/16"
      + cidr_blocks                      = (known after apply)
      + compartment_id                   = (known after apply)
      + default_dhcp_options_id          = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_list_id         = (known after apply)
      + defined_tags                     = (known after apply)
      + display_name                     = (known after apply)
      + dns_label                        = "vcn1"
      + freeform_tags                    = (known after apply)
      + id                               = (known after apply)
      + ipv6cidr_blocks                  = (known after apply)
      + ipv6private_cidr_blocks          = (known after apply)
      + is_ipv6enabled                   = false
      + is_oracle_gua_allocation_enabled = (known after apply)
      + state                            = (known after apply)
      + time_created                     = (known after apply)
      + vcn_domain_name                  = (known after apply)

      + byoipv6cidr_details {
          + byoipv6range_id = (known after apply)
          + ipv6cidr_block  = (known after apply)
        }
    }

  # oci_identity_compartment.test1 will be created
  + resource "oci_identity_compartment" "test1" {
      + compartment_id = (known after apply)
      + defined_tags   = (known after apply)
      + description    = "test1 compartment"
      + freeform_tags  = (known after apply)
      + id             = (known after apply)
      + inactive_state = (known after apply)
      + is_accessible  = (known after apply)
      + name           = (known after apply)
      + state          = (known after apply)
      + time_created   = (known after apply)
    }

  # random_string.friendly_name will be created
  + resource "random_string" "friendly_name" {
      + id          = (known after apply)
      + length      = 4
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = false
      + numeric     = false
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + oci_core_instance_test1_public_ip = (known after apply)
random_string.friendly_name: Creating...
random_string.friendly_name: Creation complete after 0s [id=bbvu]
oci_identity_compartment.test1: Creating...
oci_identity_compartment.test1: Still creating... [10s elapsed]
oci_identity_compartment.test1: Creation complete after 19s [id=ocid1.compartment.oc1..aaaaaaaaxxxxxxxxxxxxxx]
data.oci_core_images.image: Reading...
data.oci_identity_availability_domains.test1: Reading...
oci_core_vcn.test1: Creating...
data.oci_identity_availability_domains.test1: Read complete after 0s [id=IdentityAvailabilityDomainsDataSource-880350283]
data.oci_core_images.image: Read complete after 0s [id=CoreImagesDataSource-2679037012]
oci_core_vcn.test1: Creation complete after 1s [id=ocid1.vcn.oc1.eu-amsterdam-1.aaaaaaaaxxxxxxxxxxxxxx]
oci_core_subnet.test1: Creating...
oci_core_subnet.test1: Creation complete after 2s [id=ocid1.subnet.oc1.eu-amsterdam-1.aaaaaaaaxxxxxxxxxxxxxx]
oci_core_instance.test1: Creating...
oci_core_instance.test1: Still creating... [10s elapsed]
oci_core_instance.test1: Still creating... [20s elapsed]
oci_core_instance.test1: Still creating... [30s elapsed]
oci_core_instance.test1: Still creating... [40s elapsed]
oci_core_instance.test1: Creation complete after 46s [id=ocid1.instance.oc1.eu-amsterdam-1.aaaaaaaaxxxxxxxxxxxxxx]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

oci_core_instance_test1_public_ip = "1.2.3.4"
```
