packer {
  required_plugins {
    lxc = {
      version = ">= 1.0.2"
      source  = "github.com/hashicorp/lxc"
    }
  }
}