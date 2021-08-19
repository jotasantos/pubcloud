provider "oci" {
  tenancy_ocid = var.tenancy_ocid
  #compartment_ocid = "foo"
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}