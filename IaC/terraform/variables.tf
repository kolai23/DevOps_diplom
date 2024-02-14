#-----------IMAGE------------

variable "region" {
  default = "us-central1"
}
variable "project_name" {
  default = "seismic-vista-405108"
}
variable "project_id" {
  default = "seismic-vista-405108"
}

variable "zone" {
  default = ["us-central1-a", "us-central1-b"]
}

variable "machine_type" {
  type    = string
  default = "e2-small"
}

variable "size_disk" {
  type    = number
  default = 10
}

variable "family_image" {
  default = "debian-11"
}

variable "project_image" {
  default = "debian-cloud"
}

variable "disk_type" {
  default = "pd-standard"
}

variable "enable_public_ip" {
  type    = bool
  default = true
}

#------------NETWORK------------
variable "vpc_bastion" {
  type    = string
  default = "bastion-vpc"
}

variable "vpc_deploying" {
  type    = string
  default = "deploying-vpc"
}

variable "ip_cidr_bastion" {
  type    = string
  default = "192.168.0.0/16"
}

variable "bastion_subnet" {
  type    = string
  default = "bastion-subnet"
}

variable "ip_cidr_deploying_private" {
  type    = string
  default = "172.32.1.0/24"
}

variable "ip_cidr_deploying_public" {
  type    = string
  default = "172.32.2.0/24"
}

variable "private_subnet" {
  type    = string
  default = "private-subnet"
}

variable "public_subnet" {
  type    = string
  default = "public-subnet"
}

variable "bastion_deploying_peering" {
  type    = string
  default = "bastion-deploying-peering"
}

variable "deploying_bastion_peering" {
  type    = string
  default = "deploying-bastion-peering"
}

variable "router_bastion" {
  type    = string
  default = "router-bastion"
}

variable "router_deploing" {
  type    = string
  default = "router-deploing"
}

variable "nat_name" {
  type    = string
  default = "my-router-nat"
}



#-----------K8S--------------
variable "zone_k8s" {
  default = ["us-central1-a", "us-central1-b"]
}

variable "region_k8s" {
  default = "us-central1"
}

variable "k8s_cluster_name" {
  default = "diplom-gke"
}

variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 3
  description = "number of gke nodes"
}


#------------SQL-------------
variable "sql_instanse_version" {
  type    = string
  default = "MYSQL_8_0"
}
variable "replica_name" {
  type    = string
  default = "replica-instanse"
}

variable "sql_instanse_name" {
  type    = string
  default = "diplom-instanse"
}

variable "sql_instanse_zona" {
  type    = string
  default = "us-central1-a"
}

variable "sql_replica_zona" {
  type    = string
  default = "us-central1-b"
}

variable "sql_database_name" {
  type    = string
  default = "diplom-database"
}

variable "sql_username" {
  default     = "root"
  description = "sql username"
}

variable "sql_password" {
  default     = "123!@#qweASD"
  description = "sql password"
}

