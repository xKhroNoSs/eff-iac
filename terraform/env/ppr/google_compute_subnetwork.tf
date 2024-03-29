resource "google_compute_subnetwork" "test_subnet" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.default_region
  network       = google_compute_network.vpc_network.id
  project = google_project.my_project.project_id
}