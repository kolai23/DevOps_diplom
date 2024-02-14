resource "google_compute_global_address" "private_ip_address" {
  name          = "private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 24
  network       = google_compute_network.vpc_deploying.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.vpc_deploying.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# resource "google_compute_network_peering" "servicenetworking-googleapis-com" {
#   export_custom_routes                = true
#   export_subnet_routes_with_public_ip = true
#   import_custom_routes                = true
#   import_subnet_routes_with_public_ip = false
#   name                                = "servicenetworking-googleapis-com"
#   network                             = google_compute_network.vpc_deploying.id
#   peer_network                        = google_service_networking_connection.private_vpc_connection.network
#   timeouts {
#     create = "10m"
#     update = "10m"
#     delete = "10m"
#   }
# }

resource "google_sql_database_instance" "sql_instanse_name" {
  name                = var.sql_instanse_name
  database_version    = var.sql_instanse_version
  region              = var.region
  project             = var.project_id
  deletion_protection = false
  depends_on          = [google_service_networking_connection.private_vpc_connection]
  settings {
    availability_type = "ZONAL"
    tier              = "db-f1-micro"
    ip_configuration {
      allocated_ip_range                            = null
      enable_private_path_for_google_cloud_services = false
      ipv4_enabled                                  = false
      private_network                               = google_compute_network.vpc_deploying.self_link
      require_ssl                                   = false
      ssl_mode                                      = null
    }
    location_preference {
      follow_gae_application = null
      secondary_zone         = null
      zone                   = var.sql_replica_zona
    }
  }
  timeouts {
    create = "20m"
    update = "20m"
    delete = "20m"
  }

}

# resource "google_sql_database_instance" "replica" {
#   name                = var.replica_name
#   database_version    = var.sql_instanse_version
#   project             = var.project_id
#   deletion_protection = false
#   depends_on          = [google_service_networking_connection.private_vpc_connection]

#   master_instance_name = google_sql_database_instance.sql_instanse_name.name

#   settings {
#     tier = "db-f1-micro"
#     ip_configuration {
#       allocated_ip_range                            = null
#       enable_private_path_for_google_cloud_services = false
#       ipv4_enabled                                  = false
#       private_network                               = google_compute_network.vpc_deploying.self_link
#       require_ssl                                   = false
#       ssl_mode                                      = null
#     }
# #   }

#   timeouts {
#     create = "20m"
#     update = "20m"
#     delete = "20m"
#   }

# }

resource "google_sql_database" "sql_database_name" {
  name      = var.sql_database_name
  instance  = google_sql_database_instance.sql_instanse_name.name
  charset   = "utf8"
  collation = "utf8_general_ci"
}

resource "google_sql_user" "users" {
  name     = var.sql_username
  instance = google_sql_database_instance.sql_instanse_name.name
  host     = "%"
  password = var.sql_password
}



output "ip_address" {
  value = google_sql_database_instance.sql_instanse_name.public_ip_address
}
output "priv_ip_address" {
  value = google_sql_database_instance.sql_instanse_name.private_ip_address
}

