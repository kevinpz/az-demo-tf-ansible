# Create the resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-ansible"
  location = "canadacentral"
}

module "vnet" {
  source          = "../../az-pipeline-template-tf-ansible/terraform/vnet"
  location        = azurerm_resource_group.rg.location
  rg_name         = azurerm_resource_group.rg.name
  vnet_name       = "terraform-ansible-vnet"
}

module "vm" {
  source           = "../../az-pipeline-template-tf-ansible/terraform/vm"
  location         = azurerm_resource_group.rg.location
  rg_name          = azurerm_resource_group.rg.name
  kv_rg_name       = "rg-keyvault"
  kv_name          = "kv-mgmt-coffeetimedev"
  kv_secret_name   = "vm-secret"
  subnet_id        = module.vnet.subnet_id
  vm_name          = "vm-terraform-ansible"
  ansible_playbook = "ansible/vm1/playbook.yml"
}

module "vm2" {
  source           = "../../az-pipeline-template-tf-ansible/terraform/vm"
  location         = azurerm_resource_group.rg.location
  rg_name          = azurerm_resource_group.rg.name
  kv_rg_name       = "rg-keyvault"
  kv_name          = "kv-mgmt-coffeetimedev"
  kv_secret_name   = "vm-secret"
  subnet_id        = module.vnet.subnet_id
  vm_name          = "vm-terraform-ansible2"
}