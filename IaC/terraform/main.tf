resource "google_compute_network" "vpc_bastion" {
  auto_create_subnetworks                   = false
  delete_default_routes_on_create           = false
  description                               = null
  enable_ula_internal_ipv6                  = false
  internal_ipv6_range                       = null
  mtu                                       = 1460
  name                                      = var.vpc_bastion
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  project                                   = var.project_name
  routing_mode                              = "REGIONAL"
}


resource "google_compute_network" "vpc_deploying" {
  auto_create_subnetworks                   = false
  delete_default_routes_on_create           = false
  description                               = null
  enable_ula_internal_ipv6                  = false
  internal_ipv6_range                       = null
  mtu                                       = 1460
  name                                      = var.vpc_deploying
  network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
  project                                   = var.project_name
  routing_mode                              = "REGIONAL"
}

resource "google_compute_subnetwork" "bastion_subnet" {
  description                = null
  external_ipv6_prefix       = null
  ip_cidr_range              = var.ip_cidr_bastion
  ipv6_access_type           = null
  name                       = var.bastion_subnet
  network                    = google_compute_network.vpc_bastion.id
  private_ip_google_access   = false
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.project_name
  purpose                    = "PRIVATE"
  region                     = var.region
  role                       = null
  secondary_ip_range         = []
  stack_type                 = "IPV4_ONLY"
}

resource "google_compute_subnetwork" "deploying_private_subnet" {
  description                = null
  ip_cidr_range              = var.ip_cidr_deploying_private
  name                       = var.private_subnet
  network                    = google_compute_network.vpc_deploying.id
  private_ip_google_access   = true
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.project_name
  purpose                    = "PRIVATE"
  region                     = var.region
  stack_type                 = "IPV4_ONLY"
  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.51.0.0/16"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/16"
  }
}

resource "google_compute_subnetwork" "deploying_public_subnet" {
  description                = null
  ip_cidr_range              = var.ip_cidr_deploying_public
  name                       = var.public_subnet
  network                    = google_compute_network.vpc_deploying.id
  private_ip_google_access   = false
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"
  project                    = var.project_name
  purpose                    = "PRIVATE"
  secondary_ip_range         = []
  region                     = var.region
  stack_type                 = "IPV4_ONLY"

}

resource "google_compute_router" "router_bastion" {
  project = var.project_name
  name    = var.router_bastion
  network = google_compute_network.vpc_bastion.id
  region  = var.region

}

resource "google_compute_router" "router_deploing" {
  project = var.project_name
  name    = var.router_deploing
  network = google_compute_network.vpc_deploying.id
  region  = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = var.nat_name
  router                             = google_compute_router.router_bastion.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

resource "google_compute_network_peering" "bastion-deploying-peering" {
  export_custom_routes                = false
  export_subnet_routes_with_public_ip = true
  import_custom_routes                = false
  import_subnet_routes_with_public_ip = false
  name                                = var.bastion_deploying_peering
  network                             = google_compute_network.vpc_bastion.id
  peer_network                        = google_compute_network.vpc_deploying.id
  stack_type                          = "IPV4_ONLY"
}

resource "google_compute_network_peering" "deploying-bastion-peering" {
  export_custom_routes                = false
  export_subnet_routes_with_public_ip = true
  import_custom_routes                = false
  import_subnet_routes_with_public_ip = false
  name                                = var.deploying_bastion_peering
  network                             = google_compute_network.vpc_deploying.id
  peer_network                        = google_compute_network.vpc_bastion.id
  stack_type                          = "IPV4_ONLY"
}


