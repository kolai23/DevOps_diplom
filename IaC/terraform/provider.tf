provider "google" {
  credentials = "./vabischevich-terraform.json"
  project     = var.project_name
  region      = var.region
}
