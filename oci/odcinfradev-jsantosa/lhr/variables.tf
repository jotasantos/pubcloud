# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "region" {}
# variable "private_key_path" {}

#variable compartment_id {}
# variable subnet {}
# variable subnet_AD1 {}
# variable subnet_AD2 {}
# variable subnet_AD3 {}

variable "tenancy_ocid" {
  type        = string
  default     = "foo"
  description = "OCID of the OCI tenancy."
}

variable "region" {
  type        = string
  default     = "eu-frankfurt-1"
  description = "OCI region, e.g eu-amsterdam-1"
}

variable "subnet" {
  type        = string
  default     = "10.2.0.0/16"
  description = "subnet"
}
variable "subnet_AD1" {
  type        = string
  default     = "10.2.0.0/24"
  description = "subnet_AD1"
}
variable "compartment_id" {
  type        = string
  default     = "foo"
  description = "OCID of the compartment in OCI."
}
# variable "vcn_cidr" {
#   type        = string
#   description = "CIDR block for the VCN."
# }
variable "subnet_cidr" {
  type        = string
  description = "CIDR block for the subnet to be created inside the VCN."
  default     = "10.2.0.0/16"
}
variable "puppet_slave_public_aws_ip" {
  type        = string
  description = "Public IP address of the Puppet slave instance in the closest AWS region."
}

variable "prometheus_public_aws_ip" {
  type        = string
  description = "Public IP address of the Prometheus instance in the closest AWS region."
}

variable "new_prometheus_public_ip" {
  type = string
}
variable "nsg_near_side_id" {
  type    = string
  default = ""
}
variable "nsg_far_side_id" {
  type = string
}
variable "ccXX_lhr_oci" {
  type = "list"
  default = [
    "10.33.192.40/32", // cc01.lhr.oci
    "10.33.208.10/32", // cc02.lhr.oci
  ]
}

variable "ocna_ranges" {
  type = "list"
  default = [
    "160.34.104.0/21",    // Oracle-OCNA
    "160.34.112.0/20",    // Oracle-OCNA
]
}
variable "aws_ranges" {
  type = "list"
  default = [
    "52.20.132.104/32",
    "34.201.185.42/32",
  ]
}
variable "oci_non_v2_ranges" {
  type = "list"
  default = [
    "18.163.245.214/32",
    "158.101.193.59/32",
  ]
}
variable "odc_legacy_ranges" {
  type = "list"
  default = [
    "185.89.204.0/22",
    "203.190.181.0/24",
    "148.64.56.0/24",
  ]
}

variable "observium_monitored_ips" {
  type = "list"
  default = [
    "10.8.8.65/32",
    "185.89.206.2/32", 
  ]
}