terraform {
  backend "gcs" {
    bucket = "terraform-state-folder" # The GCS bucket you created
    prefix = "wandb/terraform/state"  # Prefix used for state file naming
  }
}