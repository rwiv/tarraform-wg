terraform {
  required_providers {
    vultr = {
      source = "vultr/vultr"
      version = "2.18.0"
    }
  }
}

provider "vultr" {
  api_key = var.vultr_api_key
  rate_limit = 100
  retry_limit = 3
}

resource "vultr_ssh_key" "wg_ssh_key" {
  name = "wg-ssh-key"
  ssh_key = file("./asset/ssh-keygen.pub")
}

module "firewall" {
  source = "./modules/firewall"
  my_public_ip = var.my_public_ip
}

module "instance" {
  source = "./modules/instance"
  ssh_key_ids = [vultr_ssh_key.wg_ssh_key.id]
  firewall_group_id = module.firewall.group_id
}
