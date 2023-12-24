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

resource "vultr_instance" "my_instance" {
  plan = "vc2-1c-1gb"
  region = "icn"
  os_id = 1743
  ssh_key_ids = var.vultr_ssh_key_ids
  firewall_group_id = var.vultr_firewall_group_id
}
