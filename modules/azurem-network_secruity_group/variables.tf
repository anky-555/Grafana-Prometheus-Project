variable "network_security_group" {
    description = "Map of network security groups with their configurations"
    type = map(object({
        name                = string
        location            = string
        resource_group_name = string
    }))
  
}
variable "security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  
}