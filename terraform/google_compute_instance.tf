resource "google_compute_instance" "default" {
  name                      = "my-instance"
  project                   = google_project.my_project.project_id
  machine_type              = "e2-micro"
  zone                      = var.default_zone
  allow_stopping_for_update = true
  tags                      = ["demo-vm-instance"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test_subnet.self_link

    access_config {
      nat_ip = google_compute_address.static1.address
    }
  }

  metadata = {
    foo      = "bar"
    ssh-keys = "cronos:ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBACM0mBmHGVPnRnfeCHkEL0HbVG+wtkMKZozXxB7aUVb3hjvoWy38GaqrfVXej4HXyVmi2vME5hoLHSQSyHBZRbHTgCSIki8AIGUZLWq1YogfKJJZuvO7vNIY3xuMc9mIbpP4qA11atFHuwe2LD0O9fDQhLUtJ7zJRY22MslNEPKy6rCAQ== cronos@cronos-desktop"
  }

  metadata_startup_script = "sudo apt update && sudo apt install -y nginx"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
  depends_on = [google_project_service.project]
}
