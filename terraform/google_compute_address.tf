resource "google_compute_address" "static1" {
  project = google_project.my_project.project_id
  name    = "ipv4-address"
}
