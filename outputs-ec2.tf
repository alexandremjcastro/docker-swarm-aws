locals {
    manager = module.ec2_instance_manager.public_ip
    manager_nodes = join("\n",[for ec2 in module.ec2_instance_manager_nodes: ec2.public_ip])
    workers = join("\n",[for ec2 in module.ec2_instance_worker_nodes: ec2.public_ip])
    hosts = <<HOSTS
[manager]
${local.manager}
[managernodes]
${local.manager_nodes}
[worker]
${local.workers}
[all]
[all:vars]
ansible_ssh_private_key_file='~/.ssh/id_rsa'
ansible_user=ubuntu
HOSTS    
}

resource "local_file" "hosts" {
    filename = "ansible/hosts"
    content = "${local.hosts}"
}