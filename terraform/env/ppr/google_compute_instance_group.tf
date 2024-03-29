resource "google_compute_instance_group" "webservers" {
  name        = "terraform-webservers"
  description = "Terraform test instance group"
  project = google_project.my_project.project_id

  instances = [
    google_compute_instance.default.id,
    google_compute_instance.default_2.id,
  ]

  named_port {
    name = "http"
    port = "80"
  }

  zone = "europe-west1-c"
}