resource "proxmox_lxc" "basic" {

  target_node  = var.target_node
  hostname     = var.hostname
  vmid         = var.vm_id
  ostemplate   = var.ostemplate
  password     = var.password
  unprivileged = var.unprivileged
  onboot       = var.onboot

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }

}