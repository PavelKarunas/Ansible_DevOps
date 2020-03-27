provider "google" {
  credentials = file("terraform-admin.json")
  project     = "${var.project}"
  region      = "${var.zone}"
}

#MAKING CONSUL SERVERS
resource "google_compute_instance" "default" {
  count    =  3
  name     =  "ubuntu${count.index}"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"
  network_interface {
    network = "default"
    access_config {
      
    }
  }

 tags = ["http-server","https-server"]
 boot_disk {
   initialize_params {
     type = "pd-ssd"
     image = "ubuntu-1804-bionic-v20200317"
     size = "30"
   }
}

  metadata = {
    sshKeys = "devops:${file("id_rsa.pub")}"
 }

 lifecycle {
    ignore_changes = ["attached_disk"]
  }

}
