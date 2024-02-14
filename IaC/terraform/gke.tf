# GKE cluster
resource "google_container_cluster" "diplom_gke" {
  name                     = var.k8s_cluster_name
  location                 = var.region_k8s
  node_locations           = var.zone_k8s
  remove_default_node_pool = true
  network                  = google_compute_network.vpc_deploying.self_link
  subnetwork               = google_compute_subnetwork.deploying_private_subnet.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"
  initial_node_count = 1

  addons_config {
    http_load_balancing {
      disabled = true
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }
  release_channel {
    channel = "REGULAR"
  }

}

resource "google_container_node_pool" "frontend" {
  name               = "frontend"
  location           = "us-central1-a, us-central1-b"
  cluster            = google_container_cluster.diplom_gke.id
  initial_node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    labels = {
      team = "frontend"
    }

    taint {
      key    = "instance_type"
      value  = "frontend"
      effect = "NO_SCHEDULE"
    }
  }
}

resource "google_container_node_pool" "backend" {
  name               = "backend"
  location           = "us-central1-a, us-central1-b"
  cluster            = google_container_cluster.diplom_gke.id
  initial_node_count = 1
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  node_config {
    preemptible  = true
    machine_type = "e2-small"

    labels = {
      team = "backend"
    }

    taint {
      key    = "instance_type"
      value  = "backend"
      effect = "NO_SCHEDULE"
    }
  }
}
