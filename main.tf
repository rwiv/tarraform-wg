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

resource "vultr_firewall_group" "wg_firewall_group" {
    description = "wg firewall group"
}

resource "vultr_firewall_rule" "ssh_firewall_rule" {
    firewall_group_id = vultr_firewall_group.wg_firewall_group.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = var.my_public_ip
    subnet_size = 32
    port = "22"
}

resource "vultr_firewall_rule" "udp_firewall_rule" {
    firewall_group_id = vultr_firewall_group.wg_firewall_group.id
    protocol = "udp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "51820"
}

resource "vultr_firewall_rule" "tcp_firewall_rule" {
    firewall_group_id = vultr_firewall_group.wg_firewall_group.id
    protocol = "tcp"
    ip_type = "v4"
    subnet = "0.0.0.0"
    subnet_size = 0
    port = "51821"
}

resource "vultr_instance" "my_instance" {
  plan = "vc2-1c-1gb"
  region = "icn"
  os_id = 1743
  ssh_key_ids = [vultr_ssh_key.wg_ssh_key.id]
  firewall_group_id = vultr_firewall_group.wg_firewall_group.id

  provisioner "local-exec" {
    command = "echo http://${self.main_ip}:51821 > wg_url.txt"
  }

  connection {
    type     = "ssh"
    user     = "root"
    private_key  = file("./asset/ssh-keygen")
    host     = self.main_ip
  }

  provisioner "file" {
    source      = "./asset/script.sh"
    destination = "/root/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /root/script.sh",
      "/root/script.sh ${self.main_ip}",
    ]
  }
}
