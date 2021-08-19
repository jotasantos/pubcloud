# A best pratice here would be to use a separate .tf file (like myvariables.tf, for example) to define your variables and then another terraform.tfvars file to initialize you variables with default values
resource "oci_core_vcn" "test_vcn" {
  compartment_id = var.compartment_id
  cidr_block     = var.subnet
  display_name   = "jaime-vcn"

}

module "subnet_module" {
  source         = "./subnet_module"
  cidr_block     = var.subnet_AD1
  compartment_id = var.compartment_id
  vcn_id         = "${oci_core_vcn.test_vcn.id}"
  display_name   = "jaime-subnet"
  #security_list_ids = [ oci_core_security_list.WebserverSecList.id ]
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = "${oci_core_vcn.test_vcn.id}"
  display_name   = "IG-test"
}


resource "oci_core_route_table" "test_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = "${oci_core_vcn.test_vcn.id}"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}


data "oci_core_shapes" "test_shapes" {
  #Required
  compartment_id = var.compartment_id
  filter {
    name   = "name"
    values = ["VM.Standard.E3.Flex"]
  }
}
output "myshapename" {
  #value = lookup(data.oci_core_shapes.test_shapes.shapes[0],"name")
  value = data.oci_core_shapes.test_shapes.shapes
}

data "oci_core_images" "test_images" {
  compartment_id           = var.compartment_id
  sort_by                  = "TIMECREATED"
  sort_order               = "DESC"
  operating_system         = "Oracle Linux"
  operating_system_version = "7.9"
}
output "myimages" {
  value = data.oci_core_images.test_images.images[0].id
}

# resource "oci_core_instance" "test_instance" {
#   state        = "RUNNING"
#   display_name = "jaime-test-instance"

#   availability_domain = "OcmC:EU-FRANKFURT-1-AD-1"
#   compartment_id      = var.compartment_id
#   shape               = "VM.Standard.E3.Flex"
#   shape_config {
#     memory_in_gbs = 1
#     ocpus         = 1
#   }
#   create_vnic_details {
#     subnet_id = "${module.subnet_module.subnet_id}"
#   }
#   source_details {
#     source_id   = data.oci_core_images.test_images.images[0].id
#     source_type = "image"
#   }
# }
# resource "oci_core_instance" "test_instance2" {
#   state        = "RUNNING"
#   display_name = "jaime-test-instance2"

#   availability_domain = "OcmC:EU-FRANKFURT-1-AD-1"
#   compartment_id      = var.compartment_id
#   shape               = "VM.Standard.E4.Flex"
#   shape_config {
#     memory_in_gbs = 1
#     ocpus         = 1
#   }
#   create_vnic_details {
#     subnet_id = "${module.subnet_module.subnet_id}"
#   }
#   source_details {
#     source_id   = data.oci_core_images.test_images.images[0].id
#     source_type = "image"
#   }
# }
