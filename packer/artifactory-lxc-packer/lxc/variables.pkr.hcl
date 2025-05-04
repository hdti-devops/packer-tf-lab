variable "ubuntu_version" {
  description = "The version of Ubuntu to use for the LXC container."
  type        = string
  default     = "jammy" # "focal" for Ubuntu 20.04, "lunar" for ubuntu 24.04
}

variable "software_name" {
  description = "The name of the software to be installed in the LXC container."
  type        = string
  default     = "artifactory"
}