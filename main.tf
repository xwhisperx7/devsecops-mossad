terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
  }
}

# Variables que sí usamos desde el workflow
variable "remote_host"      { type = string }
variable "remote_user"      { type = string }
variable "private_key_path" { type = string }

resource "null_resource" "deploy_app" {
  provisioner "remote-exec" {
    connection {
      host        = var.remote_host
      user        = var.remote_user
      # Lee la clave desde el fichero proporcionado por el workflow
      private_key = file(var.private_key_path)
    }

    inline = [
      "sudo mkdir -p /var/www/devsecops",
      "echo '<h1>Provisioned by Terraform</h1>' | sudo tee /var/www/devsecops/index.html"
    ]
  }
}
