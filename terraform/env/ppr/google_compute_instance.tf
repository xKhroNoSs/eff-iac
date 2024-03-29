resource "google_compute_instance" "default" {
  name         = "my-instance"
  project = google_project.my_project.project_id
  machine_type = "e2-micro"
  zone         = "europe-west1-c"
  allow_stopping_for_update = true
  tags         = ["demo-vm-instance"]

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
    foo = "bar"
  }

  metadata_startup_script = "sudo apt update && sudo apt install -y nginx"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
    depends_on = [ google_project_service.project ]
}

resource "google_compute_instance" "default_2" {
    name         = "my-instance2"
    machine_type = "e2-micro"
    zone         = "europe-west1-c"
    project = google_project.my_project.project_id
    allow_stopping_for_update = true
    tags         = ["demo-vm-instance"]

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
      nat_ip = google_compute_address.static2.address
    }
    }

    metadata = {
      foo = "bar"
    }

    metadata_startup_script = "sudo apt update && sudo apt install -y nginx"

    service_account {
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      email  = google_service_account.default_2.email
      scopes = ["cloud-platform"]
    }
    depends_on = [ google_project_service.project ]
}