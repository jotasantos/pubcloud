# variable "nsg_id" {
#   type        = string
#   description = "OCID of the network security group that the rules will be attached to."
# }

variable "nsg_near_side_id" {
  type    = string
  default = ""
}
variable "nsg_far_side_id" {
  type    = string
  default = ""
}
variable "description" {
  type        = string
  default     = ""

}
variable "egress_description" {
  type        = string
  default     = ""
}
variable "traffic_source" {
  type        = string
  default     = ""
}
variable "traffic_destination" {
  type        = string
  default     = ""
}
variable "destination_type" {
  type    = string
  default = ""
}
variable "source_type" {
  type        = string
  default     = ""
}

variable "protocol" {
  type        = string
  default     = "6"
}
variable "direction" {
  type        = string
  # TODO: Add validation
}

variable "port_range" {
  type        = map(string)
  description = "Port range."
  default     = null
}

variable "stateless" {
  type        = bool
  default     = null
}