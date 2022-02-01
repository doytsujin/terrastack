provider google {
  credentials = file("ccfs-igniters-sbx-002-ecb17f946e92.json")
  project = var.project
  region = var.region
  zone = var.zone
}
