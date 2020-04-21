// Configure the Google Cloud provider
provider "google" {
 credentials = file("../../../gcp.json")
 project     = "banded-chimera-272109"
 region      = "us-central1"
}