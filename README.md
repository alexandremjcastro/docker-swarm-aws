# Provisionamento de ambiente Docker Swarm na AWS utilizando Terraform e Ansible

## Ferramentas

- Cluster Docker Swarm multi manager no Ubuntu 20.04.
- Provisionamento de ambiente na AWS (VPC,EC2,ELB,EFS) com Terraform.
- Instalação, configuração e deploy do cluster e aplicação com Ansible
- Uso do EFS para persistencia de dados e configuração.
- Traefik como proxy reverso junto com ELB para Load Balance.

### Pré-requisitos
Para executar o projeto, você precisará ter as ferramentas "[awscli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)", "[terraform](https://www.terraform.io/downloads)" e "[ansible](https://docs.ansible.com/ansible-tower/latest/html/quickinstall/prepare.html)" instaladas e configuradas no sistema. 

## Executando
1. Para iniciar, primeiro clone este repositório:

```bash
git clone https://github.com/alexandremjcastro/docker-swarm-aws.git
```

2. Após o clone é necessário preencher alguns campos com as informações do seu ambiente AWS dentro do arquivo `backend.tf`.
O arquivo `terraform.tfvars ` possui variáveis que também precisam ser preenchidas para prosseguir com o provisionamento sem erros.

3. Dentro do diretório raiz do projeto, execute os comandos Terraform:

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

4. Após o Terraform finalizar a execução de todos passos, será exibido na tela o DNS Name do ELB. 
É necessário criar um CNAME dentro do seu domínio externo apontando para o endereço do ELB. Com isso será possível acessar as aplicações balanceadas pelo ELB através do seu domínio.

5. Para executar os playbooks do ansible, primeiramente preencha os valores das variáveis dentro do arquivo `ansible/roles/deploy-stack/vars/main.yml`.

6. Após preenchimento de todas variáveis, retorne até o diretório `ansible` e execute os playbooks com o comando: `ansible-playbook -i hosts main.yml`. 

```bash
ansible-playbook -i hosts main.yml
```

Não se preocupe em configurar o arquivo `hosts`, ele é criado e configurado automaticamente após a execução bem sucedida do terraform.

7. Assim que o ansible finalizar a execução dos playbooks, conecte ao nó manager principal (IP localizado dentro do arquivo hosts). Se todos os playbooks foram executados com sucesso, é possível visualizar os services provisionados dentro do cluster com o comando: docker service ls

8. Após a validação que todos serviços estão ok, é possível acessar a URL configurada dentro do arquivo `ansible/roles/deploy-stack/vars/main.yml` com o path `/index.php`. Exemplo: `dominio.exemplo.com/index.php`
