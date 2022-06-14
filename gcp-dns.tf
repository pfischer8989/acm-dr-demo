resource "google_dns_managed_zone" "ocp-zone" {
  name        = "ocpus1"
  dns_name    = "catdevnull.us."
  description = "OCP US demo DNS"
  visibility = "public"

}
