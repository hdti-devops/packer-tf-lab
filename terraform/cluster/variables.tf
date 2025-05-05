variable "target_node" {
  type        = string
  description = "The target node to deploy the container on"
  default     = "domdev"
}
variable "hostname" {
  type        = string
  description = "The hostname of the container"
  default     = "test-container"
}
variable "vm_id" {
  type        = number
  description = "The VM ID of the container"
  default     = 0
}

variable "ostemplate" {
  type        = string
  description = "The OS template to use for the container"
  default     = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}

variable "password" {
  description = "The password for the container"
  sensitive   = true
  type        = string
  default     = "password"
}

variable "unprivileged" {
  description = "Whether the container is unprivileged"
  type        = bool
  default     = true
}

variable "onboot" {
  description = "Whether the container should start on boot"
  type        = bool
  default     = true
}
