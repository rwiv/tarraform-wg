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
