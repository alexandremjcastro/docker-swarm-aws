resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "efs-cluster-swarm"
  }
}

resource "aws_efs_mount_target" "efs-mt" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.subnets[0].id
  security_groups = [aws_security_group.efs.id]
}