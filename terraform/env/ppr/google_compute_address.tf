resource "google_compute_address" "static1" {
  project = google_project.my_project.project_id
  name = "ipv4-address"
}

resource "google_compute_address" "static2" {
  project = google_project.my_project.project_id
  name = "ipv4-address2"
  depends_on = [  ]
}