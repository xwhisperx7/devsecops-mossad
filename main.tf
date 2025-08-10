terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

variable "remote_host" {}
variable "remote_user" {}
variable "private_key" {}

resource "null_resource" "deploy_app" {
  provisioner "remote-exec" {
    connection {
      host        = var.remote_host
      user        = var.remote_user
      private_key = var.private_key
    }
    inline = [
      "sudo mkdir -p /var/www/devsecops",
      "echo '<h1>Provisioned by Terraform</h1>' | sudo tee /var/www/devsecops/index.html"
    ]
  }
}