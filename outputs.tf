output master_ip {
  value = google_compute_instance.salt_master.network_interface.0.access_config.0.nat_ip
}
output minion_ip {
  value = google_compute_instance.salt_minion.network_interface.0.access_config.0.nat_ip
}