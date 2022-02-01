resource "google_compute_instance" "salt_master" {
  name = "poulsen-salt-master"
  machine_type = "e2-standard-2"
  zone = var.zone
  allow_stopping_for_update = true
  depends_on = [google_compute_firewall.allow["ssh"]]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc.id
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_public_key_path)}"
  }
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.network_interface[0].access_config[0].nat_ip
      user = var.user
      timeout = "500s"
      private_key = file(var.ssh_private_key_path)
    }
    script = "install-salt-master.sh"
  }
}

resource "google_compute_instance" "salt_minion" {
  name = "poulsen-salt-minion"
  machine_type = "e2-standard-2"
  zone = var.zone
  allow_stopping_for_update = true
  depends_on = [google_compute_firewall.allow["ssh"]]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = google_compute_network.vpc.id
    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.ssh_public_key_path)}"
  }
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      host = self.network_interface[0].access_config[0].nat_ip
      user = var.user
      timeout = "500s"
      private_key = file(var.ssh_private_key_path)
    }
    script = "install-salt-minion.sh"
  }
}
