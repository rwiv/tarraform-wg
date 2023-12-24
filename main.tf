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

  provisioner "local-exec" {
    command = "echo http://${self.main_ip}:51821 > wg_url.txt"
  }

  connection {
    type     = "ssh"
    user     = "root"
    private_key  = file("ssh-keygen")
    host     = self.main_ip
  }

  provisioner "file" {
    source      = "script.sh"
    destination = "/root/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /root/script.sh",
      "/root/script.sh ${self.main_ip}",
    ]
  }
}
