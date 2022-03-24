module "aws_elb" {
  source  = "terraform-aws-modules/elb/aws"
  name = "swarm-terraform-elb"

  subnets         = [ for subnets in aws_subnet.subnets : subnets.id]
  security_groups = [aws_security_group.ec2.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    },
  ]

  health_check = {
    target              = "TCP:80"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  number_of_instances = "3"
  instances           = [module.ec2_instance_manager.id, module.ec2_instance_manager_nodes[var.instance_manager_nodes[0]].id, module.ec2_instance_manager_nodes[var.instance_manager_nodes[1]].id]
}