locals {
  efs_dns_name = resource.aws_efs_mount_target.efs-mt.dns_name
  efs         = <<EOF
#vars file defaults for deploy-app
efs_hostname: ${local.efs_dns_name}
EOF    
}

resource "local_file" "efs" {
  filename = "ansible/roles/deploy-stack/defaults/main.yaml"
  content  = local.efs
}