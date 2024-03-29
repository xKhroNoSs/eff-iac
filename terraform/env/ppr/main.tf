terraform {
  required_providers {
    google = {
      version = "~> 5.21.0"
    }
  }

  required_version = "~> 1.7.5"
}

provider "google" {
  project     = "eastern-button-418009"
  region      = "europe-west1"
}

resource "google_project_service" "project" {
  project = "eastern-button-418009"
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_service_account" "default" {
  account_id   = "my-sa-1"
  display_name = "Mon service account test"
}

resource "google_service_account" "default_2" {
  account_id   = "my-sa-2"
  display_name = "Mon service account test 2"
}

resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  depends_on = [ google_project_service.project ]
}

resource "google_compute_instance" "default" {
  name         = "my-instance"
  machine_type = "e2-micro"
  zone         = "europe-west1-c"
  allow_stopping_for_update = true

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.test_subnet.name

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "sudo apt update && sudo apt install nginx"

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
    allow_stopping_for_update = true

    tags = ["foo", "bar"]

    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-12"
        labels = {
          my_label = "value"
        }
      }
    }

    network_interface {
      subnetwork = google_compute_subnetwork.test_subnet.name

      access_config {
        // Ephemeral public IP
      }
    }

    metadata = {
      foo = "bar"
    }

    metadata_startup_script = "sudo apt update && sudo apt install nginx"

    service_account {
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
      email  = google_service_account.default_2.email
      scopes = ["cloud-platform"]
    }
    depends_on = [ google_project_service.project ]
}

resource "google_compute_subnetwork" "test_subnet" {
  name          = "test-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = "europe-west1"
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }
}