# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "google_sql_database_instance" "default" {
  database_version     = "MYSQL_8_0"
  deletion_protection  = true
  encryption_key_name  = null
  instance_type        = "CLOUD_SQL_INSTANCE"
  maintenance_version  = "MYSQL_8_0_31.R20231105.01_03"
  master_instance_name = null
  name                 = "diplom-instanse"
  project              = "seismic-vista-405108"
  region               = "us-central1"
  root_password        = null # sensitive
  settings {
    activation_policy           = "ALWAYS"
    availability_type           = "ZONAL"
    collation                   = null
    connector_enforcement       = "NOT_REQUIRED"
    deletion_protection_enabled = false
    disk_autoresize             = true
    disk_autoresize_limit       = 0
    disk_size                   = 10
    disk_type                   = "PD_SSD"
    edition                     = "ENTERPRISE"
    pricing_plan                = "PER_USE"
    tier                        = "db-f1-micro"
    time_zone                   = null
    user_labels                 = {}
    backup_configuration {
      binary_log_enabled             = false
      enabled                        = false
      location                       = null
      point_in_time_recovery_enabled = false
      start_time                     = "05:00"
      transaction_log_retention_days = 7
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }
    insights_config {
      query_insights_enabled  = false
      query_plans_per_minute  = 0
      query_string_length     = 0
      record_application_tags = false
      record_client_address   = false
    }
    ip_configuration {
      allocated_ip_range                            = null
      enable_private_path_for_google_cloud_services = false
      ipv4_enabled                                  = false
      private_network                               = "projects/seismic-vista-405108/global/networks/deploying-vpc"
      require_ssl                                   = false
      ssl_mode                                      = null
    }
    location_preference {
      follow_gae_application = null
      secondary_zone         = null
      zone                   = "us-central1-f"
    }
    maintenance_window {
      day          = 0
      hour         = 0
      update_track = null
    }
  }
  timeouts {
    create = null
    delete = null
    update = null
  }
}

# __generated__ by Terraform from "seismic-vista-405108/deploying-vpc/servicenetworking-googleapis-com"
resource "google_compute_network_peering" "servicenetworking-googleapis-com" {
  export_custom_routes                = true
  export_subnet_routes_with_public_ip = false
  import_custom_routes                = false
  import_subnet_routes_with_public_ip = false
  name                                = "servicenetworking-googleapis-com"
  network                             = "https://www.googleapis.com/compute/v1/projects/seismic-vista-405108/global/networks/deploying-vpc"
  peer_network                        = "https://www.googleapis.com/compute/v1/projects/h87923b4912e84e23p-tp/global/networks/servicenetworking"
  stack_type                          = "IPV4_ONLY"
  timeouts {
    create = null
    delete = null
    update = null
  }
}
