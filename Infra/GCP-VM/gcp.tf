#reserving static ip
resource "google_compute_address" "resume" {
  name = "self-hosted-resume"
}


#gcp vm
resource "google_compute_instance" "resume" {
  name         = "self-hosted-resume"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  tags = ["self-hosted", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-xenial-v20200317"
    }
  }


  network_interface {
    network = "default"

    access_config {
      // static IP
      nat_ip = "${google_compute_address.resume.address}"
    }
  }

  metadata = {
   ssh-keys = "apoorvshrivastava:${file("../../../ssh_porfolio/gcp.pub")}"
 }
}

output "instance_ip_addr" {
  value="${google_compute_address.resume.address}"
}