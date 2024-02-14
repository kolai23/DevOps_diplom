data "google_compute_image" "debian_image" {
  family  = var.family_image
  project = var.project_image
}

resource "google_compute_instance" "jenkins-instance" {
  tags         = ["http-server", "https-server"]
  zone         = "us-central1-a"
  machine_type = var.machine_type
  name         = "jenkins-vm-instance"

  boot_disk {
    auto_delete = true
    
    initialize_params {
      image = data.google_compute_image.debian_image.self_link
      size  = var.size_disk
      type  = var.disk_type
    }

  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  metadata = {
    startup-script = "sudo apt update\nsudo apt install fontconfig openjdk-17-jre\nsudo wget -O /usr/share/keyrings/jenkins-keyring.asc \\\n  https://pkg.jenkins.io/debian/jenkins.io-2023.key\necho deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \\\n  https://pkg.jenkins.io/debian binary/ | sudo tee \\\n  /etc/apt/sources.list.d/jenkins.list > /dev/null\nsudo apt-get update\nsudo apt-get install jenkins\nsudo systemctl enable jenkins\nsudo systemctl start jenkins"
  }

  network_interface {

    dynamic "access_config" {
      for_each = var.enable_public_ip == true ? [1] : []

      content {
        network_tier = "PREMIUM"
      }
    }
    queue_count = 0
    stack_type  = "IPV4_ONLY"
    network = google_compute_network.vpc_deploying.self_link
    subnetwork  = google_compute_subnetwork.deploying_private_subnet.self_link
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }
}
