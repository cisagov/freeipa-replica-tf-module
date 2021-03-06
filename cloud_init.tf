# cloud-init commands for configuring a freeipa replica

data "template_cloudinit_config" "cloud_init_tasks" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/download-certificates.py", {
        cert_bucket_name   = var.cert_bucket_name
        cert_read_role_arn = var.cert_read_role_arn
        server_fqdn        = var.hostname
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/convert_certificates.sh", {
        cert_pw = var.cert_pw
    })
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile(
      "${path.module}/cloud-init/setup_freeipa.sh", {
        admin_pw        = var.admin_pw
        cert_pw         = var.cert_pw
        hostname        = var.hostname
        master_hostname = var.master_hostname
    })
  }
}
