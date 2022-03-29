prefix                 = "swarm"
vpc_cidr_block         = "10.80.0.0/22"
instances              = ["manager", "manager2", "worker1"]
instance_type          = "t2.micro" # Tipo de instancia a ser utilizada para os nós
key_name               = "" # Nome da chave SSH a ser criada dentro da AWS
key_pub                = "" # chave SSH pública do host utilizado para acesso aos servidores
instance_manager_nodes = ["manager2", "manager3"]
instances_workers      = ["worker2", "worker3", "worker1", "worker4", "worker5"]