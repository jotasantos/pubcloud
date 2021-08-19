variable "cidr_block" {
}

variable "compartment_id" {
}

variable "vcn_id" {
}

# variable "security_list_ids" {
# }

variable "display_name" {
  default = "jaime-subnet"
}

resource "oci_core_subnet" "test_subnet" {
  cidr_block     = var.cidr_block
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  #security_list_ids = var.security_list_ids
}

output "subnet_id" {
  value = oci_core_subnet.test_subnet.id
}