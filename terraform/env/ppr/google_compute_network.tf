resource "google_compute_network" "vpc_network" {
  project = google_project.my_project.project_id
  name = "vpc-network"
  depends_on = [ google_project_service.project ]
}
