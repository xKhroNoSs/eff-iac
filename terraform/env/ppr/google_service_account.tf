resource "google_service_account" "default" {
  account_id   = "my-sa-1"
  display_name = "Mon service account test"
  project = google_project.my_project.project_id
}

resource "google_service_account" "default_2" {
  account_id   = "my-sa-2"
  display_name = "Mon service account test 2"
  project = google_project.my_project.project_id
}
