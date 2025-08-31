resource "azurerm_network_interface" "worker-nic" {
  name                = "worker-nic"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "testconfiguration2"
    subnet_id                     = var.worker_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "worker" {
  name                  = "${var.environment}-jenkins-worker"
  location              = var.location
  resource_group_name   = var.rg_name
  network_interface_ids = [azurerm_network_interface.worker-nic.id]
  vm_size               = "Standard_F2s_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name = "worker"
    admin_username = "jenkins_worker"
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        path     = "/home/jenkins_worker/.ssh/authorized_keys"
        key_data = var.worker_ssh_key
    }
  }
  tags = {
    environment = var.environment
  }
}