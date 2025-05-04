
source "lxc" "custom_lxc" {

  # name                      = "${var.software_name}-lxc"
  config_file               = "${path.root}/lxc-configs/${var.software_name}.conf"
  template_name             = "ubuntu"
  template_environment_vars = ["SUITE=${var.ubuntu_version}"]
}

build {

  name    = "${var.software_name}-lxc"
  sources = ["source.lxc.custom_lxc"]

  provisioner "shell" {
    script = "scripts/${var.software_name}.sh"
  }

  post-processor "compress" {
    output = "${var.software_name}-lxc-template.tar.gz"
    format = "tar"
  }
}