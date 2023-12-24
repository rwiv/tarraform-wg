resource "vultr_instance" "my_instance" {
    plan = "vc2-1c-1gb"
    region = "icn"
    os_id = 1743
    ssh_key_ids = var.ssh_key_ids
    firewall_group_id = var.firewall_group_id

    provisioner "local-exec" {
        command = "echo http://${self.main_ip}:51821 > wg_url.txt"
    }

    connection {
        type        = "ssh"
        user        = "root"
        private_key = file("./asset/ssh-keygen")
        host        = self.main_ip
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
