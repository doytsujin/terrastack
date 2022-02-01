resource "google_compute_firewall" "allow" {
  for_each = {
    ssh = "22"
    http = "80"
  }
  name = "poulsen-allow-${each.key}"
  network = google_compute_network.vpc.id
  allow {
    protocol = "tcp"
    ports = [each.value]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}

resource "google_compute_firewall" "allow_saltstack" {
  name = "poulsen-allow-saltstack"
  network = google_compute_network.vpc.id

  allow {
    protocol = "tcp"
    ports = ["4505", "4506"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}
