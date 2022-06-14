# Set variables to reuse them across the resources
# and enforce consistency.
variable project_id {
  type        = string
  default     = "openenv-n798h" 
}

variable region {
  type        = string
  default     = "us-east1" # Change this
}

variable zone {
  type        = string
  default     = "us-east1-b" # Change this
}

variable services {
  type        = list
  default     = [
    # List all the services you use here
    "cloudapis.googleapis.com", "cloudapis.googleapis.com", "compute.googleapis.com", "iam.googleapis.com","iamcredentials.googleapis.com","servicemanagement.googleapis.com","storage-api.googleapis.com", "dns.googleapis.com"
  ]
}

# Set the Terraform provider
provider "google" {
  project               = var.project_id
  region                = var.region
  zone                  = var.zone

  # Ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override
  user_project_override = true
}

# Use `gcloud` to enable:
# - serviceusage.googleapis.com
# - cloudresourcemanager.googleapis.com
resource "null_resource" "enable_service_usage_api" {
  provisioner "local-exec" {
    command = "/Users/pfischer/Documents/Development/opentlc/gcp-prep/google-cloud-sdk/bin/gcloud services enable serviceusage.googleapis.com cloudresourcemanager.googleapis.com --project ${var.project_id}"
  }

}

resource "time_sleep" "wait_project_init" {
  create_duration = "60s"

  depends_on = [null_resource.enable_service_usage_api]
}

# Enable other services used in the project
resource "google_project_service" "services" {
  for_each = toset(var.services)

  project                    = var.project_id
  service                    = each.key
  disable_dependent_services = false
  disable_on_destroy         = false

  depends_on = [time_sleep.wait_project_init]
}
