# locals {
#   description = "Allow_${local.protocol[var.protocol]}-${var.port_range["min"]}-${var.port_range["max"]}"
# }

# Creates One single rule pair for flows not between zones but to/from Internet or DRG. Outbound.
resource "oci_core_network_security_group_security_rule" "single_outbound_egress" {
  count                     = var.direction == "SINGLE_OUTBOUND" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "SINGLE_OUTBOUND_egress"
  destination               = var.traffic_destination
  destination_type          = "CIDR_BLOCK"
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "single_outbound_ingress" {
  count                     = var.direction == "SINGLE_OUTBOUND" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "SINGLE_OUTBOUND_ingress"
  source                    = var.traffic_destination
  source_type               = "CIDR_BLOCK"
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
# Creates One single rule pair for flows not between zones but to/from Internet or DRG. Inbound.
resource "oci_core_network_security_group_security_rule" "single_inbound_ingress" {
  count                     = var.direction == "SINGLE_INBOUND" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "SINGLE_INBOUND_ingress"
  source                    = var.traffic_source
  source_type               = var.source_type
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "single_inbound_egress" {
  count                     = var.direction == "SINGLE_INBOUND" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "SINGLE_INBOUND_egress"
  destination               = var.traffic_source
  destination_type          = var.source_type
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
# Creates outbound rule-pairs (near-side-NSG) and an inbound rule-pair (far-side-NSG) for specific ports on a given protocol.
resource "oci_core_network_security_group_security_rule" "paired_nsg_outbound" {
  count                     = var.direction == "PAIRED-NSG" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "PAIRED-NSG_near_side_egress"
  destination               = var.nsg_far_side_id
  destination_type          = "NETWORK_SECURITY_GROUP"
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_nsg_outbound_return_traffic" {
  count                     = var.direction == "PAIRED-NSG" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "PAIRED-NSG_near_side_ingress"
  source                    = var.nsg_far_side_id
  source_type               = "NETWORK_SECURITY_GROUP"
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_nsg_inbound" {
  count                     = var.direction == "PAIRED-NSG" ? 1 : 0
  network_security_group_id = var.nsg_far_side_id
  description               = "PAIRED-NSG_far_side_ingress"
  source                    = var.nsg_near_side_id
  source_type               = "NETWORK_SECURITY_GROUP"
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_nsg_inbound_return_traffic" {
  count                     = var.direction == "PAIRED-NSG" ? 1 : 0
  network_security_group_id = var.nsg_far_side_id
  description               = "PAIRED-NSG_far_side_egress"
  destination               = var.nsg_near_side_id
  destination_type          = "NETWORK_SECURITY_GROUP"
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
# Creates outbound rule-pairs (near-side-NSG) and an inbound rule-pair (far-side-NSG) for specific ports on a given protocol.
resource "oci_core_network_security_group_security_rule" "paired_cidr_outbound" {
  count                     = var.direction == "PAIRED-CIDR" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "PAIRED-CIDR_near_side_egress"
  destination               = var.traffic_destination
  destination_type          = "CIDR_BLOCK"
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_cidr_outbound_return_traffic" {
  count                     = var.direction == "PAIRED-CIDR" ? 1 : 0
  network_security_group_id = var.nsg_near_side_id
  description               = "PAIRED-CIDR_near_side_ingress"
  source                    = var.traffic_destination
  source_type               = "CIDR_BLOCK"
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_cidr_inbound" {
  count                     = var.direction == "PAIRED-CIDR" ? 1 : 0
  network_security_group_id = var.nsg_far_side_id
  description               = "PAIRED-CIDR_far_side_ingress"
  source                    = var.traffic_source
  source_type               = "CIDR_BLOCK"
  direction                 = "INGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      destination_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}
resource "oci_core_network_security_group_security_rule" "paired_cidr_inbound_return_traffic" {
  count                     = var.direction == "PAIRED-CIDR" ? 1 : 0
  network_security_group_id = var.nsg_far_side_id
  description               = "PAIRED-CIDR_far_side_egress"
  destination               = var.traffic_source
  destination_type          = "CIDR_BLOCK"
  direction                 = "EGRESS"
  stateless                 = true
  protocol                  = var.protocol
  dynamic "tcp_options" {
    for_each = var.protocol == "6" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
  dynamic "udp_options" {
    for_each = var.protocol == "17" ? [1] : []
    content {
      source_port_range {
        max = var.port_range.max
        min = var.port_range.min
      }
    }
  }
}