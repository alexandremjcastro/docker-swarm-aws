Provisionamento de ambiente Docker Swarm na AWS utilizando Terraform e Ansible

# README EM CONSTRUÇÃO

==================
## Ferramentas

- Cluster Docker Swarm multi manager no Ubuntu 20.04.
- Provisionamento de ambiente na AWS (VPC,EC2,ELB,EFS) com Terraform.
- Instalação, configuração e deploy do cluster e aplicação com Ansible
- Uso do EFS para persistencia de dados e configuração.
- Traefik como proxy reverso junto com ELB para Load Balance.

### Pré-requisitos
Para executar o projeto, você precisará ter as ferramentas "[awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)", "[terraform](https://www.terraform.io/downloads)" e "[ansible](https://docs.ansible.com/ansible-tower/latest/html/quickinstall/prepare.html)" instaladas e configuradas no sistema. Em seguida é necessário acessar o arquivo `terraform.tfvars` e `backend.tf` para configurar todas variáveis necessárias para o provisonamento com Terraform.
Para execução do Ansible, você precisará acessar o arquvio de variável `ansible/deploy-stack/vars/main.yml` e configurar todas variáveis de acordo com sua necessidade.

## Executando
Para iniciar, primeiro clone este repositório:

```bash
git clone https://github.com/alexandremjcastro/docker-swarm-aws.git
```

Após o clone é necessário preencher alguns campos com as informações do seu ambiente AWS dentro do arquivo `backend.tf`.
O arquivo `terraform.tfvars ` possui variáveis que também precisam ser preenchidas para prosseguir com o provisionamento sem erros.

Dentro do diretório raiz do projeto, execute os comandos Terraform:

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

Após o Terraform finalizar a execução de todos passos, será exibido na tela o DNS Name do ELB. ÉÉ necessário criar um CNAME dentro do seu domínio externo apontando para o endereço do ELB. Com isso será possível acessar as aplicações balanceadas pelo ELB através do seu domínio.

Mude para o diretório `ansible` e execute o comando:

```bash
ansible-playbook -i hosts main.yml
```

OBS: Não se preocupe com o arquivo `hosts`, ele será criado e configurado automaticamente após a execução bem sucedida do Terraform.
