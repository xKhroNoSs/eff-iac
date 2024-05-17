resource "google_project_service" "project" {
  service = "compute.googleapis.com"
  project = google_project.my_project.project_id

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}
