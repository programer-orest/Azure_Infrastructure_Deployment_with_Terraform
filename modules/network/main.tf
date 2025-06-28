resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["${var.vnet_address_prefix}"]
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["${var.subnet_address_prefix}"]
}

resource "azurerm_network_security_group" "example" {
  name                = var.network_security_group_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "0.0.0.0/0"
    destination_address_prefix = "*"
  }
}

resource "random_integer" "random_dns_id" {
  max = 999999
  min = 100000

  keepers = {
    test_name = "${var.dns_label}"
  }
}

resource "azurerm_public_ip" "example" {
  name                = var.public_ip_address_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.dns_label}${random_integer.random_dns_id.result}"
}