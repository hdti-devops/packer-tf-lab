terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc8"
    }
  }
}
provider "proxmox" {
  pm_api_url      = "https://domdev.duckdns.org:8006/api2/json"
  pm_tls_insecure = true                 # By default Proxmox Virtual Environment uses self-signed certificates.
  pm_user         = "terraform-prov@pve" # Add your Proxmox username here
  pm_password     = "montreal514"        # Add your Proxmox password here
  # pm_password     = "89e32f84-b20a-4afa-8a51-f4dc29e2c9c8" # Add your Proxmox password here
}


