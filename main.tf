provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

data "google_client_config" "current" {}

provider "kubernetes" {
  host                   = "https://${module.wandb.cluster_endpoint}"
  cluster_ca_certificate = base64decode(module.wandb.cluster_ca_certificate)
  token                  = data.google_client_config.current.access_token
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.wandb.cluster_endpoint}"
    cluster_ca_certificate = base64decode(module.wandb.cluster_ca_certificate)
    token                  = data.google_client_config.current.access_token
  }
}

# Spin up all required services
module "wandb" {
  source  = "wandb/wandb/google"
  version = "9.4.1"

  namespace           = var.namespace
  license             = var.license
  domain_name         = var.domain_name
  subdomain           = var.subdomain
  deletion_protection = false
  create_redis        = true
  #use_internal_queue  = true
}

# You'll want to update your DNS with the provisioned IP address
